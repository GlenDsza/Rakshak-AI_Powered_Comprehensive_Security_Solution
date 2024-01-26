// Custom components
// import { AiOutlineEyeInvisible, AiOutlineEye } from "react-icons/ai";
function InputField(props: {
  id: string;
  label: string;
  extra: string;
  placeholder: string;
  variant: string;
  state?: string;
  disabled?: boolean;
  type?: string;
  pattern?: string;
  maxLength?: number;
  minLength?: number;
  value?: string;
  errorMsg?: string;
  showPassword?: boolean;
  onChange?: (e: React.ChangeEvent<HTMLInputElement>) => void;
}) {
  const {
    label,
    id,
    extra,
    type,
    placeholder,
    variant,
    state,
    disabled,
    pattern,
    maxLength,
    minLength,
    value,
    errorMsg,
    showPassword,
    onChange,
  } = props;

  return (
    <div className={`${extra} relative flex-col`}>
      <label
        htmlFor={id}
        className={`text-sm text-navy-700 dark:text-white ${
          variant === "auth" ? "ml-1.5 font-medium" : "ml-3 font-bold"
        }`}
      >
        {label}
      </label>
      <input
        disabled={disabled}
        type={type}
        id={id}
        placeholder={placeholder}
        pattern={pattern}
        maxLength={maxLength}
        minLength={minLength}
        value={value}
        onChange={onChange}
        className={` relative mt-2 flex h-12 w-full items-center justify-center rounded-xl border bg-white/0 p-3 text-sm outline-none ${
          disabled === true
            ? "!border-none !bg-gray-100 dark:!bg-white/5 dark:placeholder:!text-[rgba(255,255,255,0.15)]"
            : state === "error"
            ? "border-red-500 text-red-500 placeholder:text-red-500 dark:!border-red-400 dark:!text-red-400 dark:placeholder:!text-red-400"
            : state === "success"
            ? "border-green-500 text-green-500 placeholder:text-green-500 dark:!border-green-400 dark:!text-green-400 dark:placeholder:!text-green-400"
            : "border-gray-200 dark:!border-white/10 dark:text-white"
        }`}
      />
      {/* <div className="absolute right-4 top-11 ">
        {type == "password" && !showPassword ? (
          <AiOutlineEyeInvisible className="h-6 w-6 " />
        ) : type == "password" && showPassword ? (
          <AiOutlineEye className="h-6 w-6 " />
        ) : (
          ""
        )}
      </div> */}

      <p
        className={`mt-1 text-xs text-red-500 dark:text-red-400 ${
          state === "error" ? "block" : "hidden"
        }`}
      >
        {errorMsg}
      </p>
    </div>
  );
}

export default InputField;
