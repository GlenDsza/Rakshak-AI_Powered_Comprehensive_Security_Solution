// ignore_for_file: must_be_immutable

part of 'sign_in_police_bloc.dart';

@immutable
abstract class SignInPoliceEvent extends Equatable {}

class SignInPoliceInitialEvent extends SignInPoliceEvent {
  @override
  List<Object?> get props => [];
}

class CreateLoginEvent extends SignInPoliceEvent {
  CreateLoginEvent({
    required this.onCreateLoginEventSuccess,
    required this.onCreateLoginEventError,
  });

  Function onCreateLoginEventSuccess;

  Function onCreateLoginEventError;

  @override
  List<Object?> get props => [
        onCreateLoginEventSuccess,
        onCreateLoginEventError,
      ];
}

class ChangePasswordVisibilityEvent extends SignInPoliceEvent {
  ChangePasswordVisibilityEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}
