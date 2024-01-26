import axios from "axios";
import { useState } from "react";
import { Allotment } from "allotment";
import { AnnotationsEditor } from "react-img-annotation";

import { CCTV_TYPES, CctvDetails } from "../../../apis/cctvs.types";
import { useLocation, useNavigate } from "react-router-dom";
import { base64ToBlob } from "../../../utils/files";

import "./annotate.css";
import { toast } from "react-toastify";

interface AnnotateProps {}
const Annotate: React.FC<AnnotateProps> = () => {
  const DefaultRouterState = {
    cctv: {
      id: "cctv_p01",
      cctv_type: CCTV_TYPES.STATION_PREMISES,
      name: "Gate #1",
      description: "Amboli prison, Andheri",
      streamUrl:
        "https://res.cloudinary.com/dp0ayty6p/video/upload/v1704612681/samples/prison_escape.mp4",
      latitude: 72.829,
      longitude: 19.138,
    },
    frameBuffer: [
      "https://placekitten.com/408/287",
      "https://placekitten.com/408/287",
      "https://placekitten.com/408/287",
      "https://placekitten.com/408/288",
      "https://placekitten.com/408/288",
    ],
  };

  const location = useLocation();
  const navigate = useNavigate();
  const receivedRouterState: { cctv: CctvDetails; frameBuffer: string[] } =
    location.state || DefaultRouterState;
  const cctv = receivedRouterState.cctv || DefaultRouterState.cctv;
  const receivedFrames: string[] =
    receivedRouterState.frameBuffer || DefaultRouterState.frameBuffer;

  console.log({ receivedFrames, cctv });

  const annotationOptions = ["fire", "accident", "pistol", "gun"].map(
    (detection) => ({
      label: detection,
      value: detection,
    })
  );

  const [fightClassification, setFightClassification] = useState(false);
  const [climbClassification, setClimbClassification] = useState(false);

  const [rectangles, setRectangles] = useState([]);

  const submitAnnotation = () => {
    const annotationData = {
      annotations: rectangles,
      fightClassification,
      climbClassification,
    };
    console.log("Submit", annotationData);

    const formData = new FormData();
    formData.append("image", base64ToBlob(selectedImage), "image.jpg");
    formData.append("json_data", JSON.stringify(annotationData));

    console.log("Send form", formData, Array.from(formData.entries()));

    axios
      .post(
        // `https://c157-103-23-239-46.ngrok-free.app/anotations/create_anotation`,
        `${import.meta.env.VITE_BACKEND_URL}/anotations/create_anotation`,
        formData
      )
      .then((data) => {
        console.log("Success:", data);
        toast.success("Submitted feedback for inaccuracy", {
          position: "bottom-left",
          autoClose: 2000,
        });
        navigate("/station-admin/dashboard");
      })
      .catch((error) => {
        console.error("Error:", error);
      });

    // fetch(
    //   "https://c157-103-23-239-46.ngrok-free.app/anotations/create_anotation",
    //   {
    //     method: "POST",
    //     body: formData,
    //   }
    // )
    //   .then((response) => response.json())
    //   .then((data) => {
    //     // Handle the response data
    //     console.log("Success:", data);
    //   })
    //   .catch((error) => {
    //     // Handle errors
    //     console.error("Error:", error);
    //   });
  };
  console.log("Rect", { rectangles });

  const [selectedImage, setSelectedImage] = useState(receivedFrames[0]);

  const classificationOptions = ["Yes", "No"];

  return (
    <div>
      <h2>Annotate image</h2>
      <Allotment className="annotation-container rounded-[20px]">
        <Allotment.Pane
          snap={false}
          minSize={700}
          preferredSize="70%"
          className="labeler-container-pane"
        >
          <div className="!z-5 relative flex flex-col bg-white bg-clip-border shadow-3xl shadow-shadow-500 dark:!bg-navy-700 dark:text-white dark:shadow-none w-full h-full sm:overflow-y-auto annotation-options labeler-container overflow-x-hidden">
            <div className="annotation-editor-container">
              <AnnotationsEditor
                annotations={[]}
                onChange={(newattr: { id: number }) => {
                  setRectangles((rectangles) =>
                    rectangles.map((rect) => {
                      if (rect.id === newattr.id) {
                        return { ...rect, ...newattr };
                      }
                      return rect;
                    })
                  );
                }}
                onAddAnnotation={(annotation: unknown) => {
                  setRectangles((rectangles) => [...rectangles, annotation]);
                }}
                onDeleteAnnotation={(deletedId: number) => {
                  setRectangles((rectangles) =>
                    rectangles.filter((rect) => rect.id !== deletedId)
                  );
                  // console.log(deletedId);
                }}
                onFieldSelectChange={(change: {
                  boxId: number;
                  tempSelectedOptions: { label: string; value: string };
                }) => {
                  // console.log("Field change", change);
                  setRectangles((prevRect) => {
                    const foundRect = prevRect.find(
                      (rect) => rect.id == change.boxId
                    );
                    foundRect.selectedOptions = change.tempSelectedOptions;
                    return [...prevRect];
                  });
                }}
                // onAnnotationSelected={(shapeProps) => {
                //   console.log(shapeProps);
                // }}
                options={annotationOptions}
                image={selectedImage}
                width={800}
                height={400}
                disabledOptions={["field one"]}
                highlightedAnnotations={[]}
                // default rect styling, check konva rect for all props
                defaultAnnotationStyle={{
                  stroke: "red",
                  fill: "transparent",
                }}
                // higlighted rect styling, check konva rect for all props
                highlightedAnnotationStyle={{
                  stroke: "blue",
                  fill: "transparent",
                }}
                // transformer styling, check konva transformer for all props
                transformerStyle={{ anchorFill: "green", borderStroke: "red" }}
                showLabels={true} // shows labels on top of the rectangles
                rectLabelPositionFunc={() => {
                  // control position of labels (default is on top)
                  return {
                    top: 25,
                    left: 25,
                  };
                }}
              />
            </div>
            <div className="annotation-images-list-container">
              <div className="annotation-images-list flex space-x-2 overflow-x-auto">
                {receivedFrames.map((frameSrc, idx) => (
                  <img
                    key={frameSrc + idx}
                    src={frameSrc}
                    alt={"Label frame"}
                    className="cursor-pointer hover:opacity-75 max-h-16"
                    onClick={() => setSelectedImage(frameSrc)}
                  />
                ))}
              </div>
            </div>
          </div>
        </Allotment.Pane>
        <Allotment.Pane
          snap={false}
          minSize={200}
          className="annotation-options-pane"
        >
          <div className="!z-5 p-4 relative flex flex-col bg-clip-border shadow-3xl shadow-shadow-500 dark:!bg-navy-700 dark:text-white dark:shadow-none font-bold w-full h-full sm:overflow-y-auto overflow-x-hidden annotation-options">
            <div className="text-xl">Report incaccuracy</div>
            <div>CCTV ID - {cctv.id}</div>
            <div className="my-2">
              Is there fight in the footage ?
              <select
                className="mx-3 rounded border p-1 text-navy-700 dark:bg-navy-700 dark:text-white"
                value={fightClassification ? "Yes" : "No"}
                onChange={(e) =>
                  setFightClassification(
                    e.target?.value === classificationOptions[0]
                  )
                }
              >
                {classificationOptions.map((option) => (
                  <option value={option}>{option}</option>
                ))}
              </select>
            </div>
            <div className="my-2">
              Is there climbing in the footage ?
              <select
                className="mx-1 rounded border p-1 text-navy-700 dark:bg-navy-700 dark:text-white"
                value={climbClassification ? "Yes" : "No"}
                onChange={(e) =>
                  setClimbClassification(
                    e.target?.value === classificationOptions[0]
                  )
                }
              >
                {classificationOptions.map((option) => (
                  <option value={option}>{option}</option>
                ))}
              </select>
            </div>

            <button
              className="linear mt-4 w-full rounded-xl bg-brand-500 py-[12px] text-base font-medium text-white transition duration-200 hover:bg-brand-600 active:bg-brand-700 dark:bg-brand-400 dark:text-white dark:hover:bg-brand-300 dark:active:bg-brand-200"
              type="submit"
              onClick={submitAnnotation}
            >
              Report
            </button>
          </div>
        </Allotment.Pane>
      </Allotment>
    </div>
  );
};

export default Annotate;
