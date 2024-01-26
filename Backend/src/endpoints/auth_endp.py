from fastapi import  APIRouter, Response, status
from src.models.admin_model import Admin, AdminLogin
from src.models.staff_model import Staff, StaffLogin
from src.database.auth_db import (validate_admin, 
                                  create_admin,
                                  create_user,
                                  validate_staff,
                                  create_staff,
                                  check_user,
                                  update_otp,
                                  make_user_valid,
                                  update_user_token
                                  )
from src.database.staff_db import update_staff_token

from src.models.user_model import User, UserLogin
import math, random, requests
from src.config import API_KEY, SMS_WEBHOOK

router = APIRouter(
    prefix="/auth",
    tags=["Auths"],
    responses={404: {"description": "Not found"}},
)

def generateOTP() : 
    # Declare a digits variable 
    # which stores all digits
    digits = "0123456789"
    OTP = ""
   # length of password can be changed
   # by changing value in range
    for i in range(6) :
        OTP += digits[math.floor(random.random() * 10)]
    return OTP


#login admin
@router.post("/admin", description="Login for Station admin, Returns Object")
def login_admin(admin: AdminLogin):
    if admin.id == "" or admin.password == "":
        return {"ERROR":"MISSING PARAMETERS"}
    
    return validate_admin(admin)

#create admin
@router.post("/create_admin", description="Create Station admin")
def add_admin(admin: Admin):
    if admin.password == "" or admin.station_name == "":
        return {"ERROR":"MISSING PARAMETERS"}
    
    result = create_admin(admin)
    return result


#login staff
@router.post("/staff", description="Login Staff")
def login_staff(staff: StaffLogin, response: Response):
    if staff.id == "" or staff.password == "":
        response.status_code = status.HTTP_400_BAD_REQUEST
        return {"ERROR":"MISSING PARAMETERS"}
    
    result = validate_staff(staff)
    if "ERROR" in result.keys():
        response.status_code = status.HTTP_401_UNAUTHORIZED
    return result

# #create station admin
@router.post("/create_staff", description="Create staff")
def add_staff(staff: Staff):
    if staff.password == "" or staff.station_name == "" or staff.dept_name == "" or staff.staff_name == "" or staff.phone == "" or staff.duty == "":
        return {"ERROR":"MISSING PARAMETERS"}
    
    result = create_staff(staff)
    return result

#### USER AUTHENTICATION ####
@router.post("/signup")
async def signup(user : User, response: Response):
    if user.fullname == "" or user.password == "" or user.mobile=="":
        response.status_code = status.HTTP_400_BAD_REQUEST
        return {"ERROR":"MISSING PARAMETERS"}
    otp = generateOTP()
    requests.get(SMS_WEBHOOK,params = {"authorization": API_KEY, "variables_values":otp,"route":"otp","numbers":user.mobile})
    user.otp = otp
    result = create_user(user)
    # check if result has error property
    if "ERROR" in result.keys():
        response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
    return result

@router.post("/login")
async def login(user : UserLogin, response: Response):
    if user.mobile == "" or user.password == "":
        response.status_code = status.HTTP_400_BAD_REQUEST
        return {"ERROR":"MISSING PARAMETERS"}
    
    result = check_user(user)
    if "ERROR" in result.keys():
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return result
    return {"mobile":result['mobile'],"fullname":result['fullname']}


@router.post("/getotp")
async def get_otp(user : UserLogin, response: Response):
    if user.mobile == "" or user.password == "":
        response.status_code = status.HTTP_400_BAD_REQUEST
        return {"ERROR":"MISSING PARAMETERS"}
    result = check_user(user)
    if "ERROR" in result.keys():
        if result["ERROR"] != "USER NOT VERIFIED":
            response.status_code = status.HTTP_401_UNAUTHORIZED
            return result
    otp = generateOTP()
    requests.get(SMS_WEBHOOK, params = {"authorization": API_KEY, "variables_values":otp,"route":"otp","numbers":user.mobile})
    if update_otp(user.mobile,otp)=="SUCCESS":
        return {"SUCCESS":"OTP SENT"}
    response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
    return {"ERROR":"SOME ERROR OCCURRED"}

@router.post("/checkotp")
async def check_otp(user : UserLogin, response: Response):
    if user.mobile == "":
        response.status_code = status.HTTP_400_BAD_REQUEST
        return {"ERROR":"MISSING PARAMETERS"}
    result = check_user(user,user.otp)
    
    if "ERROR" in result.keys():
        if result["ERROR"] != "USER NOT VERIFIED":
            response.status_code = status.HTTP_401_UNAUTHORIZED
            return result
    
    if make_user_valid(user.mobile) == "SUCCESS":
        return {"mobile":result['mobile'],"fullname":result['fullname']}
    else:
        response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
        return {"ERROR":"SOME ERROR OCCURED WHILE UPDATING THE USER STATE"}

# # Save registration token generated by FCM
# @router.post("/save_user_token")
# def save_user_token(user : UserLogin, response: Response):
#     if user.mobile == "" or user.password == "" or user.notifcation_token == "":
#         response.status_code = status.HTTP_400_BAD_REQUEST
#         return {"ERROR":"MISSING PARAMETERS"}
#     result = check_user(user)
#     if "ERROR" in result.keys():
#         response.status_code = status.HTTP_401_UNAUTHORIZED
#         return result

#     if update_user_token(user.mobile, user.notifcation_token) == "SUCCESS":
#         return {"SUCCESS": "TOKEN SAVED"}
#     else:
#         response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
#         return {"ERROR":"Failed to Save"}
    