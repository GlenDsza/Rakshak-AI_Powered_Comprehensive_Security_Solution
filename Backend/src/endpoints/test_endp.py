from fastapi import  APIRouter

router = APIRouter(
    prefix="",
    tags=["Application"],
    responses={404: {"description": "Not found"}},
)

@router.get("/")
def test():
    return {"HELLO": "WORLD"}