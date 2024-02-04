from pydantic import BaseModel
from fastapi import Form
import datetime

class Incidents(BaseModel):
    id: str = Form(default="")
    image: str = Form(default="")
    title: str = Form(default="")
    description: str = Form(default="")
    type: str = Form(...)
    # types are: Crime, Violence, Stampede, Safety Threat, Cleanliness, Others
    station_name: str = Form(...)
    location: str = Form(...)
    # Source is either CCTV or id of the User (i.e. Mobile Number)
    source: str = Form(default="CCTV")
    # sources are: CCTV, User
    status: str = Form(default="Pending")
    #status are: Pending, Resolved, Closed
    created_at: str = Form(default=datetime.datetime.now())
    lat: str = Form(default="19.072692341100385")
    long: str = Form(default="72.89981901377328")