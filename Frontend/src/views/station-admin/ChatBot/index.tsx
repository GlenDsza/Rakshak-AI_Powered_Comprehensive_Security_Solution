import ChatBody from "./components/ChatBody";
import { useAppSelector } from "@/app/store";
import ChatInput from "./components/ChatInput";
import {  useState, useEffect } from "react";
import { Select } from '@chakra-ui/react'
import axios from "axios";

const Chatbot = () => {  
  const admin = useAppSelector((state) => state.admin.data);

  const [loading, setLoading] = useState(false);
  const [chat, setChat] = useState([]);

  const ingest = async () => {
    const res = await axios.get(
      `${import.meta.env.VITE_LLM_URL}/ingest?station=${admin.station_name}`
    );
    console.log(res.data);
    setChat((prev) => [
      ...prev,
      {
        role: "ai",
        message:
          `Hello ${admin.admin_name && admin.admin_name.split(" ", 1)}\nI'm your AI Assistant. I can help you get to speed with latest occurings🙂`,
      },
    ]);
  };

  useEffect(() => {
    try {
      ingest();
    } catch (error) {
      console.log(error);
      throw error;
    }
  }, []);

  const sendMessage = async (newMessage: { role: string; message: string; }) => {
    await Promise.resolve(setChat((prev) => [...prev, newMessage]));

    setLoading(true);
    try {
      const res = await axios.post(
        `${import.meta.env.VITE_LLM_URL}/qa`, {"prompt": newMessage.message}
      );
      await Promise.resolve(setChat((prev) => [...prev, {role: "ai", message: res.data.response}]));
    } catch (error) {
      console.log(error);
      throw error;
    }
    setLoading(false);
  }  

  const uploadImage = async () => {};

  return (
    <div>
      <div className="my-3 grid grid-cols-1">
        <div className="bg-[#1A232E] rounded-lg shadow-2xl  h-[87vh] py-6 relative text-white overflow-hidden flex flex-col justify-between align-middle">
      {/* gradients */}
      {/* <div className="gradient-01 z-0 absolute"></div> */}
      <div className="gradient-02 z-0 absolute bottom-1"></div>

      {/* Header */}
      
        <div className=" font-bold text-xl text-center mb-3">
          AI Assistant
        </div>
      
      
      {/* Chat Body */}
      <div className="h-[90%] overflow-auto w-full max-w-4xl min-w-[20rem] py-8 self-center px-4">
        <ChatBody chatArr={chat} />
      </div>

      {/* Input */}
      <div className="w-full max-w-4xl min-w-[20rem] self-center px-4">
        <ChatInput
          sendMessage={sendMessage}
          loading={loading}
          uploadImage={uploadImage}
        />
      </div>
    </div>
      </div>
    </div>
  );
};

export default Chatbot;
