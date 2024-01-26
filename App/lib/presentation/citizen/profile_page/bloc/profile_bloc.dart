import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/citizen/profile_page/models/profile_model.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(ProfileState initialState) : super(initialState) {
    on<ProfileInitialEvent>(_onInitialize);
    on<ChangeNotificationSwitchEvent>(_onChangeNotificationSwitch);
    on<ChangeDarkSwitchEvent>(_onChangeDarkSwitch);
  }

  _onInitialize(
    ProfileInitialEvent event,
    Emitter<ProfileState> emit,
  ) async {}

  _onChangeNotificationSwitch(
    ChangeNotificationSwitchEvent event,
    Emitter<ProfileState> emit,
  ) async {
    PrefUtils().setNotificationStatus(event.value);
    if (!event.value) {
      BackgroundService.stopBackground();
      print("stopped service");
    } else {
      BackgroundService.startBackground();
      print("started service");
    }

    emit(state.copyWith(isSelectedNotification: event.value));
  }

  _onChangeDarkSwitch(
    ChangeDarkSwitchEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isSelectedDark: event.value));
  }
}
