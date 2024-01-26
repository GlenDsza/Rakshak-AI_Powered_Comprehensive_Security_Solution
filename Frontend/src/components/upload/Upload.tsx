import { MdFileUpload } from "react-icons/md";
import Card from "@/components/card";
import { ChangeEvent, useRef } from "react";

interface UploadProps {
  setImage: (file: File | null) => void;
}

const Upload: React.FC<UploadProps> = ({ setImage }) => {
  const fileInputRef = useRef(null);
  const handleFileInputChange = (e: ChangeEvent<HTMLInputElement>) => {
    const selectedFile = e.target.files?.[0]; // Get the first selected file
    setImage(selectedFile); // Call the setImage prop to set the selected image
  };
  return (
    <Card className="mb-3 h-full w-full rounded-[20px] my-3 bg-clip-border font-dm shadow-3xl shadow-shadow-500 dark:!bg-navy-800 dark:shadow-none 2xl:grid-cols-11">
      <div className="col-span-5 h-full w-full rounded-xl bg-blue-100 dark:!bg-navy-700 2xl:col-span-6">
        <button
          type="button"
          onClick={(e) => {
            e.preventDefault();
            fileInputRef.current?.click();
          }}
          className="flex h-full w-full flex-col items-center justify-center rounded-xl border-[2px] border-dashed border-gray-200 bg-blue-100 py-1 dark:!border-navy-700 lg:pb-0"
        >
          <MdFileUpload className="text-[30px] text-brand-500 dark:text-white" />
          <h4 className="text-lg font-bold text-brand-500 dark:text-white">
            Upload Files
          </h4>
          <p className="my-1 text-sm font-medium text-gray-900">
            PNG, JPG and GIF files are allowed
          </p>
        </button>
        <input
          ref={fileInputRef}
          type="file"
          name="coverImage"
          id="coverImage"
          accept=".png, .jpeg, .jpg multiple"
          className="hidden"
          onChange={handleFileInputChange}
        />
      </div>
    </Card>
  );
};

export default Upload;
