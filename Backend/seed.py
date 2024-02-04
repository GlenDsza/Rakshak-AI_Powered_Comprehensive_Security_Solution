from src.models.admin_model import Admin
from src.database.auth_db import create_admin
from src.database.incident_db import create_incident
from src.models.incidents_model import Incidents

#### Creating 2 Station admins
PASSWORD = "123456aA"

admin1 = Admin(
    password=PASSWORD,
    station_name="Andheri",
    role="STATION_ADMIN",
    admin_name="Ravi"
)

admin2 = Admin(
    password=PASSWORD,
    station_name="CSMT",
    role="STATION_ADMIN",
    admin_name="kishore"
)

create_admin(admin1)
create_admin(admin2)

#### Creating 10 incidents for each station

#crime, violence, stampede, cleanliness, safety threat
type = ["Crime","Violence","Stampede","Cleanliness","Safety Threat"]

for i in range(10):
    incident1 = Incidents(
        title="IncidentA"+str(i),
        description="Incident"+str(i),
        type=type[i%5],
        station_name="Andheri",
        location="Chakala street",
        source="CCTV"
    )
    incident2 = Incidents(
        title="IncidentB"+str(i),
        description="Incident"+str(i),
        type=type[i%5],
        station_name="CSMT",
        location="Regis Hotel",
        source="CCTV"
    )
    create_incident(incident1)
    create_incident(incident2)


for i in range(10):
    incident1 = Incidents(
        title="IncidentA"+str(i),
        description="Incident"+str(i),
        type=type[i%5],
        station_name="Andheri",
        location="Chakala street",
        source="9372536732"
    )
    incident2 = Incidents(
        title="IncidentB"+str(i),
        description="Incident"+str(i),
        type=type[i%5],
        station_name="CSMT",
        location="Regis Hotel",
        source="9324326404"
    )
    create_incident(incident1)
    create_incident(incident2)

### Creating 5 staff for each station
from src.models.staff_model import Staff
from src.database.auth_db import create_staff

for i in range(5):
    staff1 = Staff(
        password=PASSWORD,
        station_name="Andheri",
        staff_name="StaffA"+str(i),
        phone="987654321"+str(i)
    )
    staff2 = Staff(
        password=PASSWORD,
        station_name="CSMT",
        staff_name="StaffB"+str(i),
        phone="987654322"+str(i)
    )
    create_staff(staff1)
    create_staff(staff2)

