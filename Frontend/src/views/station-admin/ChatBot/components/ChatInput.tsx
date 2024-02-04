import  { SetStateAction, useRef, useState } from "react";

interface ChatInputProps {
    sendMessage: (message: { role: string, message: string }) => void;
    uploadImage: Function; 
    loading: boolean;
  }

const ChatInput = ({ sendMessage, uploadImage, loading }: ChatInputProps) => {
  const [text, setText] = useState("");
  const uploadRef = useRef(null);

  const handleInputChange = (event: { target: { value: SetStateAction<string>; }; }) => {
    setText(event.target.value);
  };

  const handleSubmit = () => {
    if (text.trim() === "") return;
    sendMessage({ role: "user", message: text });
    setText("");
  };

  const handleImageUpload = () => {
    uploadRef.current.click();
    setTimeout(() => uploadImage(""), 25000);
    // uploadImage("");
  };

  // if (uploadRef.current !== null) {
  //   uploadRef.current.addEventListener("change", (event) => {
  //     const selectedFile = event.target.files[0];
  //     if (selectedFile) {
  //       console.log("hi");
  //       const imageUrl = URL.createObjectURL(selectedFile);
  //       uploadImage(imageUrl);
  //     }
  //   });
  // }

  const handleKeyDown = (event: { key: string; shiftKey: any; preventDefault: () => void; }) => {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault(); // Prevent new line on Enter
      handleSubmit();
    }
  };

  const numRows = Math.min(5, Math.max(1, Math.ceil(text.length / 46)));
  return (
    <div className="w-full bg-white bg-opacity-10 max-h-40 rounded-lg px-4 py-2 overflow-auto relative">
      {loading ? (
        <img src="/loader.gif" alt="loading..." className="w-8 m-auto" />
      ) : (
        <>
          <input
            type="file"
            id="imageInput"
            ref={uploadRef}
            className="hidden"
          />
          <img
            width={25}
            src="/upload.png"
            alt="Upload Image"
            onClick={handleImageUpload}
            className="absolute top-4 left-4 hover:cursor-pointer ease-in duration-100 hover:scale-125"
          />
          <textarea
            rows={numRows}
            value={text}
            onChange={handleInputChange}
            onKeyDown={handleKeyDown}
            className="border-0 w-11/12 bg-white bg-opacity-5 outline-none resize-none ml-8 pt-2"
          />
          <img
            width={20}
            src="/send.png"
            alt="send"
            onClick={handleSubmit}
            className="absolute top-3 right-3 hover:cursor-pointer ease-in duration-100 hover:scale-125 pt-1"
          />
        </>
      )}
    </div>
  );
};

export default ChatInput;
