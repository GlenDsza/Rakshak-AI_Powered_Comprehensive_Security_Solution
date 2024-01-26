// ignore_for_file: must_be_immutable

part of 'profile_police_bloc.dart';

class ProfilePoliceState extends Equatable {
  ProfilePoliceState({
    this.profilePoliceModelObj,
    required this.isSelectedNotification,
    this.isSelectedDark = false,
    required this.language,
  });

  bool isSelectedNotification;

  bool isSelectedDark;

  String language;

  ProfilePoliceModel? profilePoliceModelObj;

  @override
  List<Object?> get props => [
        profilePoliceModelObj,
        isSelectedNotification,
        isSelectedDark,
      ];

  ProfilePoliceState copyWith(
      {ProfilePoliceModel? profilePoliceModelObj,
      bool? isSelectedNotification,
      bool? isSelectedDark,
      String? language}) {
    return ProfilePoliceState(
      profilePoliceModelObj:
          profilePoliceModelObj ?? this.profilePoliceModelObj,
      isSelectedNotification:
          isSelectedNotification ?? this.isSelectedNotification,
      isSelectedDark: isSelectedDark ?? this.isSelectedDark,
      language: language ?? this.language,
    );
  }
}
