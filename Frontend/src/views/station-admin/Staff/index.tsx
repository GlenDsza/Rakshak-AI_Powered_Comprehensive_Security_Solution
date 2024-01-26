import { useAppSelector } from "@/app/store";
import StaffTable from "./components/StaffTable";
import TableSkeleton from "@/components/skeleton/TableSkeleton";

const Staff = () => {
  const staff = useAppSelector((state) => state.staff.data);
  return (
    <div>
      <div className="mx-3 my-3 grid grid-cols-1">
        {staff.length > 0 ? (
          <StaffTable tableData={staff} />
        ) : (
          <TableSkeleton />
        )}
      </div>
    </div>
  );
};

export default Staff;
