import numpy as np
import cv2
from time import time

# Model spec
# number of frames passed to model for making single inference . this specification is as per the model used and should not be changed
NO_OF_FRAMES_FOR_INFERENCE = 16
MIN_CLIMBING_CONF = 0
MIN_VIOLENCE_CONF = 0
MIN_SUSPICIOUS_CONF = 0

anomaliesResnetModel = cv2.dnn.readNet(
    "models/weights/climber_lstm/resnet-34_kinetics.onnx")


# loading class names
# original source - https://github.com/kenshohara/video-classification-3d-cnn-pytorch/blob/master/class_names_list
filepath_class_names = 'models/weights/climber_lstm/class_names_list.txt'
with open(filepath_class_names, 'r') as fh:
    class_names = fh.read().strip().split('\n')

# Note - 'climbing tree' & 'bungee jumping' gives false positives
climbing_labels = ['abseiling', 'climbing a rope', 'climbing ladder',
                   'ice climbing', 'parkour', 'rock climbing', 'cleaning windows']
violence_labels = ['capoeira', 'drop kicking', 'high kick',
                   'punching person (boxing)', 'side kick', 'slapping', 'sword fighting', 'wrestling']
suspicious_labels = ['bending metal', 'chopping wood', 'digging']

print(f"Anomalies LSTM model Loaded with {len(class_names)} classes")


def preprocess(frames):
    model_img_w = 112    # as per model input image width
    model_img_h = 112    # as per model input image height
    # as per pre-trained model's mean values for normalization
    mean = (114.7748, 107.7354, 99.4750)
    # blob.shape is N x 3 x H x W ( samples, channels(RGB), width , height)
    blob = cv2.dnn.blobFromImages(frames, scalefactor=1, size=(
        model_img_w, model_img_h), mean=mean, swapRB=True, crop=True)
    blob = np.transpose(blob, (1, 0, 2, 3))  # resulting shape is 3 x N x H x W
    # resulting shape is 1 x 3 x N x H x W # 1 is for the batch dimension, required for input to the model
    blob = np.expand_dims(blob, axis=0)
    return blob


def parse_anomalies(prediction):
    pred_class = int(np.argmax(prediction))
    pred_label = class_names[pred_class]
    prediction_confidence = float(prediction[0][pred_class])

    return {
        'climbing': prediction_confidence >= MIN_SUSPICIOUS_CONF and pred_label in climbing_labels,
        'violence': prediction_confidence >= MIN_SUSPICIOUS_CONF and pred_label in violence_labels,
        'suspicious': prediction_confidence >= MIN_SUSPICIOUS_CONF and pred_label in suspicious_labels,
        'prediction': {
            'predicted_class': pred_class,
            'prediction_confidence': prediction_confidence,
            'prediction_label': pred_label,
        }
    }


frame_buffer = []


def reset_buffer():
    global frame_buffer
    frame_buffer = []


dummy_called = 0


def detect_anomaly_dummy(frame):
    global dummy_called
    dummy_called += 1
    if dummy_called == NO_OF_FRAMES_FOR_INFERENCE:
        return {
            'climbing': True,
            'violence': True,
            'suspicious': False,
            'prediction': {
                'predicted_class': 0,
                'prediction_confidence': 62.532,
                'prediction_label': 'abseiling',
            }
        }
    return None


anomalies = None


def detect_anomaly(frame):
    global anomalies
    global frame_buffer

    frame_buffer.append(frame)

    # Limit to FIGHT_NUM_FRAMES frames
    if len(frame_buffer) > NO_OF_FRAMES_FOR_INFERENCE:
        frame_buffer = frame_buffer[-7:]

    # print("Buffer size", len(frame_buffer))

    if len(frame_buffer) == NO_OF_FRAMES_FOR_INFERENCE:
        frames_processed = preprocess(frame_buffer)
        anomaliesResnetModel.setInput(frames_processed)
        # resulting pred.shape will be (1 , 400)
        predictions = anomaliesResnetModel.forward()

        anomalies = parse_anomalies(predictions)

        # print("Anomaly classification: ", anomalies)
        reset_buffer()
    else:
        # print("Pass ...")
        pass

    return anomalies
