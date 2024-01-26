import React from "react";
import videojs from "video.js";
import Player from "video.js/dist/types/player";
import "video.js/dist/video-js.css";

interface VideoPlayerProps {
  url: string;
}

export const VideoPlayer = (props: VideoPlayerProps) => {
  const { url } = props;
  const videoRef = React.useRef<HTMLDivElement>(null);
  const playerRef = React.useRef<Player | null>(null);

  const handlePlayerReady = (player: Player) => {
    playerRef.current = player;

    // You can handle player events here, for example:
    player.on("waiting", () => {
      videojs.log("player is waiting");
    });

    player.on("dispose", () => {
      videojs.log("player will dispose");
    });
  };

  React.useEffect(() => {
    if (!videoRef.current) return;

    const videoJsOptions = {
      autoplay: true,
      controls: true,
      responsive: true,
      loop: true,
      muted: true,
      fluid: true,
      controlBar: false,
      // controlBar: {
      //   hide: true,
      //   pictureInPictureToggle: false,
      //   volumePanel: false,
      // },
      sources: [
        {
          src: url,
        },
      ],
    };

    // Make sure Video.js player is only initialized once
    if (!playerRef.current) {
      // The Video.js player needs to be _inside_ the component el for React 18 Strict Mode.
      const videoElement = document.createElement("video-js");

      videoElement.classList.add("vjs-big-play-centered");
      videoRef.current.appendChild(videoElement);

      const player = (playerRef.current = videojs(
        videoElement,
        videoJsOptions,
        () => {
          videojs.log("player is ready");
          handlePlayerReady(player);
        }
      ));
      // player.muted(true);
    } else {
      // You could update an existing player in the `else` block here
      // on prop change, for example:
      const player = playerRef.current;
      player.autoplay(videoJsOptions.autoplay);
      player.src(videoJsOptions.sources);
    }

    return () => {
      // playerRef.current?.dispose()
    };
  }, [url, videoRef]);

  // Dispose the Video.js player when the functional component unmounts
  React.useEffect(() => {
    const player = playerRef.current;

    return () => {
      if (player && !player.isDisposed()) {
        player.dispose();
        playerRef.current = null;
      }
    };
  }, [playerRef]);

  return (
    <div data-vjs-player>
      <div ref={videoRef} />
      {/* <video ref={videoRef} controls /> */}
    </div>
  );
};

export default VideoPlayer;
