import torch
from ultralytics import YOLO

from models.utils.yolo import parse_yolo_predictions
from models.device import current_device

pretrainedYoloModel = YOLO("models/weights/yolo_v8/yolov8n.pt").to(torch.device(current_device))
print("Pre-trained YOLO Loaded")

def detect_objects_dummy(frame):
    return [
        {'label': 'person', 'confidence': 0.95, 'bbox': [10, 10, 50, 50]},
        {'label': 'car', 'confidence': 0.95, 'bbox': [10, 10, 50, 50]},
        {'label': 'computer', 'confidence': 0.95, 'bbox': [10, 10, 50, 50]}
    ]

def detect_objects(frame):
    outputs = pretrainedYoloModel.predict(source=frame, verbose=False)
    return parse_yolo_predictions(outputs, 0.2)
