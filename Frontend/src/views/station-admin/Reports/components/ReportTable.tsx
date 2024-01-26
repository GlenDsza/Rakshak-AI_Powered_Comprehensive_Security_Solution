import { useState } from "react";
import Card from "@/components/card";

import {
  createColumnHelper,
  FilterFn,
  flexRender,
  getCoreRowModel,
  getFilteredRowModel,
  getSortedRowModel,
  SortingState,
  useReactTable,
} from "@tanstack/react-table";
import { MdCheckCircle} from "react-icons/md";
import { BsClockHistory } from "react-icons/bs";

import { RankingInfo, rankItem } from "@tanstack/match-sorter-utils";
import { FiSearch } from "react-icons/fi";
import Pagination from "@/components/pagination/Pagination";
import { FaEdit, FaRegEye, FaTrash } from "react-icons/fa";
import { getDate, truncateString } from "@/constants/utils";
import { useDisclosure } from "@chakra-ui/hooks";
import IncidentModal from "@/components/modal/IncidentModal";
import { useAppDispatch } from "@/app/store";
import { deleteIncident } from "@/app/features/IncidentSlice";
import { IoMdClose } from "react-icons/io";
import UpdateIncidentModal from "@/components/modal/updateIncidentModal";

declare module "@tanstack/table-core" {
  interface FilterFns {
    fuzzy: FilterFn<unknown>;
  }
  interface FilterMeta {
    itemRank: RankingInfo;
  }
}

const fuzzyFilter: FilterFn<any> = (row, columnId, value, addMeta) => {
  const itemRank = rankItem(row.getValue(columnId), value);
  addMeta({
    itemRank,
  });
  return itemRank.passed;
};

type RowObj = {
  id: string;
  title: string;
  description: string;
  image: string;
  type: string;
  station_name: string;
  location: string;
  source: string;
  status: string;
  created_at: Date;
  actions: string | undefined;
};

