import React from "react";

const DangerTag = (props: React.PropsWithChildren) => {
  return (
    <span
      className={
        "mr-2 rounded px-2.5 py-0.5 text-xs font-medium bg-red-100 border border-red-400 text-red-700"
      }
    >
      {props.children}
    </span>
  );
};

export default DangerTag;
