import io
import cv2


def parse_yolo_predictions(predictions, min_conf=0.5):
    if predictions is None or len(predictions) == 0:
        return []

    results = []
    for i in range(len(predictions[0].boxes)):
        if predictions[0].boxes[i].conf[0].item() >= min_conf:
            results.append({
                'confidence': predictions[0].boxes[i].conf[0].item(),
                'label': predictions[0].names[predictions[0].boxes[i].cls.item()],
                'bbox': predictions[0].boxes[i].xywhn[0].tolist(),
                'bbox_std': predictions[0].boxes[i].xywh[0].tolist(),
                'orig_shape': predictions[0].orig_shape
            })
    return results


def draw_bounding_boxes(frame, yolo_detections):
    # Create a new frame to draw bounding boxes without modifying the original frame
    new_frame = frame.copy()

    for detection in yolo_detections:
        confidence = detection['confidence']
        label = detection['label']
        bbox_normalized = detection['bbox']

        # Convert normalized coordinates to pixel coordinates
        h, w, _ = new_frame.shape
        x, y, width, height = bbox_normalized
        x = int(x * w)
        y = int(y * h)
        width = int(width * w)
        height = int(height * h)
        x -= width // 2
        y -= height // 2

        # Draw bounding box on the new frame
        color = (0, 255, 0)  # Green color for the bounding box
        thickness = 2
        cv2.rectangle(new_frame, (x, y), (x + width,
                      y + height), color, thickness)

        # Display label and confidence
        label_text = f"{label}: {confidence:.2f}"
        cv2.putText(frame, label_text, (x, y - 10),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, thickness)

    # Convert the new frame to bytes
    return new_frame
