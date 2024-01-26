import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/data/models/home/get_incident_resp.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/police/map_police_page/models/map_police_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'map_police_event.dart';
part 'map_police_state.dart';

class MapPoliceBloc extends Bloc<MapPoliceEvent, MapPoliceState> {
  MapPoliceBloc(MapPoliceState initialState) : super(initialState) {
    on<MapPoliceInitialEvent>(_onInitialize);
    on<PlotTypeChangeEvent>(_onPlotTypeChange);
  }

  List<Incident> incidentsList = [];
  BitmapDescriptor policeMarkerIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
  BitmapDescriptor objIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  Future<List<Incident>> fillIncidentList() async {
    // List<Incident> userReports = [];

    // try {
    // getIncidentResp = await _repository.getIncident(PrefUtils().getMobile());
    //   userReports = getIncidentResp.dataList!;
    // } catch (error) {
    //   print(error);
    // }

    return userReports;
  }

  Future<BitmapDescriptor> fillPoliceMarker() async {
    return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/images/img_police_marker.png");
  }

  Future<BitmapDescriptor> fillObjMarker(String plotType) async {
    BitmapDescriptor tempIcon;
    if (plotType == 'Surveillance')
      tempIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(), "assets/images/img_cctv_marker.png");
    else
      tempIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    return tempIcon;
  }

  _onInitialize(
    MapPoliceInitialEvent event,
    Emitter<MapPoliceState> emit,
  ) async {
    incidentsList = await fillIncidentList();
    policeMarkerIcon = await fillPoliceMarker();
    objIcon = await fillObjMarker('Surveillance');
    emit(state.copyWith(
        incidentsList: incidentsList,
        policeMarkerIcon: policeMarkerIcon,
        objIcon: objIcon));
  }

  _onPlotTypeChange(
    PlotTypeChangeEvent event,
    Emitter<MapPoliceState> emit,
  ) async {
    objIcon = await fillObjMarker(event.plotType);
    emit(state.copyWith(plotType: event.plotType, objIcon: objIcon));
  }
}
