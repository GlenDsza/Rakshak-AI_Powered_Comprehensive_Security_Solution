import sys
import time
import base64
import uvicorn
import cv2
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.websockets import WebSocketState
from multiprocessing import Process, Queue, Event, Lock
import asyncio
from concurrent.futures import ThreadPoolExecutor
from video_cache import attempt_cache_src
from config import PREVENT_FRAME_OVERFLOW, LSTM_FRAME_REGISTER_EVERY_N_FRAME, DETECT_EVERY_N_FRAME, MAX_CONSECUTIVE_FRAME_FAILURES


app = FastAPI()


def is_websocket_alive(websocket: WebSocket):
    if websocket is None:
        return False
    return (websocket.client_state == WebSocketState.CONNECTED or websocket.client_state == WebSocketState.CONNECTING)

# Function to read video stream and perform detection
# Note, we can't pass websocket to this fn as its pickled & passed to a completely new process


def process_video_stream(url, cctv_id: str, cctv_type: str, output_queue: Queue, shutdown_event: Event, violence: bool, climbing: bool, weapons: bool, suspicious: bool, accidents: bool, fire: bool, crack: bool, tamper: bool, face: bool):
    # Importing here, coz this fn will be run in a separate process
    from models.yolo_objects import detect_objects, detect_objects_dummy
    if weapons:
        from models.weapons import detect_weapons, detect_weapons_dummy
    if accidents:
        from models.accident import detect_accident, detect_accident_dummy
    if face:
        from models.face import detect_face, detect_face_dummy
    if violence:
        from models.fight import detect_fight, detect_fight_dummy
    if climbing or suspicious:
        from models.anomaly_lstm import detect_anomaly, detect_anomaly_dummy
    if fire:
        from models.fire import detect_fire, detect_fire_dummy
    if crack:
        from models.crack import detect_crack, detect_crack_dummy
    if tamper:
        from models.tamper import detect_tamper, detect_temper_dummy

    from incident_manager import IncidentManager, IncidentType
    from config import MIN_ACCIDENT_REPORT_CONF, MIN_VIOLENCE_REPORT_CONF, MIN_WEAPON_REPORT_CONF, MIN_FIRE_REPORT_CONF, MIN_CRACK_REPORT_CONF

    cap = cv2.VideoCapture(url)
    incident_manager = IncidentManager(cctv_id)

    consecutiveFrameFailures = 0
    framecount = -1

    prev_detections = {
        'fight': None,
        'anomalies': None,
        'objects': None,
        'weapons': None,
        'accidents': None,
        'fire': None,
        'crack': None,
        'tamper': None,
        'face': None,
    }

    try:
        with ThreadPoolExecutor() as executor:
            while not shutdown_event.is_set():
                try:
                    framecount += 1
                    if framecount >= PREVENT_FRAME_OVERFLOW:
                        framecount = 0

                    ret, frame = cap.read()
                    if not ret:
                        break

                    detections = prev_detections.copy()

                    # Use threads to parallelize detection tasks

                    fight_future = None
                    anomaly_future = None
                    objects_future = None
                    weapons_future = None
                    fire_future = None
                    crack_future = None
                    accidents_future = None
                    tamper_future = None
                    face_future = None

                    # LSTM models
                    # Some Model need continuous frames (@TODO - control it using time.time())
                    if framecount % LSTM_FRAME_REGISTER_EVERY_N_FRAME == 0:
                        if violence:
                            fight_future = executor.submit(detect_fight, frame)
                            # fight_future = executor.submit(detect_fight_dummy, frame)

                        if climbing or suspicious:
                            anomaly_future = executor.submit(
                                detect_anomaly, frame)
                            # anomaly_future = executor.submit(detect_anomaly_dummy, frame)

                    # Frame-independent models
                    # Single frame detection are updated every {DETECT_EVERY_N_FRAME} frames
                    if framecount % DETECT_EVERY_N_FRAME == 0:
                        if face:
                            face_future = executor.submit(detect_face, frame)
                            # face_future = executor.submit(detect_face_dummy, frame)

                    if framecount % DETECT_EVERY_N_FRAME == 0:
                        # Use threads to parallelize detection tasks
                        objects_future = executor.submit(detect_objects, frame)
                        # objects_future = executor.submit(detect_objects_dummy, frame)

                        if tamper:
                            tamper_future = executor.submit(detect_tamper, frame)

                        if accidents:
                            accidents_future = executor.submit(
                                detect_accident, frame)

                        if weapons:
                            weapons_future = executor.submit(
                                detect_weapons, frame)
                            # weapons_future = executor.submit(detect_weapons_dummy, frame)

                        if fire:
                            fire_future = executor.submit(
                                detect_fire, frame)
                            # fire_future = executor.submit(detect_fire_dummy, frame)
                        
                        if crack:
                            crack_future = executor.submit(
                                detect_crack, frame)
                            # crack_future = executor.submit(detect_crack_dummy, frame)

                        # climber_future = executor.submit(detect_climber, frame)
                        # # climber_future = executor.submit(detect_climber_dummy, frame)

                    if face_future is not None:
                        detections['face'] = face_future.result()

                        # Report incident for fire if applicable
                        if detections['face'] is not None and len(detections['face']) > 0:
                            incident_manager.registerDetections(
                                frame, cctv_id, cctv_type, IncidentType.face, detections['face'])

                    # Wait for all frame-independent threads to complete
                    if tamper_future is not None:
                        detections['tamper'] = tamper_future.result()

                        # Report incident for fire if applicable
                        if detections['tamper'] is not None and 'tamper' in detections['tamper'] and detections['tamper']['tamper']:
                            incident_manager.registerDetections(
                                frame, cctv_id, cctv_type, IncidentType.fire, detections['tamper'])

                    if objects_future is not None:
                        detections['objects'] = objects_future.result()

                    if fire_future is not None:
                        detections['fire'] = fire_future.result()

                        # Report incident for fire if applicable
                        if detections['fire'] is not None and len(detections['fire']) > 0:
                            for prediction in detections['fire']:
                                if prediction['label'] == "fire" and prediction['confidence'] >= MIN_FIRE_REPORT_CONF:
                                    incident_manager.registerDetections(
                                        frame, cctv_id, cctv_type, IncidentType.fire, detections['fire'])
                                    break

                    if crack_future is not None:
                        detections['crack'] = crack_future.result()

                        # Report incident for crack if applicable
                        if detections['crack'] is not None and len(detections['crack']) > 0:
                            for prediction in detections['crack']:
                                if (prediction['label'] == "severe_crack") or (prediction['label'] == "normal_crack" and prediction['confidence'] >= MIN_CRACK_REPORT_CONF):
                                    incident_manager.registerDetections(
                                        frame, cctv_id, cctv_type, IncidentType.crack, detections['crack'])
                                    break

                    if accidents_future is not None:
                        detections['accidents'] = accidents_future.result()

                        # Report incident for accident if applicable
                        if detections['accidents'] is not None and len(detections['accidents']) > 0:
                            for prediction in detections['accidents']:
                                if prediction['label'] == "Accident" and prediction['confidence'] >= MIN_ACCIDENT_REPORT_CONF:
                                    incident_manager.registerDetections(
                                        frame, cctv_id, cctv_type, IncidentType.accident, detections['accidents'])
                                    break

                    if weapons_future is not None:
                        detections['weapons'] = weapons_future.result()

                        # Report incident for weapon if applicable
                        if detections['weapons'] is not None and len(detections['weapons']) > 0:
                            for prediction in detections['weapons']:
                                if prediction['confidence'] >= MIN_WEAPON_REPORT_CONF:
                                    incident_manager.registerDetections(
                                        frame, cctv_id, cctv_type, IncidentType.weapons, detections['weapons'])
                                    break

                    # Wait for all LSTM threads to complete
                    if anomaly_future is not None:
                        detections['anomalies'] = anomaly_future.result()

                        # Report incident for anomalies if applicable
                        if detections['anomalies'] is not None and detections['anomalies']['climbing']:
                            incident_manager.registerDetections(
                                frame, cctv_id, cctv_type, IncidentType.climber, [])  # Nothing to draw here
                        if detections['anomalies'] is not None and detections['anomalies']['suspicious']:
                            incident_manager.registerDetections(
                                frame, cctv_id, cctv_type, IncidentType.suspicious, [])  # Nothing to draw here

                    if fight_future is not None:
                        detections['fight'] = fight_future.result()

                        # Report incident for fight if applicable
                        if detections['fight'] is not None and detections['fight']['prediction_confidence'] > MIN_VIOLENCE_REPORT_CONF and detections['fight']['prediction_label'] == 'fight':
                            incident_manager.registerDetections(
                                frame, cctv_id, cctv_type, IncidentType.violence, [])  # Nothing to draw here

                    prev_detections = detections

                    # Convert the original frame to JPEG format and encode it in Base64
                    _, buffer = cv2.imencode('.jpg', frame)
                    image_data_base64 = base64.b64encode(
                        buffer.tobytes()).decode('utf-8')

                    # print("Send detections", detections)
                    output_queue.put(
                        {"frame": image_data_base64, "detections": detections})

                except Exception as e:
                    print("Error", e)
                    consecutiveFrameFailures += 1
                    if consecutiveFrameFailures >= MAX_CONSECUTIVE_FRAME_FAILURES:
                        print("Max consecutive frame failures reached, exiting")
                        break
            print(f"Wrap up due to shutdown event set for {cctv_id}")
    finally:
        output_queue.put(-1)
        cap.release()
        # sys.exit()
        # pass


