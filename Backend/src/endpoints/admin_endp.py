from fastapi import  APIRouter
from src.database.admin_db import get_admin_by_id

router = APIRouter(
    prefix="/admin",
    tags=["Admins"],
    responses={404: {"description": "Not found"}},
)

@router.get("/get_admin_by_id")
def get_by_id(id: str):
    if id == "":
        return {"ERROR":"MISSING PARAMETERS"}
    return get_admin_by_id(id)