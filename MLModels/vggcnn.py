import cv2

FRAME_WIDTH = 128
FRAME_HEIGHT = 128 
NUM_FRAMES = 30  # Number of frames per video clip (must match the training configuration)
frame_buffer = []

frame2 = cv2.resize(frame, (FRAME_WIDTH, FRAME_HEIGHT))

frame_buffer.append(frame2)

if len(frame_buffer) == NUM_FRAMES:
    input_video_clip = np.array(frame_buffer)
    input_video_clip = np.expand_dims(input_video_clip, axis=0) # might not be needed

    # Perform predictions
    predictions = model2.predict(input_video_clip)
    frame_buffer = []
    confidence = np.max(predictions)
    predicted_class = np.argmax(predictions, axis=1)
    
    if predicted_class == 0:
        label = "No Violence"
    else:
        label = "Violence Detected"

    results = {"label": label, "confidence": confidence}