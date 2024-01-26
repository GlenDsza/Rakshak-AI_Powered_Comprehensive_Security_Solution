import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/police/sign_in_police_screen/models/sign_in_police_model.dart';
import 'package:rakshak/data/models/login/post_police_login_resp.dart';
import 'package:rakshak/data/models/login/post_police_login_req.dart';
import 'dart:async';
import 'package:rakshak/data/repository/repository.dart';
part 'sign_in_police_event.dart';
part 'sign_in_police_state.dart';

class SignInPoliceBloc extends Bloc<SignInPoliceEvent, SignInPoliceState> {
  SignInPoliceBloc(SignInPoliceState initialState) : super(initialState) {
    on<SignInPoliceInitialEvent>(_onInitialize);
    on<ChangePasswordVisibilityEvent>(_changePasswordVisibility);
    on<CreateLoginEvent>(_callCreateLogin);
  }

  final _repository = Repository();

  var postPoliceLoginResp = PostPoliceLoginResp();

  _changePasswordVisibility(
    ChangePasswordVisibilityEvent event,
    Emitter<SignInPoliceState> emit,
  ) {
    emit(state.copyWith(isShowPassword: event.value));
  }

  _onInitialize(
    SignInPoliceInitialEvent event,
    Emitter<SignInPoliceState> emit,
  ) async {
    emit(state.copyWith(
        idController: TextEditingController(),
        passwordController: TextEditingController(),
        isShowPassword: true));
  }

  FutureOr<void> _callCreateLogin(
    CreateLoginEvent event,
    Emitter<SignInPoliceState> emit,
  ) async {
    // apply id regex to be 8 charcters length and alphanumeric
    if (state.idController?.text.trim().length != 8) {
      event.onCreateLoginEventError.call();
      return;
    }

    if (state.passwordController!.text.trim().length < 8) {
      event.onCreateLoginEventError.call();
      return;
    }

    var postPoliceLoginReq = PostPoliceLoginReq(
      id: state.idController?.text.trim(),
      password: state.passwordController?.text.trim(),
    );
    print(postPoliceLoginReq.toJson());
    try {
      postPoliceLoginResp = await _repository.createPoliceLogin(
        headers: {
          'Content-type': 'application/json',
        },
        requestData: postPoliceLoginReq.toJson(),
      );
      print(postPoliceLoginResp.toJson());
      _onCreateLoginSuccess(postPoliceLoginResp, emit);
      event.onCreateLoginEventSuccess.call();
    } catch (error) {
      _onCreateLoginError();
      event.onCreateLoginEventError.call();
    }
  }

  void _onCreateLoginSuccess(
    PostPoliceLoginResp resp,
    Emitter<SignInPoliceState> emit,
  ) {
    PrefUtils().clearPreferencesData();
    PrefUtils().setId(resp.data!.id!.toString());
    PrefUtils().setName(resp.data!.staff_name!.toString());
    PrefUtils().setNotificationStatus(true);
    PrefUtils().setStation(resp.data!.station_name!.toString());
    PrefUtils().setDuty(resp.data!.duty!.toString());
    emit(
      state.copyWith(
        signInPoliceModelObj: state.signInPoliceModelObj?.copyWith(),
      ),
    );
  }

  void _onCreateLoginError() {
    //implement error method body...
  }
}
