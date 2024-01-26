import os
cached_dir = 'samples/cached/'

def attempt_cache_src(video_url):
  video_title = video_url.split("/").pop()
  if os.path.exists(os.path.join(cached_dir, video_title)):
    return os.path.join(cached_dir, video_title)
  return video_url

# video_url = "https://res.cloudinary.com/dp0ayty6p/video/upload/v1704614357/samples/gun_video_short.mp4"
# print(attempt_cache_src(video_url))
# video_url = "https://res.cloudinary.com/dp0ayty6p/video/upload/v1704614357/samples/prison_escape_short.mp4"
# print(attempt_cache_src(video_url))
