import json
import requests
SERVER_URL = "https://codeblooded-backend.onrender.com"
# SERVER_URL = "https://c157-103-23-239-46.ngrok-free.app"

def create_incident(incident):

    # Create a new dictionary with selective keys
    print("pehle",incident)
    selected_fields = ['image', 'title', 'description', 'type', 'station_name', 'source', 'location', 'status']
    incident = {key: incident[key]
                for key in selected_fields if key in incident}
    
    request_name = "Create incident"
    print(f"Sending {request_name}", incident)
    response = requests.post(f"{SERVER_URL}/incidents/create_incident",
                             json.dumps(incident), headers={"Content-Type": "application/json"})
    print(response)
    print(response.text)
    # Create a new dictionary with selective keys

    # Check the response
    if response.status_code == 200:
        print(f"{request_name} request ({incident['type']}) was successful !")
    else:
        print(f"{request_name} request ({incident['type']}) failed with status code {response.status_code}")
        print("Error message:", response.text)
        print("For", incident)
