import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
part 'change_language_event.dart';
part 'change_language_state.dart';

class ChangeLanguageBloc
    extends Bloc<ChangeLanguageEvent, ChangeLanguageState> {
  ChangeLanguageBloc(ChangeLanguageState initialState) : super(initialState) {
    on<ChangeLanguageInitialEvent>(_onInitialize);
    on<ChangeRadioButtonEvent>(_onChangeRadioButton);
    on<LanguageSubmitEvent>(_onLanguageSubmit);
  }

  _onInitialize(
    ChangeLanguageInitialEvent event,
    Emitter<ChangeLanguageState> emit,
  ) async {
    String str = event.value == "en" ? "lbl_english".tr : "lbl_hindi".tr;
    emit(state.copyWith(radioGroup: str));
  }

  _onChangeRadioButton(
    ChangeRadioButtonEvent event,
    Emitter<ChangeLanguageState> emit,
  ) async {
    emit(state.copyWith(
        radioGroup: event.value == "lbl_english".tr
            ? "lbl_english".tr
            : "lbl_hindi".tr));
  }

  _onLanguageSubmit(
    LanguageSubmitEvent event,
    Emitter<ChangeLanguageState> emit,
  ) async {
    if (event.value == "lbl_english".tr) {
      await PrefUtils().setLanguage("en");
      AppLocalization.of().locale = Locale("en", "");
    } else {
      await PrefUtils().setLanguage("hi");
      AppLocalization.of().locale = Locale("hi", "");
    }
    emit(state.copyWith(
        radioGroup: event.value == "lbl_english".tr
            ? "lbl_english".tr
            : "lbl_hindi".tr));
    Future.delayed(Duration(milliseconds: 1000), () {
      if (PrefUtils().getStation() == "")
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeContainerScreen,
            arguments: {
              NavigationArgs.mobile: PrefUtils().getMobile(),
              NavigationArgs.fullname: PrefUtils().getName(),
            });
      else
        NavigatorService.pushNamedAndRemoveUntil(
            AppRoutes.homeContainerPoliceScreen,
            arguments: {
              NavigationArgs.id: PrefUtils().getId(),
              NavigationArgs.fullname: PrefUtils().getName(),
              NavigationArgs.station: PrefUtils().getStation()
            });
    });
  }
}
