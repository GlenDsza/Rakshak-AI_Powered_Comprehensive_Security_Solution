import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/police/profile_police_page/models/profile_police_model.dart';
part 'profile_police_event.dart';
part 'profile_police_state.dart';

class ProfilePoliceBloc extends Bloc<ProfilePoliceEvent, ProfilePoliceState> {
  ProfilePoliceBloc(ProfilePoliceState initialState) : super(initialState) {
    on<ProfilePoliceInitialEvent>(_onInitialize);
    on<ChangeNotificationSwitchEvent>(_onChangeNotificationSwitch);
    on<ChangeDarkSwitchEvent>(_onChangeDarkSwitch);
  }

  _onInitialize(
    ProfilePoliceInitialEvent event,
    Emitter<ProfilePoliceState> emit,
  ) async {}

  _onChangeNotificationSwitch(
    ChangeNotificationSwitchEvent event,
    Emitter<ProfilePoliceState> emit,
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
    Emitter<ProfilePoliceState> emit,
  ) async {
    emit(state.copyWith(isSelectedDark: event.value));
  }
}