# WebSocket endpoint to handle communication with the React client


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket, stream_url: str, cctv_id: str, cctv_type: str, violence: bool, climbing: bool, weapons: bool, suspicious: bool, accidents: bool, fire: bool, crack: bool, tamper: bool, face: bool):
    print("Websocket connection initiated", {
        "stream_url": stream_url,
        "cctv_id": cctv_id,
        "cctv_type": cctv_type,
        "violence": violence,
        "climbing": climbing,
        "weapons": weapons,
        "suspicious": suspicious,
        "accident": accidents,
        "fire": fire,
        "tamper": tamper,
        "face": face,
    })
    try:
        print("Wait for connection acceptance", cctv_id)
        # Set your desired timeout value in seconds
        await asyncio.wait_for(websocket.accept(), timeout=10)
        print("Connection accepted for", cctv_id)
    except asyncio.TimeoutError:
        print("Timeout waiting for connection acceptance")
        return
    except Exception as e:
        print("Error", e)
        return

    output_queue = Queue()
    shutdown_event = Event()

    async def shutdown():
        try:
            print("Shutdown event triggered")
            shutdown_event.set()
            print("Shutdown event set")
            await websocket.close()
            print("Websocket closed")
        except:
            pass

    async def fastapi_app_shutdown():
        print("Fast API app shutdown event triggered")
        await shutdown()
        print("Fast API app shutdown event completed")

    app.add_event_handler("shutdown", fastapi_app_shutdown)

    stream_url = attempt_cache_src(stream_url)
    print("Finalised stream URL", stream_url)

    # Start the video processing in a separate process
    video_process = Process(target=process_video_stream, args=(
        stream_url, cctv_id, cctv_type, output_queue, shutdown_event, violence, climbing, weapons, suspicious, accidents, fire, crack, tamper, face))
    video_process.start()

    print(f"Started process {video_process._identity} for", stream_url)
    current_time = time.time()

    try:
        while is_websocket_alive(websocket) and not shutdown_event.is_set():
            # Initial pre processing for 10 seconds
            # if  time.time() - current_time < 10:
            #     await asyncio.sleep(1)
            #     continue

            # Get the latest frame and detections from the output queue
            result = output_queue.get()

            if result == -1:
                print("Received -1 from queue, exiting")
                break

            # print(f"{cctv_id} >> Sending frame to client")
            # Send message with detections to the client
            await websocket.send_json(result)

            # Introduce a small delay to control the frame rate
            await asyncio.sleep(0.01)
        print("Websocket is died")
    except WebSocketDisconnect:
        print(f"Client disconnected for {cctv_id}")
    except Exception as e:
        print("Error Managing socket", e)
        pass
    finally:
        print(f"Terminate process {video_process._identity} for", stream_url)
        video_process.terminate()
        await websocket.close()
        # try:
        #     await websocket.close()
        # except Exception as e:
        #     print("Error closing websocket", e)


# Run the FastAPI server
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=5005)
