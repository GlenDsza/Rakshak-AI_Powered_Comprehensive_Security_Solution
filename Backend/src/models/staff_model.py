from pydantic import BaseModel
from fastapi import Form

class Staff(BaseModel):
    id: str = Form(default="")
    password: str = Form(...)
    station_name: str = Form(...)
    staff_name: str = Form(...)
    status: str = Form(default="Available")
    #status are: Available, Unavailable
    phone: str = Form(...)
    photo: str = Form(default="https://cdn-icons-png.flaticon.com/512/848/848006.png")
    duty: str = Form(default="station")
    # notification_token: str = Form(default="")

class StaffLogin(BaseModel):
    id: str = Form(...)
    password: str = Form(...)