function ReportTable(props: { tableData: any }) {
  const columnHelper = createColumnHelper<RowObj>();
  const { tableData } = props;
  const [sorting, setSorting] = useState<SortingState>([]);
  const dispatch = useAppDispatch();

  const [selectedRow, setSelectedRow] = useState<RowObj | null>(null);

  const {
    isOpen: isIncidentModalOpen,
    onOpen: onIncidentModalOpen,
    onClose: onIncidentModalClose,
  } = useDisclosure();

  const {
    isOpen: isUpdateIncidentModalOpen,
    onOpen: onUpdateIncidentModalOpen,
    onClose: onUpdateIncidentModalClose,
  } = useDisclosure();

  const handleView = (rowObj: RowObj) => {
    setSelectedRow(rowObj);
    onIncidentModalOpen();
  };

  const handleDelete = (rowObj: RowObj) => {
    dispatch(deleteIncident({ id: rowObj.id }));
    setData(data.filter((item) => item.id !== rowObj.id));
  };

  const handleUpdate = (rowObj: RowObj) => {
    setSelectedRow(rowObj);
    onUpdateIncidentModalOpen();
  };

  const updateData = (id: string, status: string) => {
    setData(
      data.map((item) => {
        if (item.id === id) {
          return { ...item, status: status };
        }
        return item;
      })
    );
  }

  const columns = [
    columnHelper.accessor("id", {
      id: "id",
      header: () => (
        <p className="mr-1 inline text-sm font-bold text-gray-600 dark:text-white">
          REPORT ID
        </p>
      ),
      cell: (info: any) => (
        <p className="text-sm font-bold text-navy-700 dark:text-white">
          {info.getValue()}
        </p>
      ),
    }),
    columnHelper.accessor("title", {
      id: "title",
      header: () => (
        <p className="mr-1 inline text-sm font-bold text-gray-600 dark:text-white">
          TITLE
        </p>
      ),
      cell: (info: any) => (
        <p className="text-sm font-bold text-navy-700 dark:text-white">
          {truncateString(info.getValue(), 18)}
        </p>
      ),
    }),
    columnHelper.accessor("created_at", {
      id: "date",
      header: () => (
        <p className="mr-1 inline text-sm font-bold text-gray-600 dark:text-white">
          DATE
        </p>
      ),
      cell: (info) => (
        <p className="text-sm font-bold text-navy-700 dark:text-white">
          {getDate(info.getValue().toString())}
        </p>
      ),
    }),
    columnHelper.accessor("type", {
      id: "type",
      header: () => (
        <p className="mr-1 inline text-sm font-bold text-gray-600 dark:text-white">
          CATEGORY
        </p>
      ),
      cell: (info) => (
        <p className="text-sm font-bold text-navy-700 dark:text-white">
          {info.getValue()}
        </p>
      ),
    }),
    columnHelper.accessor("status", {
      id: "status",
      header: () => (
        <p className="mr-1 inline text-sm font-bold text-gray-600 dark:text-white">
          STATUS
        </p>
      ),
      cell: (info) => (
        <div className="flex items-center">
          {info.getValue() === "Resolved" ? (
            <MdCheckCircle className="me-1 text-green-500 dark:text-green-300" />
          ) : info.getValue() === "Pending" ? (
            <BsClockHistory className="me-1 text-amber-500 dark:text-amber-300" />
          ) : (
            <IoMdClose className="me-2 dark:text-white-300 inline" />
          )}
          <p className="text-sm font-bold text-navy-700 dark:text-white">
            {info.getValue()}
          </p>
        </div>
      ),
    }),
    columnHelper.accessor("actions", {
      id: "actions",
      header: () => (
        <p className="mr-1 inline text-sm font-bold text-gray-600 dark:text-white">
          ACTIONS
        </p>
      ),
      cell: (info: any) => (
        <div className="flex items-center space-x-2">
          <button
            onClick={() => handleView(info.row.original)}
            className={` flex items-center justify-center rounded-lg bg-lightPrimary p-[0.4rem]  font-medium text-brand-500 transition duration-200
           hover:cursor-pointer hover:bg-gray-100 dark:bg-navy-700 dark:text-white dark:hover:bg-white/20 dark:active:bg-white/10`}
          >
            <FaRegEye className="h-4 w-4" />
          </button>
          <button
            onClick={() => handleUpdate(info.row.original)}
            className={` flex items-center justify-center rounded-lg bg-lightPrimary p-[0.4rem]  font-medium text-brand-500 transition duration-200
           hover:cursor-pointer hover:bg-gray-100 dark:bg-navy-700 dark:text-white dark:hover:bg-white/20 dark:active:bg-white/10`}
          >
            <FaEdit className="h-4 w-4" />
          </button>
          <button
            onClick={() => handleDelete(info.row.original)}
            className={` flex items-center justify-center rounded-lg bg-lightPrimary p-[0.4rem]  font-medium text-brand-500 transition duration-200
           hover:cursor-pointer hover:bg-gray-100 dark:bg-navy-700 dark:text-white dark:hover:bg-white/20 dark:active:bg-white/10`}
          >
            <FaTrash className="h-4 w-4" />
          </button>
        </div>
      ),
    }),
  ]; // eslint-disable-next-line
  const [data, setData] = useState(() => [...tableData]);
  const [globalFilter, setGlobalFilter] = useState<string>("");
  const table = useReactTable({
    data,
    columns,
    filterFns: {
      fuzzy: fuzzyFilter,
    },
    state: {
      sorting,
      globalFilter,
    },
    globalFilterFn: fuzzyFilter,
    onGlobalFilterChange: setGlobalFilter,
    getFilteredRowModel: getFilteredRowModel(),
    onSortingChange: setSorting,
    getCoreRowModel: getCoreRowModel(),
    getSortedRowModel: getSortedRowModel(),
    debugTable: true,
  });
  return (
    <>
      <Card extra={"w-full h-full sm:overflow-auto px-6"}>
        <header className="relative flex items-center justify-between pt-4">
          <div className="text-xl font-bold text-navy-700 dark:text-white">
            Reported Incidents
          </div>
          <div className="flex items-center justify-between">
            <div className="flex h-full min-h-[32px] items-center rounded-lg bg-lightPrimary text-navy-700 dark:bg-navy-900 dark:text-white xl:w-[225px]">
              <p className="pl-3 pr-2 text-xl">
                <FiSearch className="h-4 w-4 text-gray-400 dark:text-white" />
              </p>
              <input
                type="text"
                value={globalFilter ?? ""}
                onChange={(e) => setGlobalFilter(e.target.value)}
                placeholder="Search..."
                className="block h-full min-h-[32px] w-full rounded-full bg-lightPrimary text-sm font-medium text-navy-700 outline-none placeholder:!text-gray-400 dark:bg-navy-900 dark:text-white dark:placeholder:!text-white sm:w-fit"
              />
            </div>
          </div>
        </header>

        <div className="mt-2 overflow-x-scroll xl:overflow-x-hidden">
          <table className="w-full">
            <thead>
              {table.getHeaderGroups().map((headerGroup) => (
                <tr
                  key={headerGroup.id}
                  className="!border-px !border-gray-400"
                >
                  {headerGroup.headers.map((header) => {
                    return (
                      <th
                        key={header.id}
                        colSpan={header.colSpan}
                        onClick={header.column.getToggleSortingHandler()}
                        className="cursor-pointer border-b-[1px] border-gray-200 pb-2 pr-4 pt-4 text-start"
                      >
                        <div className="items-center justify-between text-xs text-gray-600">
                          {flexRender(
                            header.column.columnDef.header,
                            header.getContext()
                          )}
                          {{
                            asc: "▲",
                            desc: "▼",
                          }[header.column.getIsSorted() as string] ?? null}
                        </div>
                      </th>
                    );
                  })}
                </tr>
              ))}
            </thead>
            <tbody>
              {table
                .getRowModel()
                .rows
                .map((row) => {
                  return (
                    <tr key={row.id}>
                      {row.getVisibleCells().map((cell) => {
                        return (
                          <td
                            key={cell.id}
                            className="border-white/0 py-3  pr-4"
                          >
                            {flexRender(
                              cell.column.columnDef.cell,
                              cell.getContext()
                            )}
                          </td>
                        );
                      })}
                    </tr>
                  );
                })}
            </tbody>
          </table>
          <Pagination table={table} />
        </div>
      </Card>
      {selectedRow && (
        <>
          <IncidentModal
            showSource={false}
            isIncidentModalOpen={isIncidentModalOpen}
            onIncidentModalClose={onIncidentModalClose}
            incident={selectedRow}
          />
          <UpdateIncidentModal
            onUpdateIncidentModalClose={onUpdateIncidentModalClose}
            isUpdateIncidentModalOpen={isUpdateIncidentModalOpen}
            incident={selectedRow}
            updateData={updateData}
          />
        </>
      )}
    </>
  );
}

export default ReportTable;
