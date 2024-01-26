from pydantic import BaseModel
from fastapi import Form
import datetime

class Notifications(BaseModel):
    id: str = Form(default="")
    description: str = Form(default="")
    title: str = Form(default="")
    type: str = Form(default="")
    station_name: str = Form(default="")
    created_at: str = Form(default=datetime.datetime.now())
    user_id: str = Form(default="")
    image: str = Form(default="https://www.shutterstock.com/image-vector/3d-vector-yellow-warning-sign-260nw-2198150477.jpg")
class GetNotificationsAdmin(BaseModel):
    id: str = Form(default="")
    station_name: str = Form(default="")
class GetNotificationsUser(BaseModel):
    id: str = Form(default="")
    user_id: str = Form(default="")

class GetNotificationsStaff(BaseModel):
    id: str = Form(default="")
    station_name: str = Form(default="")
    duty: str = Form(default="")
