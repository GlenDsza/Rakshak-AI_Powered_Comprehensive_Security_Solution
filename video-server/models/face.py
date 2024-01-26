import cv2
import os
import face_recognition

# Load known faces
known_faces_path = "models/weights/face_samples/"
known_faces = []
faceList = ["Kenneth", "kenneth"]

# Iterate through files in the "known_faces" folder
for filename in os.listdir(known_faces_path):
    image_path = os.path.join(known_faces_path, filename)
    image = face_recognition.load_image_file(image_path)
    encoding = face_recognition.face_encodings(image)[0]
    known_faces.append(encoding)

print("Face detection loaded")


def detect_face_dummy(frame):
    return [{'bbox': [0.6313255190849304, 0.430192756652832, 0.244161981344223, 0.39618929624557495],
            'bbox_std': [646.0918579101562, 466.3426513671875, 540.1009521484375, 367.1800842285156],
             'confidence': 0.7833458542823792,
             'label': 'Kenneth',
             'orig_shape': (740, 1216)},
            ]


def detect_face(frame):
    # Find all face locations and face encodings in the current frame
    face_locations = face_recognition.face_locations(frame)
    face_encodings = face_recognition.face_encodings(frame, face_locations)

    height, width = frame.shape[0], frame.shape[1]
    faces = []

    # Loop through each face found in the frame
    for (top, right, bottom, left), face_encoding in zip(face_locations, face_encodings):
        # Check if the face matches any known faces
        matches = face_recognition.compare_faces(known_faces, face_encoding)
        name = "Unknown"

        # If a match is found, use the name of the first known face
        if True in matches:
            first_match_index = matches.index(True)
            name = faceList[first_match_index]

            rect_w, rect_h = (right - left)/width, (bottom - top)/height
            x, y = (left/width)+rect_w/2, top/height+rect_h/2

            faces.append({
                'bbox': [x, y, rect_w, rect_h],
                'bbox_std': [left+(right-left)/2, top+(bottom-top)/2, right-left, bottom-top],
                'label': name,
                'confidence': 1,
                'orig_shape': (height, width),
            })
    return faces
