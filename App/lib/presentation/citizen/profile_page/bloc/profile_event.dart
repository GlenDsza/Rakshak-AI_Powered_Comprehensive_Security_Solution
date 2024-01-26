// ignore_for_file: must_be_immutable

part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {}

class ProfileInitialEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class ChangeNotificationSwitchEvent extends ProfileEvent {
  ChangeNotificationSwitchEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}

class ChangeDarkSwitchEvent extends ProfileEvent {
  ChangeDarkSwitchEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}
