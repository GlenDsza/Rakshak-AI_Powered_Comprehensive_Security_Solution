import os
import cv2
import numpy as np

weights = os.path.dirname(__file__)

# Load YOLO model
net = cv2.dnn.readNet(
    os.path.join(weights, '../models/weights/yolov3_cv2/yolov3.weights'),
    os.path.join(weights, '../models/weights/yolov3_cv2/yolov3.cfg')
)

with open(os.path.join(weights, '../models/weights/yolov3_cv2/coco.names'), 'r') as f:
    classes = [line.strip() for line in f.readlines()]
print("Yolo model ready to rock n roll !!")


def detect_objects_dummy(frame):
    return [
        {'label': 'person', 'confidence': 0.95, 'bbox': [10, 10, 50, 50]},
        {'label': 'car', 'confidence': 0.95, 'bbox': [10, 10, 50, 50]},
        {'label': 'computer', 'confidence': 0.95, 'bbox': [10, 10, 50, 50]}
    ]


def detect_objects(frame):
    # Get height and width of the frame
    height, width, _ = frame.shape

    # Preprocess the frame for YOLO
    blob = cv2.dnn.blobFromImage(
        frame, 0.00392, (416, 416), (0, 0, 0), True, crop=False)
    net.setInput(blob)

    # Get output layer names
    output_layers = net.getUnconnectedOutLayersNames()

    # Run forward pass to get output from the output layers
    outs = net.forward(output_layers)

    # Initialize lists to store detected objects
    detected_objects = []

    # Loop through each detection and extract information
    for out in outs:
        for detection in out:
            scores = detection[5:]
            class_id = np.argmax(scores)
            confidence = scores[class_id]

            if confidence > 0.5:  # You can adjust the confidence threshold as needed
                # Calculate coordinates of the bounding box
                center_x = int(detection[0] * width)
                center_y = int(detection[1] * height)
                w = int(detection[2] * width)
                h = int(detection[3] * height)

                # Coordinates of the top-left corner
                x = int(center_x - w / 2)
                y = int(center_y - h / 2)

                # Add detected object information to the list
                detected_objects.append({
                    'label': classes[class_id],
                    'confidence': float(confidence),
                    'bbox': [x, y, x + w, y + h]
                })

    return detected_objects

# # Example usage:
# stream_url = "https://res.cloudinary.com/dp0ayty6p/video/upload/v1703605906/samples/beach.mp4"
# cap = cv2.VideoCapture(stream_url)
# while True:
#     ret, frame = cap.read()
#     if not ret:
#         break
#     detected_objects = detect_objects(frame)
#     print(detected_objects)
#     # Add code to draw bounding boxes on the frame if needed
#     cv2.imshow('Detected Objects', frame)
#     if cv2.waitKey(1) & 0xFF == ord('q'):
#         break
# cap.release()
# cv2.destroyAllWindows()

# Load the image
# image_path = '../samples/gg.png'
# image = cv2.imread(image_path)

# if image is not None:
#     detected_objects = detect_objects(image)
#     print(detected_objects)
# else:
#     print(f"Error: Unable to load the image from '{image_path}'.")
