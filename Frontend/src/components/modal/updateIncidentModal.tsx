import {
  Modal,
  ModalOverlay,
  ModalContent,
  ModalBody,
  ModalCloseButton,
} from "@chakra-ui/modal";
import Card from "@/components/card";
import { MdCheckCircle } from "react-icons/md";
import { IoMdClose } from "react-icons/io";
import { BsClockHistory } from "react-icons/bs";
import { useAppDispatch } from "@/app/store";
import { updateIncident } from "@/app/features/IncidentSlice";

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

interface updateIncidentModalProps {
  incident: Incident;
  isUpdateIncidentModalOpen: boolean;
  onUpdateIncidentModalClose: () => void;
  updateData: (id: string, status: string) => void;
}

const UpdateIncidentModal = ({
  isUpdateIncidentModalOpen,
  onUpdateIncidentModalClose,
  incident,
  updateData,
}: updateIncidentModalProps) => {
  const dispatch = useAppDispatch();

  const handleBtnClick = (status: string) => {
    updateData(incident?.id, status);
    setTimeout(() => {
      dispatch(updateIncident({ id: incident?.id, status: status }));
    }, 10000);
    onUpdateIncidentModalClose();
  };

  return (
    <>
      <Modal
        isOpen={isUpdateIncidentModalOpen}
        onClose={onUpdateIncidentModalClose}
        size="md"
        isCentered
        scrollBehavior="inside"
      >
        <ModalOverlay
          className="bg-[#000000A0] !z-[1001]]"
          backdropFilter="blur(10px)"
        />
        <ModalContent className="!z-[1002] !m-auto !w-max min-w-[340px] !max-w-[85%] top-[3vh] md:top-[5vh]">
          <ModalCloseButton className="right-5 top-5 absolute z-[5000] text-navy-700  hover:text-navy-900 dark:text-gray-500 dark:hover:text-white" />
          <ModalBody className=" overflow-x-hidden">
            <Card extra="px-[30px] w-[340px] pt-[35px] pb-[40px] md-max:h-[90vh] flex flex-col !z-[1004] overflow-y-auto overflow-x-hidden">
              <h1
                className={`text-2xl text-navy-700 dark:text-white font-bold text-center mb-6`}
              >
                Incident {incident?.id}
              </h1>

              <div className="my-2 flex">
                <div className={`text-navy-700 dark:text-white font-bold mx-2`}>
                  Current Status:
                </div>
                <div className="flex items-center mx-2">
                  <p className="relative flex items-center text-sm dark:placeholder:!text-[rgba(255,255,255,0.15)] mr-3">
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

              <div className="my-2 flex flex-col">
                <div className={`text-navy-700 dark:text-white font-bold mx-2`}>
                  Set Status:
                </div>
                <div className="flex flex-row items-center mx-2 my-4 gap-4">
                  {incident?.status != "Pending" && (
                    <button
                      onClick={() => handleBtnClick("Pending")}
                      className={` flex items-center justify-center rounded-lg bg-navy-50   font-medium text-brand-600 transition duration-200
           hover:cursor-pointer hover:bg-gray-100 dark:bg-navy-700 dark:text-white dark:hover:bg-white/20 dark:active:bg-white/10 p-3`}
                    >
                      <BsClockHistory className="h-4 w-4 mr-2" /> Pending
                    </button>
                  )}
                  {incident?.status != "Closed" && (
                    <button
                      onClick={() => handleBtnClick("Closed")}
                      className={` flex items-center justify-center rounded-lg bg-navy-50   font-medium text-brand-600 transition duration-200
           hover:cursor-pointer hover:bg-gray-100 dark:bg-navy-700 dark:text-white dark:hover:bg-white/20 dark:active:bg-white/10 p-3`}
                    >
                      <IoMdClose className="h-4 w-4 mr-2" /> Closed
                    </button>
                  )}
                  {incident?.status != "Resolved" && (
                    <button
                      onClick={() => handleBtnClick("Resolved")}
                      className={`flex items-center justify-center rounded-lg bg-navy-50   font-medium text-brand-600 transition duration-200
           hover:cursor-pointer hover:bg-gray-100 dark:bg-navy-700 dark:text-white dark:hover:bg-white/20 dark:active:bg-white/10 p-3`}
                    >
                      <MdCheckCircle className="h-4 w-4 mr-2" /> Resolved
                    </button>
                  )}
                </div>
              </div>
            </Card>
          </ModalBody>
        </ModalContent>
      </Modal>
    </>
  );
};

export default UpdateIncidentModal;
