// ignore_for_file: must_be_immutable

part of 'cctv_details_bloc.dart';

class CctvDetailsState extends Equatable {
  CctvDetailsState({this.cctv, this.videoPlayerController});

  Cctv? cctv;
  CustomVideoPlayerController? videoPlayerController;

  @override
  List<Object?> get props => [cctv, videoPlayerController];
  CctvDetailsState copyWith(
      {Cctv? cctv, CustomVideoPlayerController? videoPlayerController}) {
    return CctvDetailsState(
        cctv: cctv ?? this.cctv,
        videoPlayerController:
            videoPlayerController ?? this.videoPlayerController);
  }
}
