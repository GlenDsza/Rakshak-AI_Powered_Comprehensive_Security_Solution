// ignore_for_file: must_be_immutable

part of 'home_bloc.dart';

class HomeState extends Equatable {
  HomeState({
    this.incidentSearchController,
    this.isNotificationPresent = false,
    required this.homeModelObj,
  });

  TextEditingController? incidentSearchController;

  bool isNotificationPresent;

  HomeModel homeModelObj;

  @override
  List<Object?> get props => [
        incidentSearchController,
        homeModelObj,
        isNotificationPresent,
      ];
  HomeState copyWith({
    TextEditingController? incidentSearchController,
    required HomeModel homeModelObj,
    bool? isNotificationPresent,
  }) {
    return HomeState(
      incidentSearchController:
          incidentSearchController ?? this.incidentSearchController,
      homeModelObj: homeModelObj,
      isNotificationPresent:
          isNotificationPresent ?? this.isNotificationPresent,
    );
  }
}
