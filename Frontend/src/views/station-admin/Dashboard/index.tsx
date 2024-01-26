import { MdReport } from "react-icons/md";
import { TbReport } from "react-icons/tb";

import Widget from "@/components/widget/Widget";
import StaffTable from "./components/StaffTable";
import WeeklyIncidents from "./components/WeeklyIncidents";
import { useAppSelector } from "@/app/store";
import TableSkeleton from "./components/TableSkeleton";
import IncidentTable from "./components/IncidentTable";
import { FaTasks } from "react-icons/fa";
import { SOURCES, getSource } from "../../../constants/validations";

const Dashboard = () => {
  const staff = useAppSelector((state) => state.staff.data);
  const incidents = useAppSelector((state) => state.incidents.data);

  const detectedIncidents = incidents
    .filter((obj) => getSource(obj.source) === SOURCES.CCTV)
    .sort((a, b) => (a.status > b.status ? 1 : -1));

  const reportedIncidents = incidents
    .filter((obj) => getSource(obj.source) === SOURCES.USER)
    .sort((a, b) => (a.status > b.status ? 1 : -1));

  const resolvedIncidents = incidents.filter(
    (obj) => obj.status === "Resolved"
  );

  return (
    <div>
      {/* Card widget */}

      <div className="mt-3 grid grid-cols-1 gap-5 md:grid-cols-2 lg:grid-cols-3 2xl:grid-cols-3">
        <Widget
          icon={<TbReport className="h-7 w-7" />}
          title={"Reported Incidents"}
          subtitle={reportedIncidents
            .filter((obj) => obj.status === "Pending")
            .length.toString()}
        />
        <Widget
          icon={<MdReport className="h-7 w-7" />}
          title={"Detected Incidents"}
          subtitle={detectedIncidents
            .filter((obj) => obj.status === "Pending")
            .length.toString()}
        />
        <Widget
          icon={<FaTasks className="h-6 w-6" />}
          title={"Resolved Incidents"}
          subtitle={resolvedIncidents.length.toString()}
        />
      </div>

      {/* Charts */}

      <div className="mt-5 grid grid-cols-1 gap-5 md:grid-cols-5">
        <WeeklyIncidents />

        {detectedIncidents?.length > 0 ? (
          <IncidentTable
            title="Detected Incidents"
            tableData={detectedIncidents}
          />
        ) : (
          <TableSkeleton type="recentIncident" />
        )}
      </div>

      {/* Tables & Charts */}

      <div className="col-span-2 mt-5 grid grid-cols-2 gap-5 md:grid-cols-5 ">
        {/* Reported Incidents */}
        <div className="col-span-2 md:col-span-3">
          {reportedIncidents?.length > 0 ? (
            <IncidentTable
              title="Reported Incidents"
              tableData={reportedIncidents}
            />
          ) : (
            <TableSkeleton type="recentIncident" />
          )}
        </div>

        {staff?.length > 0 ? (
          <div className="col-span-2 rounded-[20px]">
            <StaffTable tableData={staff} />
          </div>
        ) : (
          <TableSkeleton type="staffTable" />
        )}
      </div>
    </div>
  );
};

export default Dashboard;
