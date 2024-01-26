import { MdOutlineConnectedTv } from "react-icons/md";
import { CctvDetails } from "@/apis/cctvs.types";

interface CctvMarkerPopupProps {
  cctv: CctvDetails;
  onViewFootage: (cctv: CctvDetails) => void;
  onClose: () => void;
}
const CctvMarkerPopupContent = (props: CctvMarkerPopupProps) => {
  const { cctv, onViewFootage } = props;

  return (
    <div className="flex flex-col">
      <h5 className="font-bold">{cctv.name}</h5>
      <p>{cctv.description}</p>
      <div className="flex items-center justify-center ">
        <button
          onClick={() => onViewFootage(cctv)}
          className="mt-2 w-auto rounded-lg bg-lightPrimary p-[0.4rem]  font-medium text-brand-500 transition duration-200 hover:cursor-pointer hover:bg-gray-100 dark:bg-navy-700 dark:text-white dark:hover:bg-white/20 text-sm"
        >
          <span>
            View Footage
            <MdOutlineConnectedTv className="ml-1 h-4 w-4 inline-block" />
          </span>
        </button>
      </div>
    </div>
  );
};

export default CctvMarkerPopupContent;
