// ignore_for_file: must_be_immutable

part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  ProfileState(
      {this.profileModelObj,
      required this.isSelectedNotification,
      this.isSelectedDark = false});

  bool isSelectedNotification;

  bool isSelectedDark;

  ProfileModel? profileModelObj;

  @override
  List<Object?> get props => [
        profileModelObj,
        isSelectedNotification,
        isSelectedDark,
      ];

  ProfileState copyWith(
      {ProfileModel? profileModelObj,
      bool? isSelectedNotification,
      bool? isSelectedDark}) {
    return ProfileState(
      profileModelObj: profileModelObj ?? this.profileModelObj,
      isSelectedNotification:
          isSelectedNotification ?? this.isSelectedNotification,
      isSelectedDark: isSelectedDark ?? this.isSelectedDark,
    );
  }
}
