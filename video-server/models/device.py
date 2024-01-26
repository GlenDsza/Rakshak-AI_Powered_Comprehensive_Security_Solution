
import torch
import tensorflow as tf
import keras.backend as Kt

config = tf.compat.v1.ConfigProto()
config.gpu_options.allow_growth = True
# config.gpu_options.per_process_gpu_memory_fraction = 0.4
# Kt.tensorflow_backend.set_session(tf.Session(config=config))
# sess = tf.compat.v1.Session(config=config)

detected_device = 'cuda' if torch.cuda.is_available() else "mps" if torch.backends.mps.is_available() else "cpu"

# current_device = "cpu"
# current_device = "gpu"
# current_device = "mps"
current_device = detected_device
if current_device == "mps":
  current_device = "cpu"  # NOTE: MPS is not working :(
  
print(f"Using {current_device}")

# model.to(device)
