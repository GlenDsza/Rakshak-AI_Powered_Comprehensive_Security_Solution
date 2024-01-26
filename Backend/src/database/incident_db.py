from pymongo import ASCENDING
from src.establish_db_connection import database
from src.models.incidents_model import Incidents
from src.models.notifications_model import Notifications
from src.database.notifications_db import create_notification
import random

incidents = database.Incidents
incidents.create_index([("id", ASCENDING)], unique=True)

def generateID():
    # 8 characters long alphanumeric id in uppercase
    id = ""
    for i in range(8):
        if random.random() < 0.5:
            id += chr(random.randint(65,90))
        else:
            id += str(random.randint(0,9))
    return id
    
    
def create_incident(incident):
    try:
        document = incident.dict()
        id = generateID()
        distincts = incidents.distinct("id")

        #until we have a unique id
        while id in distincts:
            id = generateID()

        document['id'] = id
        incidents.insert_one(document)
       
        del document['_id']
        return {"SUCCESS": document}
    except Exception as e:
        print(e)
        return {"ERROR":"SOME ERROR OCCURRED"}
   

# get all incidents
def fetch_all_incidents():
    try:
        # we don't want to return the _id field
        all_incidents = list(incidents.find({},{"_id":0}))
        return {"SUCCESS": all_incidents}
    except Exception as e:
        print(e)
        return {"ERROR":"SOME ERROR OCCURRED"}
    
# get incident by id
def get_incident_by_id(incident_id):
    try:
        incident = incidents.find_one({"id":incident_id},{"_id":0})
        return Incidents(**incident)
    except Exception as e:
        print(e)
        return {"ERROR":"SOME ERROR OCCURRED"}
    
#updating status of the incident to In Progress in db
def update_incident_status(incident_id, status):
    try:
        incidents.update_one({"id":incident_id},{"$set":{"status":status}})
        return {"SUCCESS":"STATUS UPDATED"}
    except Exception as e:
        print(e)
        return {"ERROR":"SOME ERROR OCCURRED"}
    
def fetch_incidents_by_station(station_name):
    try:
        incidents_list = list(incidents.find({"station_name":station_name},{"_id":0}))
        return {"SUCCESS": incidents_list}
    except Exception as e:
        print(e)
        return {"ERROR":"SOME ERROR OCCURRED"}

def delete_incident_by_id(id):
    try:
        incidents.delete_one({"id":id})
        return {"SUCCESS":"INCIDENT DELETED"}
    except Exception as e:
        print(e)
        return {"ERROR":"SOME ERROR OCCURRED"}
    
def update_incident_status(id, status):
    try:
        user_id = incidents.find_one({"id":id},{"_id":0})['source']
        incidents.update_one({"id":id},{"$set":{"status":status}})
        if user_id != "CCTV":
            create_notification(Notifications(title="Report Status Marked as "+status, description=f"Your report with id {id} has been updated to {status}", type="Incident", user_id=user_id))
   
        return {"SUCCESS":"STATUS UPDATED"}
    except Exception as e:
        print(e)
        return {"ERROR":"SOME ERROR OCCURRED"}
    
def fetch_incidents_by_userid(id):
    try:
        incidents_list = list(incidents.find({"source":id},{"_id":0}))
        return {"SUCCESS": incidents_list}
    except Exception as e:
        print(e)
        return {"ERROR":"SOME ERROR OCCURRED"}

def fetch_incidents_by_id(id):
    try:
        incident = incidents.find_one({"id":id},{"_id":0})
        return {"SUCCESS": incident}
    except Exception as e:
        print(e)
        return {"ERROR":"SOME ERROR OCCURRED"}
    

def update_incident_station_name(id, station_name):
    try:
        incidents.update_one({"id":id},{"$set":{"station_name":station_name}})
        return {"SUCCESS":"STATION NAME UPDATED"}
    except Exception as e:
        print(e)
        return {"ERROR":"SOME ERROR OCCURRED"}