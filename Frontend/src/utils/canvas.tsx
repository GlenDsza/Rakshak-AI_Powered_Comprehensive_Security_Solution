export function getHighDpiCanvasContext(canvas: HTMLCanvasElement) {
  const ctx = canvas.getContext("2d");
  const dpr = window.devicePixelRatio || 1;

  if (
    Math.abs(canvas.width - canvas.clientWidth * dpr) > 1 ||
    Math.abs(canvas.height - canvas.clientHeight * dpr) > 1
  ) {
    console.log(
      "Resizing canvas for adjusting dpi to",
      dpr,
      Math.abs(canvas.width - canvas.clientWidth * dpr),
      Math.abs(canvas.height - canvas.clientHeight * dpr)
    );
    canvas.width = canvas.clientWidth * dpr;
    canvas.height = canvas.clientHeight * dpr;
  }
  return ctx;
}

export function drawLabel(
  ctx: CanvasRenderingContext2D,
  text: string,
  x: number,
  y: number,
  font: string = "16px Arial",
  backgroundColor: string | CanvasGradient | CanvasPattern = "transparent",
  fillStyle: string | CanvasGradient | CanvasPattern = "white",
) {
  ctx.beginPath();
  x = Math.max(x, 0)
  y = Math.max(y, 30)

  // Set background color
  ctx.fillStyle = backgroundColor;
  ctx.fillRect(x, y - parseInt(font, 10), ctx.measureText(text).width, parseInt(font, 10));

  // Set text properties
  ctx.fillStyle = fillStyle;
  ctx.font = font;

   // Draw text
  ctx.fillText(text, x, y);
  ctx.closePath();
}

interface CanvasDrawRectOptions {
  lineWidth?: number;
  strokeStyle?: string | CanvasGradient | CanvasPattern;
  fillStyle?: string | CanvasGradient | CanvasPattern;
  label?: {
    text: string;
    font?: string;
    xOffset?: number;
    yOffset?: number;
    fillStyle?: string | CanvasGradient | CanvasPattern;
    backgroundColor?: string | CanvasGradient | CanvasPattern;
  } | false;
}
export function drawRect(
  ctx: CanvasRenderingContext2D,
  x: number,
  y: number,
  width: number,
  height: number,
  options: CanvasDrawRectOptions
) {
  // console.log("Draw rect", x, y, width, height, options);
  x = Math.max(x, 0)
  y = Math.max(y, 0)

  ctx.beginPath();
  ctx.strokeStyle = options.strokeStyle || "red";
  ctx.lineWidth = options.lineWidth || 2;
  ctx.rect(x, y, width, height);
  ctx.stroke();
  ctx.closePath();

  if (options.label) {
    const labelOptions = options.label;
    drawLabel(
      ctx,
      options.label.text,
      x + (labelOptions.xOffset || 0),
      y + (labelOptions.yOffset || -5),
      labelOptions.font,
      labelOptions.backgroundColor,
      labelOptions.fillStyle,
    );
  }
}

export function drawImageOnCanvas(
  ctx: CanvasRenderingContext2D,
  imgSrc: string
) {
  const canvas = ctx.canvas;

  return new Promise<void>((resolve, reject) => {
    try {
      const img = new Image();
      img.addEventListener("load", () => {
        ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
        // ctx.drawImage(img, 0, 0, img.width, img.height);
        resolve();
      });
      img.src = imgSrc;
    } catch (err) {
      console.log("error drawing image onto canvas", err);
      reject(err);
    }
  });
}
