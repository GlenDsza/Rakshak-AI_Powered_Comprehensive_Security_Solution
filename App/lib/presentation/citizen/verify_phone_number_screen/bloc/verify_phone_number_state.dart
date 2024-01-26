// ignore_for_file: must_be_immutable

part of 'verify_phone_number_bloc.dart';

class VerifyPhoneNumberState extends Equatable {
  VerifyPhoneNumberState({
    this.otpController,
    this.isVerifying = false,
    this.verifyPhoneNumberModelObj,
  });

  TextEditingController? otpController;
  bool isVerifying;
  VerifyPhoneNumberModel? verifyPhoneNumberModelObj;

  @override
  List<Object?> get props => [
        otpController,
        isVerifying,
        verifyPhoneNumberModelObj,
      ];
  VerifyPhoneNumberState copyWith({
    TextEditingController? otpController,
    bool? isVerifying,
    VerifyPhoneNumberModel? verifyPhoneNumberModelObj,
  }) {
    return VerifyPhoneNumberState(
      otpController: otpController ?? this.otpController,
      isVerifying: isVerifying ?? this.isVerifying,
      verifyPhoneNumberModelObj:
          verifyPhoneNumberModelObj ?? this.verifyPhoneNumberModelObj,
    );
  }
}

class VerifyPhoneNumberSuccess extends VerifyPhoneNumberState {}
