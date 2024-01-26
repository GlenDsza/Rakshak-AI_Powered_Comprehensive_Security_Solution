import {
  Modal,
  ModalOverlay,
  ModalContent,
  ModalBody,
  ModalCloseButton,
} from "@chakra-ui/modal";
import Card from "@/components/card";
import { MdCheckCircle } from "react-icons/md";
import { BsCardText, BsClockHistory } from "react-icons/bs";
import { getDateTime } from "@/constants/utils";
import { BiTimeFive, BiCategoryAlt, BiCctv } from "react-icons/bi";
import { MdOutlineLocationOn } from "react-icons/md";
import { IoImages } from "react-icons/io5";
import { FaTrash } from "react-icons/fa";
import { LiaUserShieldSolid } from "react-icons/lia";
import { useAppDispatch } from "@/app/store";
import { deleteIncident } from "@/app/features/IncidentSlice";
import { IoMdClose } from "react-icons/io";
import { SOURCES, getSource } from "../../constants/validations";

type Incident = {
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

interface IncidentModalProps {
  incident: Incident;
  isIncidentModalOpen: boolean;
  onIncidentModalClose: () => void;
  showSource: boolean;
}

const IncidentModal = ({
  isIncidentModalOpen,
  onIncidentModalClose,
  showSource,
  incident,
}: IncidentModalProps) => {
  
  const dispatch = useAppDispatch();
  const hasImage = incident?.image !== "";

  const handleDelete = (incident: Incident) => {
    dispatch(deleteIncident({ id: incident.id }));
    onIncidentModalClose();
  };

  return (
    <>
      <Modal
        isOpen={isIncidentModalOpen}
        onClose={onIncidentModalClose}
        size="xl"
        isCentered
        scrollBehavior="inside"
      >
        <ModalOverlay
          className="bg-[#000000A0] !z-[1001]]"
          backdropFilter="blur(10px)"
        />
        <ModalContent className="!z-[1002] !m-auto !w-max min-w-[350px] !max-w-[85%] top-[3vh] md:top-[5vh]">
          <ModalCloseButton className="right-5 top-5 absolute z-[5000] text-navy-700  hover:text-navy-900 dark:text-gray-500 dark:hover:text-white" />
          <ModalBody className=" overflow-x-hidden">
            <Card
              extra={`px-[30px] pt-[35px] pb-[40px] ${
                hasImage
                  ? "w-[85vw] md-max:h-[95vh]"
                  : "w-[85vw] md:w-[75vw] lg:w-[65vw] md-max:h-[90vh]"
              }  max-w-[950px] flex flex-col !z-[1004] overflow-y-auto overflow-x-hidden`}
            >
              <h1
                className={`mb-4 text-2xl text-navy-700 dark:text-white font-bold ${
                  !hasImage && "text-center mb-6"
                }`}
              >
                Incident {incident?.id}
              </h1>
              <div
                className={`my-2 grid grid-cols-1 ${
                  hasImage ? "md:grid-cols-4" : "md:grid-cols-2"
                }  sm:grid-cols-2 gap-4`}
              >
                <div className="relative flex-col my-2 sm:my-0">
                  <div className="flex items-center ">
                    <label
                      htmlFor="title"
                      className={`text-navy-700 dark:text-white font-bold ml-2`}
                    >
                      Title:
                    </label>
                  </div>

                  <input
                    disabled={true}
                    id="title"
                    value={incident?.title ? incident?.title : "-"}
                    className=" relative mt-2 flex h-12 w-full items-center justify-center rounded-xl border bg-white/0 p-3 text-sm outline-none !border-none !bg-gray-50 dark:!bg-white/5 dark:placeholder:!text-[rgba(255,255,255,0.15)]"
                  />
                </div>
                <div className="relative flex-col my-2 sm:my-0">
                  <div className="flex items-center ml-2">
                    <BiCategoryAlt className="text-navy-700 dark:text-white me-1" />
                    <label
                      htmlFor="category"
                      className={`text-navy-700 dark:text-white font-bold ml-1`}
                    >
                      Category:
                    </label>
                  </div>

                  <input
                    disabled={true}
                    id="category"
                    value={incident?.type ? incident?.type : "-"}
                    className=" relative mt-2 flex h-12 w-full items-center justify-center rounded-xl border bg-white/0 p-3 text-sm outline-none !border-none !bg-gray-50 dark:!bg-white/5 dark:placeholder:!text-[rgba(255,255,255,0.15)]"
                  />
                </div>
                <div className="relative flex-col my-2 md:my-0">
                  <div className="flex items-center ml-2">
                    <MdOutlineLocationOn className="text-navy-700 dark:text-white me-1" />
                    <label
                      htmlFor="location"
                      className={`text-navy-700 dark:text-white font-bold ml-1`}
                    >
                      Location:
                    </label>
                  </div>

                  <input
                    disabled={true}
                    id="location"
                    value={incident?.location ? incident?.location : "-"}
                    className=" relative mt-2 flex h-12 w-full items-center justify-center rounded-xl border bg-white/0 p-3 text-sm outline-none !border-none !bg-gray-50 dark:!bg-white/5 dark:placeholder:!text-[rgba(255,255,255,0.15)]"
                  />
                </div>
                <div className="relative flex-col my-2 md:my-0">
                  <label
                    htmlFor="status"
                    className={`text-navy-700 dark:text-white font-bold ml-2`}
                  >
                    Status:
                  </label>

                  <div className="flex items-center">
                    <p className="relative mt-2 flex h-12 w-full items-center rounded-xl border bg-white/0 p-3 text-sm outline-none !border-none !bg-gray-50 dark:!bg-white/5 dark:placeholder:!text-[rgba(255,255,255,0.15)] mr-3">
                      {incident?.status === "Pending" ? (
                        <BsClockHistory className="me-2 text-amber-500 dark:text-amber-300 inline" />
                      ) : incident?.status === "Resolved" ? (
                        <MdCheckCircle className="me-2 text-green-500 dark:text-green-300 inline" />
                      ) : (
                        <IoMdClose className="me-2 dark:text-white-300 inline" />
                      )}
                      {incident?.status}
                    </p>
                  </div>
                </div>
              </div>
              <div
                className={`grid grid-cols-1 sm:grid-cols-2 ${
                  hasImage ? "md:grid-cols-4" : "md:grid-cols-2"
                }   space-x-2 mt-3 mx-1 mr-5`}
              >
                <div className="relative flex-col col-span-2 sm:col-span-1 my-2 sm:my-0">
                  <div className="flex items-center ml-2">
                    <BiTimeFive className="text-navy-700 dark:text-white me-1" />
                    <label
                      htmlFor="date-time"
                      className={`text-navy-700 dark:text-white font-bold ml-1`}
                    >
                      Date & Time:
                    </label>
                  </div>
                  <input
                    disabled={true}
                    id="date-time"
                    value={
                      incident?.created_at
                        ? getDateTime(incident?.created_at.toString())
                        : "-"
                    }
                    className=" relative mt-2 flex h-12 w-full items-center justify-center rounded-xl border bg-white/0 p-3 text-sm outline-none !border-none !bg-gray-50 dark:!bg-white/5 dark:placeholder:!text-[rgba(255,255,255,0.15)] mr-3"
                  />
                </div>
                {showSource && (
                  <div className="relative flex-col cursor-default my-2 sm:my-0">
                    <div className="flex items-center ml-2">
                      <label
                        htmlFor="source"
                        className={`text-navy-700 dark:text-white font-bold ml-1`}
                      >
                        Source:
                      </label>
                    </div>
                    <div
                      id="source"
                      className=" relative mt-2 flex h-12 w-full items-center rounded-xl border bg-white/0 p-3 text-sm outline-none !border-none !bg-gray-50 dark:!bg-white/5 dark:placeholder:!text-[rgba(255,255,255,0.15)] mr-3"
                    >
                      {getSource(incident?.source) === SOURCES.CCTV ? (
                        <BiCctv className="h-5 w-5 text-navy-700 dark:text-white mr-2" />
                      ) : (
                        <LiaUserShieldSolid className="h-5 w-5 text-navy-700 dark:text-white mr-2" />
                      )}

                      <p>
                        {getSource(incident?.source) === SOURCES.USER ? "User Report" : incident?.source}
                      </p>
                    </div>
                  </div>
                )}
                <div
                  className={`relative flex-col my-2 md:my-0 ${
                    showSource ? "col-span-2" : "col-span-3"
                  } `}
                >
                  <div
                    className={`flex items-center ${hasImage && "sm:ml-5"} `}
                  >
                    <BsCardText className="text-navy-700 dark:text-white me-1" />
                    <label
                      htmlFor="description"
                      className={`text-navy-700 dark:text-white font-bold ml-1`}
                    >
                      Description:
                    </label>
                  </div>
                  <input
                    disabled={true}
                    id="description"
                    value={incident?.description ? incident?.description : "-"}
                    className=" relative mt-2 flex h-12 w-full items-center justify-center rounded-xl border bg-white/0 p-3 text-sm outline-none !border-none !bg-gray-50 dark:!bg-white/5 dark:placeholder:!text-[rgba(255,255,255,0.15)]"
                  />
                  <p id="description"></p>
                </div>
              </div>
              {hasImage && (
                <div className="my-3 mt-4 flex-col">
                  <div className="flex items-center ml-2">
                    <IoImages className="text-navy-700 dark:text-white me-1" />
                    <label
                      htmlFor="image"
                      className={`text-navy-700 dark:text-white font-bold ml-1`}
                    >
                      Images:
                    </label>
                  </div>

                  <img
                    id="image"
                    src={
                      incident?.image === ""
                        ? "https://static.toiimg.com/thumb/msid-65971726,imgsize-108452,width-400,resizemode-4/65971726.jpg"
                        : incident?.image
                    }
                    alt="Evidence"
                    className="mt-2 rounded-xl"
                    width={250}
                    height={250}
                  />
                </div>
              )}

              <div className="mt-4 flex justify-center gap-4">
                <button
                  onClick={() => handleDelete(incident)}
                  className={` flex items-center justify-center rounded-lg bg-navy-50   font-medium text-brand-600 transition duration-200
           hover:cursor-pointer hover:bg-gray-100 dark:bg-navy-700 dark:text-white dark:hover:bg-white/20 dark:active:bg-white/10 p-3`}
                >
                  <FaTrash className="h-4 w-4 mr-2" /> Delete
                </button>
              </div>
            </Card>
          </ModalBody>
        </ModalContent>
      </Modal>
    </>
  );
};

export default IncidentModal;
