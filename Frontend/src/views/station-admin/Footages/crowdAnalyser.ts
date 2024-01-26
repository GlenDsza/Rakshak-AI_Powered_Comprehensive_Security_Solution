export const getRandomNumber = (min: number, max: number) => {
  return Math.floor(Math.random() * (max - min + 1)) + min;
};

export const getDefaultPeopleCountHistory = () => {
  const rawArray = Array.from({ length: 50 }, () => getRandomNumber(10, 25));
  const smoothedArray = [];

  for (let i = 0; i < rawArray.length; i++) {
    let sum = rawArray[i];
    let count = 1;

    if (i > 0) {
      sum += rawArray[i - 1];
      count++;
    }
    if (i < rawArray.length - 1) {
      sum += rawArray[i + 1];
      count++;
    }

    smoothedArray.push(Math.round(sum / count));
  }

  return smoothedArray;
};

export interface CrowdData {
  name: string;
  livePeopleCount: number;
  peopleCountHistory: number[];
  alert: AlertLevels;
  key: number | string;
}
export enum AlertLevels {
  NORMAL = "NORMAL",
  WARNING = "WARNING",
  DANGER = "DANGER",
}
const CrowdThresholds: Record<AlertLevels, number> = {
  NORMAL: 20,
  WARNING: 40,
  DANGER: Infinity,
};
export function getAlert(peopleCountHistory: number[]): AlertLevels {
  const last10Counts = peopleCountHistory.slice(-10); // Consider the last 10 counts
  for (const count of last10Counts) {
    if (count > CrowdThresholds.WARNING) {
      return AlertLevels.DANGER;
    } else if (count > CrowdThresholds.NORMAL) {
      return AlertLevels.WARNING;
    }
  }
  return AlertLevels.NORMAL;
}
