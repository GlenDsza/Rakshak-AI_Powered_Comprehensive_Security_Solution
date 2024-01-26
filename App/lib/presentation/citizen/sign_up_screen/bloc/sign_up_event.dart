// ignore_for_file: must_be_immutable

part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {}

class SignUpInitialEvent extends SignUpEvent {
  @override
  List<Object?> get props => [];
}

class CreateRegisterEvent extends SignUpEvent {
  CreateRegisterEvent({
    required this.onCreateRegisterEventSuccess,
    required this.onCreateRegisterEventError,
  });

  Function onCreateRegisterEventSuccess;

  Function onCreateRegisterEventError;

  @override
  List<Object?> get props => [
        onCreateRegisterEventSuccess,
        onCreateRegisterEventError,
      ];
}

// class GoogleAuthEvent extends SignUpEvent {
//   GoogleAuthEvent();

//   @override
//   List<Object?> get props => [];
// }

// class FacebookAuthEvent extends SignUpEvent {
//   FacebookAuthEvent();

//   @override
//   List<Object?> get props => [];
// }

///event for change password visibility
class ChangePasswordVisibilityEvent extends SignUpEvent {
  ChangePasswordVisibilityEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}
