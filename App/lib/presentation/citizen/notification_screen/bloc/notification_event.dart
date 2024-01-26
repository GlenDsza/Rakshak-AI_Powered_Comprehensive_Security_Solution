// ignore_for_file: must_be_immutable

part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent extends Equatable {}

class NotificationInitialEvent extends NotificationEvent {
  @override
  List<Object?> get props => [];
}
