import React, { useRef, useEffect, useState } from "react";
// import * as t from '@tensorflow/tfjs';
// import * as tmPose from '@teachablemachine/pose';
// import * as tmImage from '@teachablemachine/image';
// import { Pose } from '@tensorflow-models/posenet';
import Card from "@/components/card";

const URL1 = "https://teachablemachine.withgoogle.com/models/55Op82mZc/";
const URL2 = "https://teachablemachine.withgoogle.com/models/jLeJTw1rQ/";
const URL4 = "https://teachablemachine.withgoogle.com/models/z8iuFaOyx/";

const FinalCombine = () => {
  let model1, model2, model4, webcam;
  let maxPredictions1, maxPredictions2, maxPredictions4;
  const webcamRef = useRef(null);
  const canvasRef = useRef(null);
  const [predictions1, setPredictions1] = useState([]);
  const [predictions2, setPredictions2] = useState([]);
  const [predictions4, setPredictions4] = useState([]);

  const init = async () => {
    const size = 200;
    const flip = true;

    webcam = new tmPose.Webcam(size, size, flip);
    await webcam.setup();
    webcamRef.current.appendChild(webcam.canvas); // Append the webcam's video element to the DOM.
    await webcam.play();

    const modelURL1 = URL1 + "model.json";
    const metadataURL1 = URL1 + "metadata.json";
    const modelURL2 = URL2 + "model.json";
    const metadataURL2 = URL2 + "metadata.json";
    const modelURL4 = URL4 + "model.json";
    const metadataURL4 = URL4 + "metadata.json";
    model1 = await tmPose.load(modelURL1, metadataURL1);
    model2 = await tmPose.load(modelURL2, metadataURL2);
    model4 = await tmImage.load(modelURL4, metadataURL4);
    maxPredictions1 = model1.getTotalClasses();
    maxPredictions2 = model2.getTotalClasses();
    maxPredictions4 = model4.getTotalClasses();

    window.requestAnimationFrame(loop);
  };

  const loop = async () => {
    webcam.update();
    if (webcam.canvas) {
      await predict();
    }
    window.requestAnimationFrame(loop);
  };
  let lastSpokenClass = null;
  let lastSpokenTime = 0;
  const drawPose = (pose) => {
    if (webcam.canvas) {
      const ctx = canvasRef.current.getContext("2d");
      ctx.drawImage(webcam.canvas, 0, 0);
      if (pose) {
        const minPartConfidence = 0.5;
        tmPose.drawKeypoints(pose.keypoints, minPartConfidence, ctx);
        tmPose.drawSkeleton(pose.keypoints, minPartConfidence, ctx);
      }
    }
  };

  const predict = async () => {
    if (!model1 || !model2 || !model4) {
      console.error("Model is not loaded");
      return;
    }
    const { pose, posenetOutput } = await model1.estimatePose(webcam.canvas);
    let oldprediction1, oldprediction2, oldprediction4;
    model1.predict(posenetOutput).then((predictions) => {
      oldprediction1 = predictions;
      for (let i = 0; i < oldprediction1.length; i++) {
        oldprediction1[i].probability = Math.floor(
          oldprediction1[i].probability * 100
        );
      }
      setPredictions1(oldprediction1);
    });
    model2.predict(posenetOutput).then((predictions) => {
      oldprediction2 = predictions;
      for (let i = 0; i < oldprediction2.length; i++) {
        oldprediction2[i].probability = Math.floor(
          oldprediction2[i].probability * 100
        );
      }
      setPredictions2(oldprediction2);
    });
    await model4.predict(webcam.canvas).then((predictions) => {
      oldprediction4 = predictions;
      for (let i = 0; i < oldprediction4.length; i++) {
        oldprediction4[i].probability = Math.floor(
          oldprediction4[i].probability * 100
        );
      }
      setPredictions4(oldprediction4);
    });

    const classesToSpeak = [
      "climbing",
      "knife cutting",
      "hammering",
      "Spacious Gun ",
      "Gun2",
      "fighting",
      "beating",
      "knife",
    ];
    const predictions = [
      ...oldprediction1,
      ...oldprediction2,
      ...oldprediction4,
    ];

    // for (let i = 0; i < predictions.length; i++) {
    //   if (
    //     predictions[i].probability > 90 &&
    //     classesToSpeak.includes(predictions[i].className)
    //   ) {
    //     const now = Date.now();
    //     if (
    //       predictions[i].className !== lastSpokenClass ||
    //       now - lastSpokenTime > 5000
    //     ) {
    //       // 5000 ms = 5 seconds
    //       const utterance = new SpeechSynthesisUtterance();
    //       utterance.text = predictions[i].className;
    //       speechSynthesis.speak(utterance);
    //       lastSpokenClass = predictions[i].className;
    //       lastSpokenTime = now;
    //     }
    //   }
    // }
    drawPose(pose);
  };

  useEffect(() => {
    init();
  }, []);

  return (
    <Card title="Live Footage">
      <div className="flex flex-col items-center justify-center mt-10">
        <div className="text-xl mb-4">Image and Pose Model</div>
        <div className="grid grid-cols-2">
          <div id="webcam-container" ref={webcamRef} className="mb-4"></div>
          <canvas
            id="canvas"
            ref={canvasRef}
            className="mb-4 w-[300px] h-[200px]"
          ></canvas>
          <div></div>
        </div>
        <div className="grid grid-cols-2">
          <div className="p-10">
            <div className="text-xl mb-4">Model 1 Predictions</div>
            <div id="label-container">
              {predictions1.map((prediction) => (
                <p>
                  {prediction.className}: {prediction.probability}
                </p>
              ))}
            </div>
            <div className="text-xl mb-4">Model 3 Predictions</div>
            <div id="label-container">
              {predictions4.map((prediction) => (
                <p>
                  {prediction.className}: {prediction.probability}
                </p>
              ))}
            </div>
          </div>
          <div className="p-10">
            <div className="text-xl mb-4">Model 2 Predictions</div>
            <div id="label-container">
              {predictions2.map((prediction) => (
                <p>
                  {prediction.className}: {prediction.probability}
                </p>
              ))}
            </div>
          </div>
        </div>
      </div>
    </Card>
  );
};

export default FinalCombine;
