import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/citizen/sign_up_screen/models/sign_up_model.dart';
import 'package:rakshak/data/models/register/post_register_resp.dart';
import 'package:rakshak/data/models/register/post_register_req.dart';
import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:rakshak/data/repository/repository.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(SignUpState initialState) : super(initialState) {
    on<SignUpInitialEvent>(_onInitialize);
    on<ChangePasswordVisibilityEvent>(_changePasswordVisibility);
    on<CreateRegisterEvent>(_callCreateRegister);
  }

  final _repository = Repository();

  var postRegisterResp = PostRegisterResp();

  _changePasswordVisibility(
    ChangePasswordVisibilityEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(isShowPassword: event.value));
  }

  _onInitialize(
    SignUpInitialEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(
        fullnameController: TextEditingController(),
        phonenumberController: TextEditingController(),
        passwordController: TextEditingController(),
        isShowPassword: true));
  }

  FutureOr<void> _callCreateRegister(
    CreateRegisterEvent event,
    Emitter<SignUpState> emit,
  ) async {
    var postRegisterReq = PostRegisterReq(
      mobile: state.phonenumberController?.text.trim(),
      password: state.passwordController?.text.trim(),
      fullname: state.fullnameController?.text.trim(),
    );

    // PostRegisterResp resp = PostRegisterResp();
    // resp = PostRegisterResp.fromJson({
    //   "fullname": "Glen Dsouza",
    //   "mobile": "9324326404",
    //   "active": false,
    //   "is_verified": false
    // });

    try {
      PostRegisterResp resp = await _repository.createRegister(
        headers: {
          'Content-type': 'application/json',
        },
        requestData: postRegisterReq.toJson(),
      );
      print(resp.toJson());
      _onCreateRegisterSuccess(resp, emit);
    } catch (e) {
      _onCreateRegisterError();
    }
  }

  void _onCreateRegisterSuccess(
    PostRegisterResp resp,
    Emitter<SignUpState> emit,
  ) {
    PrefUtils().setMobile(resp.data!.mobile!.toString());
    emit(
      state.copyWith(
        signUpModelObj: state.signUpModelObj?.copyWith(),
      ),
    );
    NavigatorService.pushNamed(
      AppRoutes.verifyPhoneNumberScreen,
    );
  }

  void _onCreateRegisterError() {
    //implement error method body...
  }
}
