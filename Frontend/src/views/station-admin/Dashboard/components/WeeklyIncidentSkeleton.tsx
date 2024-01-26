import Card from "@/components/card";
import React from "react";

const WeeklyIncidentSkeleton = () => {
  return (
    <>
      <Card
        extra={
          "w-full overflow-hidden sm:overflow-auto px-6 p-4 space-y-4 border border-gray-200 divide-y bg-white rounded shadow animate-pulse dark:divide-gray-700 md:p-6 dark:border-gray-700 "
        }
      >
        <div className="h-2.5 bg-gray-200 rounded-full dark:bg-gray-700 w-32 mb-2.5"></div>
        <div className="w-48 h-2 mb-10 bg-gray-200 rounded-full dark:bg-gray-700"></div>
        <div className="flex items-baseline mt-4 space-x-6">
          <div className="w-full bg-gray-200 rounded-t-lg h-72 dark:bg-gray-700"></div>
          <div className="w-full h-56 bg-gray-200 rounded-t-lg dark:bg-gray-700"></div>
          <div className="w-full bg-gray-200 rounded-t-lg h-72 dark:bg-gray-700"></div>
          <div className="w-full h-64 bg-gray-200 rounded-t-lg dark:bg-gray-700"></div>
          <div className="w-full bg-gray-200 rounded-t-lg h-80 dark:bg-gray-700"></div>
          <div className="w-full bg-gray-200 rounded-t-lg h-72 dark:bg-gray-700"></div>
          <div className="w-full bg-gray-200 rounded-t-lg h-80 dark:bg-gray-700"></div>
        </div>
        <span className="sr-only">Loading...</span>
      </Card>
    </>
  );
};

export default WeeklyIncidentSkeleton;
