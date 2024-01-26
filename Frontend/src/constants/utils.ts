export const truncateString = (str: string, maxLength: number) => {
  return str.length <= maxLength ? str : str.slice(0, maxLength - 3) + "...";
};

export const getDate = (inputDateString: string): string => {
  const date = new Date(inputDateString);
  const options: Intl.DateTimeFormatOptions = {
    day: "2-digit",
    month: "short",
    year: "numeric",
  };
  const formattedDate = new Intl.DateTimeFormat("en-US", options).format(date);
  return formattedDate;
};

export const getTime = (inputDateString: string): string => {
  const date = new Date(inputDateString);
  const hours = date.getHours();
  const minutes = date.getMinutes();
  const period = hours >= 12 ? "pm" : "am";
  const formattedHours = hours % 12 || 12; // Convert to 12-hour format

  const formattedTime = `${formattedHours}:${String(minutes).padStart(
    2,
    "0"
  )} ${period}`;

  return formattedTime;
};

export const getDateTime = (inputDateString: string): string => {
  const formattedTime = getTime(inputDateString);
  const formattedDate = getDate(inputDateString);

  return `${formattedDate} - ${formattedTime}`;
};
