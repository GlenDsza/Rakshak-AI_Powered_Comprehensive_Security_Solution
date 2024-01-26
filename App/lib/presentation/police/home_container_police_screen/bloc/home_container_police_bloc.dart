import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/police/home_container_police_screen/models/home_container_police_model.dart';
part 'home_container_police_event.dart';
part 'home_container_police_state.dart';

class HomeContainerPoliceBloc
    extends Bloc<HomeContainerPoliceEvent, HomeContainerPoliceState> {
  HomeContainerPoliceBloc(HomeContainerPoliceState initialState)
      : super(initialState) {
    on<HomeContainerPoliceInitialEvent>(_onInitialize);
  }

  _onInitialize(
    HomeContainerPoliceInitialEvent event,
    Emitter<HomeContainerPoliceState> emit,
  ) async {}
}
