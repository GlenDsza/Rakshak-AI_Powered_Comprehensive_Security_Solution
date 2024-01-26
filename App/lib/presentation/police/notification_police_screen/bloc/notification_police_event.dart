// ignore_for_file: must_be_immutable

part of 'notification_police_bloc.dart';

@immutable
abstract class NotificationPoliceEvent extends Equatable {}

class NotificationPoliceInitialEvent extends NotificationPoliceEvent {
  @override
  List<Object?> get props => [];
}
