import { useEffect, useState } from "react";
import TableSkeleton from "@/components/skeleton/TableSkeleton";
import IncidentTable from "./components/IncidentTable";
import { useAppSelector } from "@/app/store";
import { Incident } from "@/app/features/IncidentSlice";
import { SOURCES, getSource } from "../../../constants/validations";

const Incidents = () => {
  const incidents = useAppSelector((state) => state.incidents.data);
  const [filteredIncidents, setFilteredIncidents] = useState<Incident[]>([]);

  useEffect(() => {
    setFilteredIncidents(
      incidents.filter(
        (obj: Incident) => getSource(obj.source) === SOURCES.CCTV
      )
    );
  }, [incidents]);

  return (
    <div>
      <div className="mx-3 my-3 grid grid-cols-1">
        {filteredIncidents.length > 0 ? (
          (console.log(filteredIncidents),
          (<IncidentTable tableData={filteredIncidents} />))
        ) : (
          <TableSkeleton />
        )}
      </div>
    </div>
  );
};

export default Incidents;
