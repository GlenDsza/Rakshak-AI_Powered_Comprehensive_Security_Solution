import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/data/models/register/verify_otp_req.dart';
import 'package:rakshak/data/repository/repository.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/citizen/verify_phone_number_screen/models/verify_phone_number_model.dart';
import 'package:rakshak/data/models/register/verify_otp_resp.dart';
import 'package:sms_autofill/sms_autofill.dart';
part 'verify_phone_number_event.dart';
part 'verify_phone_number_state.dart';

class VerifyPhoneNumberBloc
    extends Bloc<VerifyPhoneNumberEvent, VerifyPhoneNumberState>
    with CodeAutoFill {
  VerifyPhoneNumberBloc(VerifyPhoneNumberState initialState)
      : super(initialState) {
    on<VerifyPhoneNumberInitialEvent>(_onInitialize);
    on<ChangeOTPEvent>(_changeOTP);
    on<VerifyOTPEvent>(_verifyOTP);
  }

  VerifyOtpResp verifyOtpResp = VerifyOtpResp();
  final _repository = Repository();

  @override
  codeUpdated() {
    add(ChangeOTPEvent(code: code!));
  }

  _changeOTP(
    ChangeOTPEvent event,
    Emitter<VerifyPhoneNumberState> emit,
  ) {
    emit(
        state.copyWith(otpController: TextEditingController(text: event.code)));
  }

  _onInitialize(
    VerifyPhoneNumberInitialEvent event,
    Emitter<VerifyPhoneNumberState> emit,
  ) async {
    emit(state.copyWith(otpController: TextEditingController()));
    listenForCode();
  }

  _verifyOTP(
    VerifyOTPEvent event,
    Emitter<VerifyPhoneNumberState> emit,
  ) async {
    emit(state.copyWith(isVerifying: true));

    var verifyOtpReq = VerifyOtpReq(
      mobile: PrefUtils().getMobile(),
      password: event.password,
      otp: event.enteredOTP,
    );

    try {
      verifyOtpResp = await _repository.verifyOtp(
        headers: {
          'Content-type': 'application/json',
        },
        requestData: verifyOtpReq.toJson(),
      );
      print(verifyOtpResp.toJson());
      emit(state.copyWith(isVerifying: false));
      if (verifyOtpResp.data?.mobile != null) {
        PrefUtils().setName(verifyOtpResp.data?.fullname ?? "User");
        emit(VerifyPhoneNumberSuccess());
      }
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(isVerifying: false));
    }
  }
}
