
import googlemaps
from src.config import GOOGLE_MAPS_API_KEY


gmaps = googlemaps.Client(key=GOOGLE_MAPS_API_KEY)

def delete_na_fields(map):
    for key in list(map.keys()):
        if map[key] == "":
            del map[key]
        elif map[key] == "N/A":
            del map[key]
        elif map[key] == None:
            del map[key]
    return map

def get_lat_long(address): 
  try: 
    geocode_result = gmaps.geocode(address)
    lat = geocode_result[0]["geometry"]["location"]["lat"]
    lon = geocode_result[0]["geometry"]["location"]["lng"]
    return (str(lat), str(lon))
  except Exception as e:
    return ("19.072692341100385","72.89981901377328")


def get_lat_long_by_cctv(id):
    for feature in cctv_json["features"]:
        if feature["properties"]["id"] == id:
            return feature["geometry"]["coordinates"]
    return ("19.072692341100385","72.89981901377328")

cctv_json = {
  "features": [
    {
      "type": "Feature",
      "properties": {
        "id": "cctv_c00",
        "cctv_type": "prison",
        "title": "Cell #1",
        "description": "Amboli Prison, Andheri",
        "kind": "default",
        "streamUrl": "https://res.cloudinary.com/dp0ayty6p/video/upload/v1704612681/samples/prison_escape.mp4"
      },
      "geometry": { "coordinates": [26.920830, 75.793044], "type": "Point" }
    },
    {
      "type": "Feature",
      "properties": {
        "id": "cctv_c01",
        "cctv_type": "prison",
        "title": "Cell #2",
        "description": "Amboli Prison, Andheri",
        "kind": "default",
        "streamUrl": "https://res.cloudinary.com/dp0ayty6p/video/upload/v1704612681/samples/prison_escape.mp4"
      },
      "geometry": { "coordinates": [26.919835, 75.793968], "type": "Point" }
    },
    {
      "type": "Feature",
      "properties": {
        "id": "cctv_p00",
        "cctv_type": "station_premises",
        "title": "Backyard",
        "description": "Amboli prison, Andheri",
        "kind": "default",
        "streamUrl": "https://res.cloudinary.com/dp0ayty6p/video/upload/v1704612681/samples/prison_escape.mp4"
      },
      "geometry": { "coordinates": [26.8670824, 75.8198607], "type": "Point" }
    },
    {
      "type": "Feature",
      "properties": {
        "id": "cctv_p01",
        "cctv_type": "station_premises",
        "title": "Gate #1",
        "description": "Amboli prison, Andheri",
        "kind": "default",
        "streamUrl": "https://res.cloudinary.com/dp0ayty6p/video/upload/v1704612681/samples/prison_escape.mp4"
      },
      "geometry": { "coordinates": [26.918374, 75.800766], "type": "Point" }
    },
    {
      "type": "Feature",
      "properties": {
        "id": "cctv_p03",
        "cctv_type": "public",
        "title": "Lokhandwala Market, Andheri West",
        "description": "Local market",
        "kind": "default",
        "streamUrl": "https://res.cloudinary.com/dp0ayty6p/video/upload/v1705171052/samples/fire_sample.mp4"
      },
      "geometry": { "coordinates": [26.8670824, 75.8198607], "type": "Point" }
    },
    {
      "type": "Feature",
      "properties": {
        "id": "cctv_p04",
        "cctv_type": "public",
        "title": "Chota Kashmir, Goregaon East",
        "description": "Feel Kashmir in your city",
        "kind": "boat",
        "streamUrl": "https://res.cloudinary.com/dp0ayty6p/video/upload/v1704890971/samples/public_cam.mp4"
      },
      "geometry": { "coordinates": [26.923884, 75.801752], "type": "Point" }
    },
    {
      "type": "Feature",
      "properties": {
        "id": "cctv_p05",
        "cctv_type": "public",
        "title": "Versova Beach",
        "description": "Bustling Beach in suburbs",
        "kind": "beach",
        "streamUrl": "https://res.cloudinary.com/dp0ayty6p/video/upload/v1704614357/samples/gun_video.mp4"
      },
      "geometry": { "coordinates":  [26.931843, 75.785003], "type": "Point" }
    },
    {
      "type": "Feature",
      "properties": {
        "id": "cctv_p06",
        "cctv_type": "public",
        "title": "Mahakali Caves, Andheri East",
        "description": "Rock-cut monuments",
        "kind": "default",
        "streamUrl": "https://res.cloudinary.com/dp0ayty6p/video/upload/v1703605915/samples/market.mp4"
      },
      "geometry": { "coordinates":  [26.921063, 75.784501], "type": "Point" }
    },
    {
      "type": "Feature",
      "properties": {
        "id": "cctv_p07",
        "cctv_type": "public",
        "title": "Juhu Beach, Andheri West",
        "description": "Longest beach in Mumbai",
        "kind": "beach",
        "streamUrl": "https://res.cloudinary.com/dp0ayty6p/video/upload/v1703605906/samples/beach.mp4"
      },
      "geometry": { "coordinates":  [26.941063, 75.785501], "type": "Point" }
    }
  ],
  "type": "FeatureCollection"
}
