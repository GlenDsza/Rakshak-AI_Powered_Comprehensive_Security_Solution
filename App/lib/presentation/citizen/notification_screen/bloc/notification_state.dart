// ignore_for_file: must_be_immutable

part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  NotificationState({required this.notificationModelObj});

  NotificationModel notificationModelObj;

  @override
  List<Object?> get props => [
        notificationModelObj,
      ];
  NotificationState copyWith({NotificationModel? notificationModelObj}) {
    return NotificationState(
      notificationModelObj: notificationModelObj ?? this.notificationModelObj,
    );
  }
}
