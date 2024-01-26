// ignore_for_file: must_be_immutable

part of 'verify_phone_number_bloc.dart';

@immutable
abstract class VerifyPhoneNumberEvent extends Equatable {}

class VerifyPhoneNumberInitialEvent extends VerifyPhoneNumberEvent {
  @override
  List<Object?> get props => [];
}

///event for OTP auto fill
class ChangeOTPEvent extends VerifyPhoneNumberEvent {
  ChangeOTPEvent({required this.code});

  String code;

  @override
  List<Object?> get props => [code];
}

/// Event for OTP verification
class VerifyOTPEvent extends VerifyPhoneNumberEvent {
  final String enteredOTP;
  final String password;

  VerifyOTPEvent({required this.enteredOTP, required this.password});

  @override
  List<Object?> get props => [enteredOTP];
}

class VerifyPhoneNumberSuccessEvent extends VerifyPhoneNumberEvent {
  @override
  List<Object?> get props => [];
}
