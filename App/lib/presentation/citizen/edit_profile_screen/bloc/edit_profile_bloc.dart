import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/citizen/edit_profile_screen/models/edit_profile_model.dart';
import 'package:rakshak/data/models/me/get_me_resp.dart';
import 'dart:async';
import 'package:rakshak/data/repository/repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(EditProfileState initialState) : super(initialState) {
    on<EditProfileInitialEvent>(_onInitialize);
    on<FetchMeEvent>(_callFetchMe);
  }

  final _repository = Repository();

  var getMeResp = GetMeResp();

  _onInitialize(
    EditProfileInitialEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(
        fullnameOneController: TextEditingController(),
        emailOneController: TextEditingController(),
        addressOneController: TextEditingController(),
        passwordOneController: TextEditingController()));
    add(
      FetchMeEvent(
        onFetchMeEventError: () {
          _onFetchMeEventError();
        },
      ),
    );
  }

  FutureOr<void> _callFetchMe(
    FetchMeEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    await _repository.fetchMe(
      headers: {
        'Content-type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxNmZiNzBhZWJiM2RiYjVlYmVkYTBmMiIsInVzZXJuYW1lIjoiT3Jpb24xNyIsImlhdCI6MTY3ODY5NjYwOH0.ooqOoYB-4yP-kNz7weVH0TSQrZ1_edFf7AMqwWLIZNU',
      },
    ).then((value) async {
      getMeResp = value;
      _onFetchMeSuccess(value, emit);
    }).onError((error, stackTrace) {
      //implement error call
      _onFetchMeError();
      event.onFetchMeEventError.call();
    });
  }

  void _onFetchMeSuccess(
    GetMeResp resp,
    Emitter<EditProfileState> emit,
  ) {
    emit(
      state.copyWith(
        editProfileModelObj: state.editProfileModelObj?.copyWith(),
        emailOneController:
            TextEditingController(text: resp.data!.email!.toString()),
        fullnameOneController:
            TextEditingController(text: resp.data!.name!.toString()),
      ),
    );
  }

  void _onFetchMeError() {
    //implement error method body...
  }
  void _onFetchMeEventError() {
    Fluttertoast.showToast(msg: "Error");
  }
}
