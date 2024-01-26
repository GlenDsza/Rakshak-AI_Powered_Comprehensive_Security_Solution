from pydantic import BaseModel
from fastapi import Form

class User(BaseModel):
    fullname: str = Form(...)
    password: str = Form(...)
    mobile: str = Form(...)
    otp: str = Form(default="")
    is_verified: bool = Form(default=False)
    active: bool = Form(default=False)
    # notification_token: str = Form(default="")

class UserLogin(BaseModel):
    mobile: str = Form(...)
    password: str = Form(...)
    otp: str = Form(default="")
    # notifcation_token: str = Form(default="")

class UserToken(BaseModel):
    access_token: str = Form(...)
    token_type: str = Form(...)

class TokenData(BaseModel):
    mobile: str or None = None