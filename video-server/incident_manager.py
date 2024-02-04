from datetime import datetime, timedelta
import io
import json
import os
import random
import threading
import time
import boto3
import cv2
from config import AWS_KEY, SECRET_KEY_AWS, S3_BUCKET_NAME
from models.utils.yolo import draw_bounding_boxes
from apis import create_incident
from config import REGISTER_INCIDENT, THROTTLE_INCIDENT_REPORT_TIME

s3 = boto3.resource(
    service_name='s3',
    aws_access_key_id=f"{AWS_KEY}",
    aws_secret_access_key=f"{SECRET_KEY_AWS}"
)
bucket = s3.Bucket(S3_BUCKET_NAME)


class IncidentType():
    weapons = 'weapons'
    violence = 'violence'
    overcrowd = 'overcrowd'
    accident = 'accident'
    climber = 'climber'
    suspicious = 'suspicious'
    fire = 'fire'
    crack = 'crack'
    tamper = 'tamper'
    face = 'face'


incident_meta_data = {
    IncidentType.weapons: {
        'title': "Weapons Detected",
    },
    IncidentType.violence: {
        'title': "Violence Detected",
    },
    IncidentType.overcrowd: {
        'title': "Overcrowding Detected",
    },
    IncidentType.accident: {
        'title': "Accident Detected",
    },
    IncidentType.climber: {
        'title': "Prisoner escaping detected",
    },
    IncidentType.suspicious: {
        'title': "Suspicious activity detected",
    },
    IncidentType.fire: {
        'title': "Fire detected",
    },
    IncidentType.crack: {
        'title': "Crack detected in prison wall",
    },
    IncidentType.tamper: {
        'title': "Tampering detected with CCTV",
    },
    IncidentType.face: {
        'title': "Wanted criminal spotted",
    },
}

if not os.path.exists("logs"):
    os.makedirs("logs")

