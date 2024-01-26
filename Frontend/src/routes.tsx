// Admin Imports
import Dashboard from "@/views/station-admin/Dashboard";
import Reports from "@/views/station-admin/Reports";
import Incidents from "@/views/station-admin/Incidents";
import Footages from "@/views/station-admin/Footages";
import Staff from "@/views/station-admin/Staff";
import PublicCCTvs from "@/views/station-admin/PublicCCTVs";
import Annotate from "@/views/station-admin/Annotate";

// Auth Imports
import SignIn from "@/views/auth/SignIn";

// Icon Imports
import { MdHome, MdLock, MdReport, MdOutlineLocalPolice } from "react-icons/md";
import { TbReport } from "react-icons/tb";
import { BiCctv } from "react-icons/bi";
import { BsFillPeopleFill } from "react-icons/bs";

const routes = [
  {
    name: "Dashboard",
    layout: "/station-admin",
    path: "dashboard",
    icon: <MdHome className="h-6 w-6" />,
    component: <Dashboard />,
  },
  {
    name: "Reported Incidents",
    layout: "/station-admin",
    path: "reported-incidents",
    icon: <TbReport className="h-6 w-6" />,
    component: <Reports />,
  },
  {
    name: "Detected Incidents",
    layout: "/station-admin",
    path: "detected-incidents",
    icon: <MdReport className="h-6 w-6" />,
    component: <Incidents />,
  },
  {
    name: "Station Surveillance",
    layout: "/station-admin",
    path: "station-surveillance",
    icon: <MdOutlineLocalPolice className="h-6 w-6" />,
    component: <Footages />,
  },
  {
    name: "Public Surveillance",
    layout: "/station-admin",
    path: "public-surveillance",
    icon: <BiCctv className="h-6 w-6" />,
    component: <PublicCCTvs />,
  },
  {
    name: "Staff",
    layout: "/station-admin",
    path: "staff",
    icon: <BsFillPeopleFill className="h-6 w-6" />,
    component: <Staff />,
  },
  {
    name: "Annotate",
    layout: "/station-admin",
    path: "annotate",
    icon: <BsFillPeopleFill className="h-6 w-6" />,
    component: <Annotate />,
  },
  {
    name: "Sign In",
    layout: "/auth",
    path: "sign-in",
    icon: <MdLock className="h-6 w-6" />,
    component: <SignIn />,
  },
];
export default routes;
