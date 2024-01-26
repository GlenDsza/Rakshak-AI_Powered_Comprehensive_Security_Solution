import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/citizen/sign_in_screen/models/sign_in_model.dart';
import 'package:rakshak/data/models/login/post_login_resp.dart';
import 'package:rakshak/data/models/login/post_login_req.dart';
import 'dart:async';
import 'package:rakshak/data/repository/repository.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(SignInState initialState) : super(initialState) {
    on<SignInInitialEvent>(_onInitialize);
    on<ChangePasswordVisibilityEvent>(_changePasswordVisibility);
    on<CreateLoginEvent>(_callCreateLogin);
  }

  final _repository = Repository();

  var postLoginResp = PostLoginResp();

  _changePasswordVisibility(
    ChangePasswordVisibilityEvent event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(isShowPassword: event.value));
  }

  _onInitialize(
    SignInInitialEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(
        phonenumberController: TextEditingController(),
        passwordController: TextEditingController(),
        isShowPassword: true));
  }

  FutureOr<void> _callCreateLogin(
    CreateLoginEvent event,
    Emitter<SignInState> emit,
  ) async {
    // apply mobile no regex to check mobile no is valid or not
    if (state.phonenumberController?.text.trim().length != 10) {
      event.onCreateLoginEventError.call();
      return;
    }

    if (state.passwordController!.text.trim().length < 8) {
      event.onCreateLoginEventError.call();
      return;
    }

    var postLoginReq = PostLoginReq(
      mobile: state.phonenumberController?.text.trim(),
      password: state.passwordController?.text.trim(),
    );
    print(postLoginReq.toJson());
    try {
      postLoginResp = await _repository.createLogin(
        headers: {
          'Content-type': 'application/json',
        },
        requestData: postLoginReq.toJson(),
      );
      print(postLoginResp.toJson());
      _onCreateLoginSuccess(postLoginResp, emit);
      event.onCreateLoginEventSuccess.call();
    } catch (error) {
      _onCreateLoginError();
      event.onCreateLoginEventError.call();
    }
  }

  void _onCreateLoginSuccess(
    PostLoginResp resp,
    Emitter<SignInState> emit,
  ) {
    PrefUtils().clearPreferencesData();
    PrefUtils().setMobile(resp.data!.mobile!.toString());
    PrefUtils().setName(resp.data!.fullname!.toString());
    PrefUtils().setNotificationStatus(true);
    emit(
      state.copyWith(
        signInModelObj: state.signInModelObj?.copyWith(),
      ),
    );
  }

  void _onCreateLoginError() {
    //implement error method body...
  }
}
