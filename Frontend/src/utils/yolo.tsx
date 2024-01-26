import { ObjectDetection } from "@/components/CctvStream/detections.types";

export function filterDetections<T extends ObjectDetection>(
  detections: T[],
  minConfidence = 0.5,
  excludeLabels: string[] = [],
) {
  if (!detections) return [];
  return detections.filter((detection) => {
    return detection.confidence >= minConfidence && !excludeLabels.includes(detection.label);
  });
}
export const bboxCoordsToCanvasCoords = (
  canvas: HTMLCanvasElement,
  bbox: number[]
) => {
  const canvasWidth = canvas.width;
  const canvasHeight = canvas.height;
  // const dX = canvas.clientWidth / weaponDetection.orig_shape[0];
  // const dY = canvas.clientHeight / weaponDetection.orig_shape[1];

  const [normalisedMidX, normalisedMidY, normalisedWidth, normalisedHeight] =
    bbox;
  const midX = normalisedMidX * canvasWidth;
  const midY = normalisedMidY * canvasHeight;

  const width = normalisedWidth * canvasWidth;
  const height = normalisedHeight * canvasHeight;
  const x = midX - width / 2;
  const y = midY - height / 2;

  return { x, y, width, height };
};
