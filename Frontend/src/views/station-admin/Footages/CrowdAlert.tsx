import { AlertLevels } from "./crowdAnalyser";

function CrowdAlert({ alertLevel }: { alertLevel: AlertLevels }) {
  let alertClasses = "";
  let alertText = "";

  // Determine alert classes and text based on the alertLevel
  switch (alertLevel) {
    case "NORMAL":
      alertClasses = "bg-blue-100 border border-blue-400 text-blue-700";
      alertText = "Everything is normal.";
      break;
    case "WARNING":
      alertClasses = "bg-yellow-100 border border-yellow-400 text-yellow-700";
      alertText = "Warning: Crowd levels are high.";
      break;
    case "DANGER":
      alertClasses = "bg-red-100 border border-red-400 text-red-700";
      alertText = "Danger: Critical crowd levels!";
      break;
    default:
      alertClasses = "bg-gray-100 border border-gray-400 text-gray-700";
      alertText = "Unknown alert level";
  }

  if (alertLevel === AlertLevels.NORMAL) return <></>;

  return (
    <div className={`px-4 py-3 rounded relative ${alertClasses}`} role="alert">
      <strong className="font-bold">{alertText}</strong>
      <span className="absolute top-0 bottom-0 right-0 px-4 py-3">
        <svg
          className="fill-current h-6 w-6 text-red-500"
          role="button"
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 20 20"
        >
          <title>Close</title>
          <path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z" />
        </svg>
      </span>
    </div>
  );
}

export default CrowdAlert;
