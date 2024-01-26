import { ReadyState } from "react-use-websocket";

export enum CCTV_TYPES {
  STATION_PREMISES = "station_premises",
  PUBLIC = "public",
  PRISON = "prison",
  ALL = "all",
}

export interface CctvDetails {
  id: string;
  cctv_type: CCTV_TYPES;
  name: string;
  description: string;
  latitude: number;
  longitude: number;
  streamUrl: string;
}

export const ReadyStateMap: Record<ReadyState, string> = {
  [ReadyState.UNINSTANTIATED]: "Not instantiated",
  [ReadyState.CONNECTING]: "Connecting ...",
  [ReadyState.OPEN]: "Open ...",
  [ReadyState.CLOSING]: "Closing ...",
  [ReadyState.CLOSED]: "Closed !",
};

