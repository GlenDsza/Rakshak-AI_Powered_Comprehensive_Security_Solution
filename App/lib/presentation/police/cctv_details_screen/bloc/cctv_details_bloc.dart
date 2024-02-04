import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import '/core/app_export.dart';
part 'cctv_details_event.dart';
part 'cctv_details_state.dart';

class CctvDetailsBloc extends Bloc<CctvDetailsEvent, CctvDetailsState> {
  CctvDetailsBloc(CctvDetailsState initialState) : super(initialState) {
    on<CctvDetailsInitialEvent>(_onInitialize);
  }

  CustomVideoPlayerController? customVideoPlayerController;

  Cctv cctv = Cctv(
      id: "CCTV_999",
      lat: "26.923884",
      long: "75.801752",
      streamUrl:
          "https://res.cloudinary.com/dp0ayty6p/video/upload/v1705171052/samples/fire_sample.mp4",
      title: "CCTV 5",
      address:
          "Vidyanagar, Vidya Vihar East, Vidyavihar, Mumbai, Maharashtra 400077");
  void initializeVideoPlayer(Cctv cctv, BuildContext context) async {
    VideoPlayerController videoPlayerController;
    videoPlayerController =
        VideoPlayerController.asset("assets/public_accident_fire.mp4");
    await videoPlayerController.initialize();

    customVideoPlayerController = CustomVideoPlayerController(
        context: context, videoPlayerController: videoPlayerController);
  }

  _onInitialize(
    CctvDetailsInitialEvent event,
    Emitter<CctvDetailsState> emit,
  ) async {
    cctv = event.cctv;
    initializeVideoPlayer(cctv, event.context);
    emit(state.copyWith(
      videoPlayerController: customVideoPlayerController,
    ));
  }
}
