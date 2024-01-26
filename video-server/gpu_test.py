import torch
import tensorflow as tf
from models.device import current_device
from tensorflow.python.client import device_lib

print("Using:", current_device)

# print(tf.test.is_built_with_cuda())
# print(tf.test.is_built_with_rocm())
# print(tf.test.is_built_with_gpu_support())
print(tf.test.is_built_with_xla())
print(tf.config.list_physical_devices('GPU'))
print(device_lib.list_local_devices())

gpus = tf.config.experimental.list_physical_devices('GPU')
print("GPUs: ", gpus)

# torch.backends.cudnn.enabled = True  # Enable cuDNN
# torch.backends.cudnn.benchmark = True  # Use cuDNN's auto-tuner for the best performance

# if len(gpus) > 0:
#     print(f"We got {len(gpus)} GPU(s)")
#     for gpu in gpus:
#         tf.config.experimental.set_memory_growth(gpu, True)
# #     tf.config.gpu.set_per_process_memory_growth(True)
# else:
#     print("Sorry, no GPU for you...")

