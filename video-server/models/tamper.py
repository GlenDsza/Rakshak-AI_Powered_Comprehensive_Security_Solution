import numpy as np
import cv2
import matplotlib.pyplot as plt
from config import MIN_TAMPER_CONF

fgbg = cv2.createBackgroundSubtractorMOG2()
kernel = np.ones((5, 5), np.uint8)

def detect_temper_dummy(frame):
    return {'tamper': True}

def detect_tamper(frame):
    if (frame is None):
        return {'tamper': False}

    a = 0
    bounding_rect = []
    fgmask = fgbg.apply(frame)
    fgmask = cv2.erode(fgmask, kernel, iterations=5)
    fgmask = cv2.dilate(fgmask, kernel, iterations=5)

    contours, _ = cv2.findContours(fgmask, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    for i in range(len(contours)):
        bounding_rect.append(cv2.boundingRect(contours[i]))

    # print("Obstacles:", len(contours))

    THRESHOLD = 70
    for i in range(len(contours)):
        if bounding_rect[i][2] >= THRESHOLD or bounding_rect[i][3] >= THRESHOLD:
            a = a + (bounding_rect[i][2]) * bounding_rect[i][3]

    tampered = True if a >= int(frame.shape[0]) * int(frame.shape[1]) / 3 else False

    return {'tamper': tampered }
