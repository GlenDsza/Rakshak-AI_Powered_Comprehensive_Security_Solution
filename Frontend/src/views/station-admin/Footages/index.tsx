import { useEffect, useState } from "react";
import { CCTV_TYPES, CctvDetails } from "@/apis/cctvs.types";
import {
  NO_OF_PREMISE_DEFAULT_CCTVS,
  NO_OF_PRISON_DEFAULT_CCTVS,
} from "@/constants/config";
import { getCctvs } from "@/apis/cctvs";
import CCTVStream from "@/components/CctvStream/CCTVStream";

enum Tab {
  Prison_Footage = "Prison",
  Premises_Footage = "Station Premises",
}
const TabToCctvTypeMapping: Record<Tab, CCTV_TYPES> = {
  [Tab.Prison_Footage]: CCTV_TYPES.PRISON,
  [Tab.Premises_Footage]: CCTV_TYPES.STATION_PREMISES,
};

const Footages = () => {
  const [activeTab, setActiveTab] = useState<Tab>(Tab.Prison_Footage);
  const [shownCctvs, setShownCctvs] = useState<CctvDetails[]>([]);

  useEffect(() => {
    getCctvs(TabToCctvTypeMapping[activeTab]).then((cctvs) =>
      setShownCctvs(
        cctvs.slice(
          0,
          activeTab === Tab.Prison_Footage
            ? NO_OF_PRISON_DEFAULT_CCTVS
            : NO_OF_PREMISE_DEFAULT_CCTVS
        )
      )
    );
  }, [activeTab]);

  // console.log(shownCctvs);

  return (
    <div>
      <div className="text-sm font-medium text-center text-gray-500 border-b border-gray-200 dark:text-gray-400 dark:border-gray-700">
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

      <div className="mx-3 mt-3 grid grid-cols-1 gap-5 md:grid-cols-2">
        {shownCctvs.map((cctv) => (
          <CCTVStream
            cctv={cctv}
            key={cctv.id}
            climbingMode={cctv.cctv_type === CCTV_TYPES.STATION_PREMISES}
            suspiciousMode={false}
            violenceMode={false}
            weaponsMode={cctv.cctv_type === CCTV_TYPES.PRISON}
            accidentMode={false}
            fireMode={false}
            crackMode={
              cctv.cctv_type === CCTV_TYPES.PRISON && cctv.id === "cctv_c00"
              // true
            }
            tamperMode={false}
            faceMode={false}
            // tamperMode={
            //   cctv.cctv_type === CCTV_TYPES.PRISON && cctv.id === "cctv_c01"
            // }
          />
        ))}
      </div>
    </div>
  );
};

export default Footages;
