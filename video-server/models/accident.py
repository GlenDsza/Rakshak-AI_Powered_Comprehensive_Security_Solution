import torch
from ultralytics import YOLO

from models.utils.yolo import parse_yolo_predictions
from models.device import current_device
from config import MIN_ACCIDENT_CONF

accidentsYoloModel = YOLO(
    "models/weights/accident/accident_latest.pt").to(torch.device(current_device))
print("Accidents YOLO Loaded")

def detect_accident_dummy(frame):
    return [{'bbox': [0.5313255190849304, 0.630192756652832, 0.444161981344223, 0.49618929624557495],
            'bbox_std': [646.0918579101562, 466.3426513671875, 540.1009521484375, 367.1800842285156],
             'confidence': 0.9333458542823792,
             'label': 'Accident',
             'orig_shape': (740, 1216)},
            ]

def detect_accident(frame):
    outputs = accidentsYoloModel.predict(source=frame, verbose=False)
    # print(f"Detected {len(outputs)} accidents")
    return parse_yolo_predictions(outputs, MIN_ACCIDENT_CONF)
