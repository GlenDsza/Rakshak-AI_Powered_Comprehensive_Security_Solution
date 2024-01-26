import torch
from ultralytics import YOLO

from models.utils.yolo import parse_yolo_predictions
from models.device import current_device
from config import MIN_FIRE_CONF

fireYoloModel = YOLO(
    "models/weights/fire_explosion/fire_optimal.pt").to(torch.device(current_device))
print("Fire YOLO Loaded")

def detect_fire_dummy(frame):
    return [{'bbox': [0.6313255190849304, 0.430192756652832, 0.244161981344223, 0.39618929624557495],
            'bbox_std': [646.0918579101562, 466.3426513671875, 540.1009521484375, 367.1800842285156],
             'confidence': 0.7833458542823792,
             'label': 'fire',
             'orig_shape': (740, 1216)},
            ]

def detect_fire(frame):
    outputs = fireYoloModel.predict(source=frame, verbose=False)
    return parse_yolo_predictions(outputs, MIN_FIRE_CONF)