class IncidentManager:
    def __init__(self, identifier: str):
        self.data_file = f"logs/incident_data_{identifier}.json"
        self.incident_map = self.load_data()

    def load_data(self):
        try:
            with open(self.data_file, 'r') as file:
                data = json.load(file)
                # Convert the datetime strings back to datetime objects
                for detection_type, cctv_data in data.items():
                    for cctv_id, (recorded_time_str, detection) in cctv_data.items():
                        data[detection_type][cctv_id] = (
                            datetime.fromisoformat(recorded_time_str), detection)
                if IncidentType.weapons not in data:
                    data[IncidentType.weapons] = {}
                if IncidentType.violence not in data:
                    data[IncidentType.violence] = {}
                if IncidentType.overcrowd not in data:
                    data[IncidentType.overcrowd] = {}
                if IncidentType.accident not in data:
                    data[IncidentType.accident] = {}
                if IncidentType.climber not in data:
                    data[IncidentType.climber] = {}
                if IncidentType.suspicious not in data:
                    data[IncidentType.suspicious] = {}
                if IncidentType.fire not in data:
                    data[IncidentType.fire] = {}
                if IncidentType.crack not in data:
                    data[IncidentType.crack] = {}
                if IncidentType.tamper not in data:
                    data[IncidentType.tamper] = {}
                if IncidentType.face not in data:
                    data[IncidentType.face] = {}
                return data
        except FileNotFoundError:
            return {
                IncidentType.weapons: {},
                IncidentType.violence: {},
                IncidentType.overcrowd: {},
                IncidentType.accident: {},
                IncidentType.climber: {},
                IncidentType.suspicious: {},
                IncidentType.fire: {},
                IncidentType.crack: {},
                IncidentType.tamper: {},
                IncidentType.face: {},
            }

    def save_data(self):
        # Convert datetime objects to strings before saving to JSON
        data_to_save = {
            detection_type: {
                cctv_id: (recorded_time.isoformat(), detection)
                for cctv_id, (recorded_time, detection) in cctv_data.items()
            }
            for detection_type, cctv_data in self.incident_map.items()
        }

        with open(self.data_file, 'w') as file:
            json.dump(data_to_save, file, indent=2)

    def registerDetections(self, frame, cctvId, cctv_type, detection_type, detections):
        # Get the current time
        current_time = datetime.now()

        # Check if the cctvId and detection_type are already in the hashmap
        if cctvId in self.incident_map[detection_type]:
            last_recorded_time, last_detection = self.incident_map[detection_type][cctvId]
            time_difference = (
                current_time - last_recorded_time).total_seconds()
            # If the last recorded detection time is within the throttle time, ignore it
            if time_difference < THROTTLE_INCIDENT_REPORT_TIME:
                # print(f"Ignore incident for {detection_type} due to diff: ", time_difference)  
                # print(
                #     f"Ignoring {detection_type} detection for CCTV {cctvId} within {THROTTLE_INCIDENT_REPORT_TIME} seconds.")
                return

        print(f"Register incident for {detection_type} due to huge time diff: ")
    
        # Update the last recorded time and detection for the detection_type and cctvId
        self.incident_map[detection_type][cctvId] = (
            current_time, detections)

        self.notify(frame, cctvId, cctv_type, detection_type, detections)

        # Save the updated data to the JSON file
        self.save_data()

    def notify(self, frame, cctvId, cctv_type, detection_type, detections):
        # Dummy notify function (replace with actual implementation)
        print(
            f"Notifying for {detection_type} detection on CCTV {cctvId}:", detections)

        incident = {
            'id': str(random.randint(1000, 9999)),
            'image': "https://res.cloudinary.com/dp0ayty6p/image/upload/v1706996639/samples/Screenshot_2024-02-04_031253.png",
            'title': incident_meta_data[detection_type]['title'],
            'description': incident_meta_data[detection_type]['title'],
            'type': detection_type,
            'station_name': "Andheri",
            'location': "Azad Nagar, Andheri West, Mumbai, Maharashtra, India",
            'source': "CCTV",
            'status': "Pending",
            "created_at": "2024-02-03T21:15:50.931706",
            "lat": "19.1198",
            "long": "72.8465", 
            # 'cctv_type': cctv_type,
            # 'cctv_id': cctvId,
            # 'detections': detections,
        }

        # Draw detections on the frame & upload to S3
        frame_to_send = frame
        if detection_type == IncidentType.weapons or detection_type == IncidentType.climber:
            frame_to_send = draw_bounding_boxes(frame, detections)

        byte_im_io = io.BytesIO(cv2.imencode(
            '.jpg', frame_to_send)[1].tobytes())
        uname = str(generateID() + ".jpg")

        bucket.upload_fileobj(byte_im_io, uname)
        incident['image'] = f"https://{S3_BUCKET_NAME}.s3.amazonaws.com/{uname}"
        print("Reached AWS")
        if REGISTER_INCIDENT:
            #  Save incident notification in DB
            # print("Save to DB -", incident)
            thread = threading.Thread(target=create_incident, args=(incident,))
            thread.start()


def generateID():
    id = ""
    for i in range(8):
        if random.random() < 0.5:
            id += chr(random.randint(65, 90))
        else:
            id += str(random.randint(0, 9))
    return id

# # Example Usage:
# # Create an instance of the IncidentManager
# incident_manager = IncidentManager("testing")

# # Register some detections
# incident_manager.registerDetection('CCTV001', 'public', IncidentType.weapons, 'Gun detected')
# incident_manager.registerDetection('CCTV002', 'public', IncidentType.weapons, 'Gun detected')
# incident_manager.registerDetection('CCTV003', 'public', IncidentType.weapons, 'Gun detected')
# incident_manager.registerDetection('CCTV001', 'public', IncidentType.weapons, 'Gun detected')
# incident_manager.registerDetection('CCTV002', 'public', IncidentType.weapons, 'Gun detected')
# incident_manager.registerDetection('CCTV003', 'public', IncidentType.weapons, 'Gun detected')

# incident_manager.registerDetection('CCTV002', 'prison_cell', IncidentType.violence, 'Fight in progress')
# incident_manager.registerDetection(
#     'CCTV001', 'prison_cell', IncidentType.weapons, 'Another gun detected')  # Ignored within 10 seconds
# incident_manager.registerDetection('CCTV003', 'public', IncidentType.overcrowd, 'Crowded area')

# time.sleep(THROTTLE_INCIDENT_REPORT_TIME+2)
# incident_manager.registerDetection(
#     'CCTV001', 'public', IncidentType.weapons, 'New gun detected #2')  # Not ignored after 10 seconds
# incident_manager.registerDetection('CCTV002', 'prison_cell', IncidentType.violence, 'Fight #2')
