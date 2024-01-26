import {
  Modal,
  ModalBody,
  ModalCloseButton,
  ModalContent,
  ModalOverlay,
  Button,
  Input,
  Select,
  useToast,
} from "@chakra-ui/react";
import React, { useState } from "react";

interface AssignPersonnelModalProps {
  onClose: () => void;
  targetLocation: string | null;
}

const AssignPersonnelModal = (props: AssignPersonnelModalProps) => {
  const [personnelName, setPersonnelName] = useState("Staff2");
  const [description, setDescription] = useState(
    "Handle crowd on Location 1"
  );
  const [isLoading, setIsLoading] = useState(false);
  const platformValue = props.targetLocation || "";
  const toast = useToast();

  const handlePersonnelNameChange = (
    event: React.ChangeEvent<HTMLInputElement>
  ) => {
    setPersonnelName(event.target.value);
  };

  const handleDescriptionChange = (
    event: React.ChangeEvent<HTMLInputElement>
  ) => {
    setDescription(event.target.value);
  };

  const handleCreateTaskClick = () => {
    setIsLoading(true); // Set isLoading to true to disable the button and show spinner

    setTimeout(() => {
      props.onClose();
      setIsLoading(false); // Set isLoading back to false after the timeout

      toast({
        title: "Task created successfully",
        status: "success",
        duration: 3000,
        isClosable: true,
      });

      console.log("Personnel Name:", personnelName);
      console.log("Description:", description);
      console.log("Location Number:", platformValue);
    }, 2000);
  };

  return (
    <Modal
      isOpen={props.targetLocation !== null && props.targetLocation.length > 0}
      onClose={props.onClose}
      size="md"
      isCentered
      scrollBehavior="inside"
    >
      <ModalOverlay
        className="bg-[#000000A0] !z-[1001]"
        backdropFilter="blur(10px)"
      />
      <ModalContent className="rounded-lg !z-[1002] !m-auto !w-max min-w-[350px] !max-w-[85%] top-[2vh] sm:top-[3vh]">
        <ModalCloseButton className="right-5 top-5 absolute z-[5000] text-[#000000A0] hover:text-navy-900" />
        <ModalBody className="bg-white p-4 border rounded-lg">
          <div className="grid gap-4 mb-4 sm:grid-cols-1">
            <div>
              <label
                htmlFor="personnelName"
                className="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
              >
                Personnel Name
              </label>
              <Input
                type="text"
                name="personnelName"
                id="personnelName"
                value={personnelName}
                onChange={handlePersonnelNameChange}
                placeholder="Enter Personnel Name"
              />
            </div>
            <div>
              <label
                htmlFor="platform"
                className="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
              >
                Location no.
              </label>
              <Select id="platform" value={platformValue} isDisabled>
                <option value={platformValue}>{platformValue}</option>
              </Select>
            </div>
            <div>
              <label
                htmlFor="description"
                className="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
              >
                Description
              </label>
              <Input
                type="text"
                name="description"
                id="description"
                value={description}
                onChange={handleDescriptionChange}
                placeholder="Enter Description"
              />
            </div>
          </div>
          <div className="flex justify-end">
            <Button
              onClick={handleCreateTaskClick}
              colorScheme="blue"
              variant="solid"
              isLoading={isLoading} // Use isLoading to disable and show spinner
              loadingText={<>Creating </>} // Loading spinner
            >
              Create Task
            </Button>
          </div>
        </ModalBody>
      </ModalContent>
    </Modal>
  );
};

export default AssignPersonnelModal;
