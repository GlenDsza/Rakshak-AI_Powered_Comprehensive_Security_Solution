import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/data/models/home/get_incident_resp.dart';
import 'package:rakshak/data/repository/repository.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/police/incidents_police_page/models/incidents_police_model.dart';
part 'incidents_police_event.dart';
part 'incidents_police_state.dart';

class IncidentsPoliceBloc
    extends Bloc<IncidentsPoliceEvent, IncidentsPoliceState> {
  IncidentsPoliceBloc(IncidentsPoliceState initialState) : super(initialState) {
    on<IncidentsPoliceInitialEvent>(_onInitialize);
    on<IncidentTypeChangeEvent>(_onIncidentTypeChange);
    on<OnIncidentSearch>(_onIncidentSearch);
  }

  List<Incident> incidentList = [];
  List<Incident> tempIncidentList = [];
  var getIncidentResp = GetIncidentResp();
  final _repository = Repository();

  _onIncidentSearch(
    OnIncidentSearch event,
    Emitter<IncidentsPoliceState> emit,
  ) {
    if (event.searchVal.isEmpty) {
      tempIncidentList = incidentList;
      if (event.incidentType == 'Detected')
        tempIncidentList = tempIncidentList
            .where((incident) => incident.source == "CCTV")
            .toList();
      else
        tempIncidentList = tempIncidentList
            .where((incident) => incident.source != "CCTV")
            .toList();
    } else {
      // if not empty then filter incidents based on searchVal on title as well as station_name and location
      tempIncidentList = tempIncidentList
          .where((element) =>
              element.title!
                  .toLowerCase()
                  .startsWith(event.searchVal.toLowerCase()) ||
              element.station_name!
                  .toLowerCase()
                  .startsWith(event.searchVal.toLowerCase()) ||
              element.location!
                  .toLowerCase()
                  .startsWith(event.searchVal.toLowerCase()))
          .toList();
    }
    print(tempIncidentList.toString());
    emit(state.copyWith(
        incidentsPoliceModelObj: state.incidentsPoliceModelObj.copyWith(
      incidentList: incidentList,
      tempIncidentList: tempIncidentList,
    )));
  }

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

  _onInitialize(
    IncidentsPoliceInitialEvent event,
    Emitter<IncidentsPoliceState> emit,
  ) async {
    if (PrefUtils().getNotificationStatus()) {
      await BackgroundService.startBackground();
    } else {
      BackgroundService.stopBackground();
    }
    incidentList = await fillIncidentList();
    tempIncidentList = incidentList;

    emit(state.copyWith(
        incidentsPoliceModelObj: IncidentsPoliceModel(),
        incidentSearchController: TextEditingController()));
    emit(state.copyWith(
        incidentsPoliceModelObj: state.incidentsPoliceModelObj.copyWith(
      incidentList: incidentList,
      tempIncidentList: tempIncidentList,
    )));
  }

  _onIncidentTypeChange(
    IncidentTypeChangeEvent event,
    Emitter<IncidentsPoliceState> emit,
  ) async {
    tempIncidentList = incidentList;
    if (event.incidentType == 'Detected')
      tempIncidentList = tempIncidentList
          .where((incident) => incident.source == "CCTV")
          .toList();
    else
      tempIncidentList = tempIncidentList
          .where((incident) => incident.source != "CCTV")
          .toList();
    emit(state.copyWith(
        incidentType: event.incidentType,
        incidentsPoliceModelObj: state.incidentsPoliceModelObj.copyWith(
          incidentList: incidentList,
          tempIncidentList: tempIncidentList,
        )));
  }
}
