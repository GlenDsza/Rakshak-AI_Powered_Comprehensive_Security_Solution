import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/splash_screen/models/splash_model.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(SplashState initialState) : super(initialState) {
    on<SplashInitialEvent>(_onInitialize);
  }

  _onInitialize(
    SplashInitialEvent event,
    Emitter<SplashState> emit,
  ) async {
    AppLocalization.of().locale =
        PrefUtils().getLanguage() == 'hi' ? Locale("hi", "") : Locale("en", "");
    Future.delayed(const Duration(milliseconds: 3000), () {
      // PrefUtils().clearPreferencesData();
      // print(PrefUtils().getId() +
      //     " " +
      //     PrefUtils().getMobile() +
      //     " " +
      //     PrefUtils().getName() +
      //     " " +
      //     PrefUtils().getStation());
      if (PrefUtils().getId().isEmpty && PrefUtils().getMobile().isEmpty) {
        NavigatorService.popAndPushNamed(
          AppRoutes.setRoleScreen,
        );
      }

      if (PrefUtils().getId().isNotEmpty) {
        NavigatorService.pushNamedAndRemoveUntil(
            AppRoutes.homeContainerPoliceScreen,
            arguments: {
              NavigationArgs.id: PrefUtils().getId(),
              NavigationArgs.fullname: PrefUtils().getName(),
              NavigationArgs.station: PrefUtils().getStation(),
            });
      }

      if (PrefUtils().getMobile().isNotEmpty) {
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeContainerScreen,
            arguments: {
              NavigationArgs.mobile: PrefUtils().getMobile(),
              NavigationArgs.fullname: PrefUtils().getName(),
            });
      }
    });
  }
}
