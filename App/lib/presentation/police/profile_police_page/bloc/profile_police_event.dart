// ignore_for_file: must_be_immutable

part of 'profile_police_bloc.dart';

@immutable
abstract class ProfilePoliceEvent extends Equatable {}

class ProfilePoliceInitialEvent extends ProfilePoliceEvent {
  @override
  List<Object?> get props => [];
}

class ChangeNotificationSwitchEvent extends ProfilePoliceEvent {
  ChangeNotificationSwitchEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}

class ChangeDarkSwitchEvent extends ProfilePoliceEvent {
  ChangeDarkSwitchEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}
