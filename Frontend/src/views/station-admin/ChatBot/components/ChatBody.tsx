import { Key, useEffect, useRef} from "react";
import autoAnimate from "@formkit/auto-animate";
import { useAppSelector } from "@/app/store";



const ChatMessage = ({ chat }) => {
  const admin = useAppSelector((state) => state.admin.data);
  const isAiMessage = chat?.role === "ai";
  const messageStyle = `border-[#999999] break-words border-1 rounded-lg p-2 ${
    isAiMessage ? "bg-[#FFFFFF22] dropshadow-md mr-auto" : ""
  }`;

  return (
    <>
        <div className={`flex ${isAiMessage ? "" : "self-end"}`}>
          {isAiMessage && (
            <img
              src="/chatbot.png"
              alt="chatbot"
              className="w-8 h-8 rounded-full mt-2 mr-2"
            />
          )}

          <div className={messageStyle}>
            <pre className="whitespace-pre-wrap font-sans">
              {chat.message}
            </pre>
          </div>

          {!isAiMessage && (
            <img
              src={admin?.photo? admin?.photo : "/user.png"}
              alt="User"
              className="w-8 h-8 rounded-full mt-2 ml-2"
            />
          )}
        </div>
    </>
  );
};

const ChatBody = ({ chatArr }) => {
  const parentRef = useRef(null);
  const bottomRef = useRef(null);

  useEffect(() => {
    if (parentRef.current) {
      autoAnimate(parentRef.current);
    }
  }, []);

  useEffect(() => {
    setTimeout(() => {
      bottomRef.current?.scrollIntoView({ behavior: "smooth", block: "end" });
    }, 200);
  }, [chatArr]);

  return (
    <>
      <div className="flex flex-col gap-4" ref={parentRef}>
        {chatArr.map((chat: any, i: Key) => {
          return (
            <ChatMessage
              key={i}
              chat={chat}
            />
          );
        })}

        <div ref={bottomRef} className="h-3"></div>
      </div>
    </>
  );
};

export default ChatBody;
