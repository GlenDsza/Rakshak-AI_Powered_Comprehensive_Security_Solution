from fastapi import APIRouter
from src.endpoints import (
    test_endp, 
    auth_endp, 
    admin_endp,
    incidents_endp,
    notifications_endp,
    staff_endp,
    annotations_endp
)

router = APIRouter()
router.include_router(test_endp.router)
router.include_router(auth_endp.router)
router.include_router(admin_endp.router)
router.include_router(incidents_endp.router)
router.include_router(notifications_endp.router)
router.include_router(staff_endp.router)
router.include_router(annotations_endp.router)
