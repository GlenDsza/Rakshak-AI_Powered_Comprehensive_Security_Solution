// ignore_for_file: must_be_immutable

part of 'notification_police_bloc.dart';

class NotificationPoliceState extends Equatable {
  NotificationPoliceState({required this.notificationPoliceModelObj});

  NotificationPoliceModel notificationPoliceModelObj;

  @override
  List<Object?> get props => [
        notificationPoliceModelObj,
      ];
  NotificationPoliceState copyWith(
      {NotificationPoliceModel? notificationPoliceModelObj}) {
    return NotificationPoliceState(
      notificationPoliceModelObj:
          notificationPoliceModelObj ?? this.notificationPoliceModelObj,
    );
  }
}
