import { useState } from "react";
import Dropdown from "@/components/dropdown";
import { FiAlignJustify } from "react-icons/fi";
import { Link } from "react-router-dom";
import { FiSearch } from "react-icons/fi";
import { RiMoonFill, RiSunFill } from "react-icons/ri";
import { IoMdNotificationsOutline } from "react-icons/io";
import avatar from "@/assets/img/defaultAvatar.jpg";
import { useAppDispatch, useAppSelector } from "@/app/store";
import { clearAdmin } from "@/app/features/AdminSlice";
import { MdReport } from "react-icons/md";
import { TbReport } from "react-icons/tb";
import { truncateString } from "@/constants/utils";
import { IoMdCheckmarkCircleOutline } from "react-icons/io";
import {
  readAllNotifications,
  readNotification,
} from "@/app/features/NotificationSlice";

const Navbar = (props: {
  onOpenSidenav: () => void;
  brandText: string;
  secondary?: boolean | string;
  currentRoute?: string;
}) => {
  const dispatch = useAppDispatch();
  const { onOpenSidenav, brandText, currentRoute } = props;
  const [darkmode, setDarkmode] = useState(false);
  const admin = useAppSelector((state) => state.admin.data);
  const notifications = useAppSelector((state) => state.notifications.data);
  const isSearchVisible =
    currentRoute === "Dashboard" || currentRoute === "CCTV Footage";

  const handleClick = (type: string) => {
    if (type === "incident") {
      return "/station-admin/detected-incidents";
    } else if (type === "report") {
      return "/station-admin/reported-incidents";
    }
  };

  const handleRead = (id: string) => {
    console.log("Read clicked");
    dispatch(
      readNotification({
        id: id,
        station_name: admin?.station_name,
      })
    );
  };

  const handleReadAll = () => {
    dispatch(
      readAllNotifications({
        station_name: admin?.station_name,
      })
    );
  };

  return (
    <nav className="sticky top-4 z-40 flex flex-row flex-wrap items-center justify-between rounded-xl bg-white/10 p-2 backdrop-blur-xl dark:bg-[#0b14374d]">
      <div className="ml-[6px]">
        <div className="h-6 w-[324px] pt-1">
          <a
            className="text-sm font-normal text-navy-700 hover:underline dark:text-white dark:hover:text-white"
            href=" "
          >
            {admin?.station_name} 
            <span className="mx-1 text-sm text-navy-700 hover:text-navy-700 dark:text-white">
              {" "}
              /{" "}
            </span>
          </a>
          <Link
            className="text-sm font-normal capitalize text-navy-700 hover:underline dark:text-white dark:hover:text-white"
            to="#"
          >
            {brandText}
          </Link>
        </div>
        <p className="shrink text-[33px] capitalize text-navy-700 dark:text-white">
          <Link
            to="#"
            className="font-bold capitalize hover:text-navy-700 dark:hover:text-white"
          >
            {brandText}
          </Link>
        </p>
      </div>

      <div
        className={`relative mt-[3px] flex h-[61px] flex-grow items-center  justify-around rounded-full bg-white px-2 py-2 shadow-xl shadow-shadow-500 ease-in dark:!bg-navy-800 dark:shadow-none md:flex-grow-0  ${
          isSearchVisible ? "gap-2 xl:gap-3" : "gap-4 pl-4 xl:gap-5"
        }`}
      >
        {isSearchVisible ? (
          <div className="flex h-full items-center rounded-full bg-lightPrimary text-navy-700 ease-in-out dark:bg-navy-900 dark:text-white xl:w-[225px]">
            <p className="pl-3 pr-2 text-xl">
              <FiSearch className="h-4 w-4 text-gray-400 dark:text-white" />
            </p>
            <input
              type="text"
              placeholder="Search..."
              className="block h-full w-full rounded-full bg-lightPrimary text-sm font-medium text-navy-700 outline-none placeholder:!text-gray-400 dark:bg-navy-900 dark:text-white dark:placeholder:!text-white sm:w-fit"
            />
          </div>
        ) : (
          ""
        )}

        <span
          className="flex cursor-pointer text-xl text-gray-600 dark:text-white xl:hidden"
          onClick={onOpenSidenav}
        >
          <FiAlignJustify className="h-5 w-5" />
        </span>
        {/* start Notification */}
        <Dropdown
          button={
            <div className="relative">
              <IoMdNotificationsOutline className="h-6 w-6 text-gray-600 dark:text-white" />
              <div
                className={`absolute top-0 right-0  w-4 h-4  linear flex items-center justify-center rounded-full bg-brand-500 p-2 text-xs font-bold text-white transition duration-200
           hover:cursor-pointer dark:active:bg-white/10 ${
             notifications?.length === 0 && "hidden"
           }`}
              >
                {notifications?.length}
              </div>
            </div>
          }
          animation="origin-[65%_0%] md:origin-top-right transition-all duration-300 ease-in-out"
          children={
            <div className="flex w-[360px] flex-col gap-3 rounded-[20px] bg-white p-4 shadow-xl shadow-shadow-500 dark:!bg-navy-700 dark:text-white dark:shadow-none sm:w-[460px]">
              <div className="flex items-center justify-between">
                <p className="text-base font-bold text-navy-700 dark:text-white">
                  Notifications
                </p>
                {notifications?.length > 1 && (
                  <p
                    className="text-sm font-bold text-navy-700 dark:text-white"
                    onClick={handleReadAll}
                  >
                    Mark all read
                  </p>
                )}
              </div>
              <hr />

              {notifications?.length > 0
                ? notifications.map((notification) => (
                    <Link
                      key={notification?.id}
                      to={handleClick(notification?.type)}
                      className="flex w-full items-center"
                    >
                      <div className="flex h-full p-2 bg-blueSecondary items-center justify-center rounded-xl bg-gradient-to-b from-brandLinear to-brand-500  text-2xl text-white">
                        {notification?.type === "incident" ? (
                          <MdReport className="h-6 w-6" />
                        ) : (
                          <TbReport className="h-6 w-6" />
                        )}
                      </div>
                      <div className="ml-2 flex h-full w-full flex-col justify-center rounded-lg px-1 text-sm">
                        <p className="mb-1 text-left text-base font-bold text-gray-900 dark:text-white">
                          {truncateString(notification?.title, 50)}
                        </p>
                        <p className="font-base text-left text-xs text-gray-900 dark:text-white">
                          {truncateString(notification?.description, 75)}
                        </p>
                      </div>
                      <button
                        onClick={() => {
                          handleRead(notification?.id);
                        }}
                        className={`linear mx-1 flex items-center justify-center rounded-lg bg-lightPrimary p-2 text-xl font-bold text-brand-500 transition duration-200
           hover:cursor-pointer hover:bg-gray-100 dark:bg-navy-700 dark:text-white dark:hover:bg-white/20 dark:active:bg-white/10`}
                      >
                        <IoMdCheckmarkCircleOutline className="h-5 w-5" />
                      </button>
                    </Link>
                  ))
                : "No new notifications"}
            </div>
          }
          classNames={"py-2 top-4 -left-[230px] md:-left-[440px] w-max"}
        />
        <div
          className="cursor-pointer text-gray-600"
          onClick={() => {
            if (darkmode) {
              document.body.classList.remove("dark");
              setDarkmode(false);
            } else {
              document.body.classList.add("dark");
              setDarkmode(true);
            }
          }}
        >
          {darkmode ? (
            <RiSunFill className="h-4 w-4 text-gray-600 dark:text-white" />
          ) : (
            <RiMoonFill className="h-4 w-4 text-gray-600 dark:text-white" />
          )}
        </div>
        {/* Profile & Dropdown */}
        <Dropdown
          button={
            <img
              className="h-10 w-10 rounded-full"
              src={avatar}
              alt="Elon Musk"
            />
          }
          children={
            <div className="flex h-48 w-56 flex-col justify-start rounded-[20px] bg-white bg-cover bg-no-repeat shadow-xl shadow-shadow-500 dark:!bg-navy-700 dark:text-white dark:shadow-none">
              <div className="ml-4 mt-3">
                <div className="flex items-center gap-2">
                  <p className="text-sm font-bold text-navy-700 dark:text-white">
                    👋 Hello, {admin?.admin_name}
                  </p>{" "}
                </div>
              </div>
              <div className="mt-3 h-px w-full bg-gray-200 dark:bg-white/20 " />

              <div className="ml-4 mt-3 flex flex-col">
                <a
                  href=" "
                  className="text-sm text-gray-800 dark:text-white hover:dark:text-white"
                >
                  Profile Settings
                </a>
                <a
                  href=" "
                  className="mt-3 text-sm text-gray-800 dark:text-white hover:dark:text-white"
                >
                  Newsletter Settings
                </a>
                <Link
                  to="/auth/sign-in"
                  className="mt-3 text-sm font-medium text-red-500 hover:text-red-500"
                  onClick={() => {
                    localStorage.removeItem("id");
                    localStorage.removeItem("role");
                    localStorage.removeItem("persist");
                    dispatch(clearAdmin());
                  }}
                >
                  Log Out
                </Link>
              </div>
            </div>
          }
          classNames={"py-2 top-8 -left-[180px] w-max"}
        />
      </div>
    </nav>
  );
};

export default Navbar;
