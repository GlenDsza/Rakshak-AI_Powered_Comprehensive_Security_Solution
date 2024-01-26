nptcode = "TN21BZ0771"
npcode = "MH438U9429"

#importing necessary libaries
import numpy as np
import cv2
import matplotlib.pyplot as plt
from ultralytics import YOLO
from tensorflow.keras.models import load_model

#Video capturing starts
cap = cv2.VideoCapture('samples\carvid.mp4')
model = YOLO('weights\cardetect.pt')
classifier = load_model("weights\carclass.keras")
class_labels = ['Audi', 'Hyundai Creta', 'Scorpio', 'Rolls Royce', 'Suzuki Swift', 'Tata Safari', 'Toyota Innova']
while(True):
    ret, frame = cap.read()
    if(frame is None):
        print("End of frame")
        break;
    else:
        res = model.predict(frame, verbose=False)
        if len(res[0].boxes.xyxy) >0 and len(res[0].boxes.xyxy[0]) == 4:
            
            img_height, img_width, _ = frame.shape

            # Convert normalized coordinates to absolute coordinates
            x, y, w, h = res[0].boxes.xyxy.squeeze().tolist()
            cropped_image = frame[int(y): int(h), int(x):int(w) ]
            
            cropped_image = cv2.resize(cropped_image, (224, 224))
            cropped_image = np.expand_dims(cropped_image, 0)
            cv2.rectangle(frame, (int(x), int(y)), (int(w), int(h)), (255, 0, 0), 2)

            pred = classifier.predict(cropped_image)
            if np.argmax(pred) == 1:
                datext = class_labels[np.argmax(pred)] + "==> " + nptcode
            elif np.argmax(pred) == 4:
                datext = class_labels[np.argmax(pred)] + "==> " + npcode
                cv2.rectangle(frame, (0, frame.shape[0] - 35), (frame.shape[1], frame.shape[0]), (255, 255, 255), -1)
                cv2.putText(frame,"Alert!!! Number Plate Mismatch",(10, frame.shape[0] - 10),cv2.FONT_HERSHEY_SIMPLEX,1,(0,0,255),3)   
            else:
                datext = class_labels[np.argmax(pred)]

            cv2.putText(frame,datext,(5,30),cv2.FONT_HERSHEY_SIMPLEX,1,(255,0,0),3)   
        cv2.imshow('frame',frame)     

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release resources
cap.release()
cv2.destroyAllWindows()
