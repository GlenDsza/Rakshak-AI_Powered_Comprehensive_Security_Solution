import { useState, useEffect } from "react";
import useWebSocket, { ReadyState } from "react-use-websocket";
import {
  getDefaultPeopleCountHistory,
  getRandomNumber,
} from "../crowdAnalyser";

const useCrowdCounter = (socketUrl: string) => {
  const [messageHistory, setMessageHistory] = useState([]);
  const [peopleCountHistory, setPeopleCountHistory] = useState<number[]>(
    getDefaultPeopleCountHistory()
  );
  const [livePeopleCount, setLivePeopleCount] = useState<number>(
    getRandomNumber(0, 30)
  );
  const [connectionStatus, setConnectionStatus] = useState("Uninstantiated");

  const { lastMessage, readyState } = useWebSocket(socketUrl);

  useEffect(() => {
    setConnectionStatus(
      {
        [ReadyState.CONNECTING]: "Connecting",
        [ReadyState.OPEN]: "Open",
        [ReadyState.CLOSING]: "Closing",
        [ReadyState.CLOSED]: "Closed",
        [ReadyState.UNINSTANTIATED]: "Uninstantiated",
      }[readyState]
    );
  }, [readyState]);

  useEffect(() => {
    if (lastMessage !== null) {
      setMessageHistory((prev) => prev.concat(lastMessage));
      setPeopleCountHistory((prev) => prev.concat(Number(lastMessage.data)));
      setLivePeopleCount(Number(lastMessage.data));
    }
  }, [lastMessage]);

  return {
    livePeopleCount,
    messageHistory,
    peopleCountHistory,
    connectionStatus,
  };
};

export default useCrowdCounter;
