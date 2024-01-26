from pydantic import BaseModel
from fastapi import Form

class Admin(BaseModel):
    id: str = Form(default="")
    password: str = Form(...)
    station_name: str = Form(...)
    role: str = Form(default="STATION_ADMIN")
    admin_name: str = Form(...)
    photo: str = Form(default="https://cdn-icons-png.flaticon.com/512/848/848006.png")

class AdminLogin(BaseModel):
    id: str = Form(...)
    password: str = Form(...)