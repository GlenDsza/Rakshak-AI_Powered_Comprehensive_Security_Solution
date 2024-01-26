import { CctvDetails } from "../../../apis/cctvs.types";

import Card from "@/components/card";
import ReactApexChart from "react-apexcharts";
import { useState } from "react";
import { MdOutlineConnectedTv } from "react-icons/md";
import useCrowdCounter from "../Footages/Stream/useCrowdCounter";
import { CrowdData, getAlert } from "../Footages/crowdAnalyser";
import CCTVStream from "@/components/CctvStream/CCTVStream";

enum Tab {
  Footage = "Footage",
  Statistics = "Statistics",
}

interface PublicCctvFootagesProps {
  cctvs: CctvDetails[];
  onToggleMapDrawer: () => void;
}

const PublicCctvFootages = (props: PublicCctvFootagesProps) => {
  const { cctvs, onToggleMapDrawer } = props;
  const [activeTab, setActiveTab] = useState<Tab>(Tab.Footage);

  const { livePeopleCount: liveCount1, peopleCountHistory: history1 } =
    useCrowdCounter(cctvs[0]?.streamUrl);
  const { livePeopleCount: liveCount2, peopleCountHistory: history2 } =
    useCrowdCounter(cctvs[0]?.streamUrl);
  const { livePeopleCount: liveCount3, peopleCountHistory: history3 } =
    useCrowdCounter(cctvs[0]?.streamUrl);
  const { livePeopleCount: liveCount4, peopleCountHistory: history4 } =
    useCrowdCounter(cctvs[0]?.streamUrl);

  const liveCounts = [liveCount1, liveCount2, liveCount3, liveCount4];
  const histories = [history1, history2, history3, history4];

  const cctvWiseCrowd: CrowdData[] = cctvs.map((cctv, idx) => ({
    livePeopleCount: liveCounts[idx % 4],
    peopleCountHistory: histories[idx % 4],
    name: cctv.name,
    key: cctv.id,
    alert: getAlert(history1),
  }));

  // Aggregate live and historical data for all platforms
  const combinedData = cctvWiseCrowd.map((cctvCrowdData) => ({
    label: cctvCrowdData.name,
    live: cctvCrowdData.livePeopleCount,
    history: cctvCrowdData.peopleCountHistory.reduce(
      (sum, count) => sum + count,
      0
    ),
  }));

  const platformWiseSeries = cctvWiseCrowd.map((platformData) => ({
    name: platformData.name,
    data: platformData.peopleCountHistory,
  }));
  const liveSeries = combinedData.map((data) => data.live);
  const historySeries = combinedData.map((data) => data.history);

  return (
    <div>
      <div className="text-sm font-medium text-center text-gray-500 border-b border-gray-200 dark:text-gray-400 dark:border-gray-700">
        <div className="flex justify-between">
          <div className="">
            <ul className="flex flex-wrap -mb-px">
              {Object.values(Tab).map((currentTab) => (
                <li className="mr-2" key={currentTab}>
                  <a
                    href="#"
                    onClick={() => setActiveTab(currentTab)}
                    className={`inline-block p-4 ${
                      activeTab == currentTab
                        ? "active text-blue-600 border-b-2 border-blue-600 rounded-t-lg active dark:text-blue-500 dark:border-blue-500"
                        : "border-b-2 border-transparent rounded-t-lg text-gray-700 hover:text-gray-800 hover:border-gray-800 dark:hover:text-gray-800 "
                    }`}
                  >
                    {currentTab}
                  </a>
                </li>
              ))}
            </ul>
          </div>
          <div className="flex flex-wrap justify-items-end mx-3">
            <button
              onClick={onToggleMapDrawer}
              className={` flex items-center justify-center rounded-lg bg-lightPrimary p-[0.4rem]  font-medium text-brand-500 transition duration-200 hover:cursor-pointer hover:bg-gray-100 dark:bg-navy-700 dark:text-white dark:hover:bg-white/20 dark:active:bg-white/10 ml-auto me-2 text-sm`}
            >
              <span> Add footage </span>
              <MdOutlineConnectedTv className="ml-1 h-4 w-4" />
            </button>
          </div>
        </div>
      </div>

      {activeTab === Tab.Footage && (
        <div
          className="mx-3 mt-3 grid grid-cols-1 gap-5 md:grid-cols-2"
          style={{
            display: activeTab === Tab.Footage ? "grid" : "none",
          }}
        >
          {cctvs.map((cctv) => (
            <CCTVStream
              cctv={cctv}
              key={cctv.id}
              climbingMode={false}
              suspiciousMode={false}
              violenceMode={false}
              weaponsMode={true}
              fireMode
              accidentMode={cctv.id !== "cctv_p05"}
              crackMode={false}
              tamperMode={false}
              faceMode={true}
            />
          ))}
        </div>
      )}

      <>
        <div
          className="p-2 mx-3 mt-3 grid grid-cols-1 gap-5 md:grid-cols-2"
          style={{
            visibility: activeTab === Tab.Statistics ? "visible" : "hidden",
            display: activeTab === Tab.Statistics ? "grid" : "none",
          }}
        >
          <Card extra="min-h-[40vh]">
            <div className="p-3">
              <ReactApexChart
                options={{
                  chart: {
                    id: "platform-wise-data-pie",
                    type: "pie",
                    height: 350,
                  },
                  title: {
                    text: "Live Crowd distribution",
                    align: "left",
                  },
                  labels: combinedData.map((data) => data.label),
                }}
                series={liveSeries}
                type="pie"
                width={380}
              />
              <br />
              <ReactApexChart
                options={{
                  chart: {
                    id: "platform-wise-data-pie",
                    type: "pie",
                    height: 500,
                  },
                  title: {
                    text: "Overall Crowd distribution",
                    align: "left",
                  },
                  labels: combinedData.map((data) => data.label),
                }}
                series={historySeries}
                type="pie"
                width={380}
              />
            </div>
          </Card>
          <Card>
            <div className="p-3">
              <ReactApexChart
                series={platformWiseSeries}
                options={{
                  chart: {
                    height: 900,
                    width: 1000,
                    type: "area",
                    // stacked: true,
                    zoom: {
                      enabled: true,
                      type: "x",
                      autoScaleYaxis: false,
                      zoomedArea: {
                        fill: {
                          color: "#90CAF9",
                          opacity: 0.4,
                        },
                        stroke: {
                          color: "#0D47A1",
                          opacity: 0.4,
                          width: 1,
                        },
                      },
                    },
                  },
                  xaxis: {
                    range: 7,
                    labels: {
                      show: false,
                    },
                  },
                  dataLabels: {
                    enabled: false,
                  },
                  tooltip: {
                    style: {
                      fontSize: "10px",
                    },
                  },
                  stroke: {
                    curve: "smooth",
                  },
                }}
                type="area"
              />
            </div>
          </Card>
        </div>
      </>
    </div>
  );
};

export default PublicCctvFootages;
