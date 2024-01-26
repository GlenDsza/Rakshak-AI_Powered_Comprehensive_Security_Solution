import Card from "@/components/card";

interface TableSkeletonProps {
  type: string;
}

const TableSkeleton = ({ type }: TableSkeletonProps) => {
  return (
    <>
      <Card
        extra={`w-full overflow-hidden sm:overflow-auto px-6 p-4 space-y-4 border border-gray-200 divide-y bg-white rounded shadow animate-pulse dark:divide-gray-700 md:p-6 dark:border-gray-700 ${
          type === "recentIncident" ? "col-span-3" : "col-span-2"
        }`}
      >
        {Array.from({ length: 5 }).map((_, index) => (
          <div key={index} className="flex items-center justify-between py-4">
            <div>
              <div className="h-2.5 bg-gray-300 rounded-full dark:bg-gray-600 w-24 mb-2.5"></div>
              <div className="w-32 h-2 bg-gray-200 rounded-full dark:bg-gray-700"></div>
            </div>
            <div>
              <div className="h-2.5 bg-gray-300 rounded-full dark:bg-gray-600 w-24 mb-2.5"></div>
              <div className="w-32 h-2 bg-gray-200 rounded-full dark:bg-gray-700"></div>
            </div>
            <div className="h-2.5 bg-gray-300 rounded-full dark:bg-gray-700 w-12"></div>
          </div>
        ))}

        <span className="sr-only">Loading...</span>
      </Card>
    </>
  );
};

export default TableSkeleton;
