import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/data/models/home/get_incident_resp.dart';
import 'package:rakshak/data/repository/repository.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/police/dashboard_police_page/models/dashboard_police_model.dart';
part 'dashboard_police_event.dart';
part 'dashboard_police_state.dart';

class DashboardPoliceBloc
    extends Bloc<DashboardPoliceEvent, DashboardPoliceState> {
  DashboardPoliceBloc(DashboardPoliceState initialState) : super(initialState) {
    on<DashboardPoliceInitialEvent>(_onInitialize);
    on<DashboardPoliceTooltipEvent>(_onToolTipEvent);
  }

  Map<String, List<Incident>> incidentsByDate = {};
  List<Incident> incidentList = [];
  List<Incident> reportedList = [];
  List<Incident> detectedList = [];
  List<BarData> dataList = [
    BarData(ColorConstant.blue500, 18, 18),
    BarData(ColorConstant.blue500, 17, 8),
    BarData(ColorConstant.blue500, 10, 15),
    BarData(ColorConstant.blue500, 2.5, 5),
    BarData(ColorConstant.blue500, 2, 2.5),
    BarData(ColorConstant.blue500, 2, 2),
    BarData(ColorConstant.blue500, 10, 15),
  ];

  List<String> weekDays = [
    'M',
    'T',
    'W',
    'T',
    'F',
    'S',
    'S',
  ];
  Incident? recentIncident;

  var getIncidentResp = GetIncidentResp();
  final _repository = Repository();

  Future<void> fillIncidentList() async {
    // List<Incident> userReports = [];

    // try {
    // getIncidentResp = await _repository.getIncident(PrefUtils().getMobile());
    //   userReports = getIncidentResp.dataList!;
    // } catch (error) {
    //   print(error);
    // }

    userReports.sort(compareIncidentByCreatedAt);
    incidentList = userReports;
    recentIncident = incidentList.length > 0 ? incidentList.first : null;
    reportedList =
        userReports.where((element) => element.source != "CCTV").toList();
    detectedList =
        userReports.where((element) => element.source == "CCTV").toList();
    incidentsByDate = separateIncidentPerDates(userReports);
  }

  _onInitialize(
    DashboardPoliceInitialEvent event,
    Emitter<DashboardPoliceState> emit,
  ) async {
    if (PrefUtils().getNotificationStatus()) {
      await BackgroundService.startBackground();
    } else {
      BackgroundService.stopBackground();
    }
    await fillIncidentList();

    int count = 0;
    // try {
    //   count = await _repository.getNotificationCount(PrefUtils().getMobile());
    // } catch (error) {
    //   count = 0;
    //   print(error);
    // }

    await Future.delayed(Duration(milliseconds: 200), () {
      dataList = [];
      weekDays = [];
      int reports = 0;
      int detects = 0;
      incidentsByDate.forEach((date, incidents) {
        reports = incidents.where((element) => element.source != "CCTV").length;
        detects = incidents.length - reports;
        print("$date - $reports - $detects");
        dataList.add(BarData(
            ColorConstant.blue500, reports.toDouble(), detects.toDouble()));
        weekDays.add(date);
      });
    });
    print(dataList);
    emit(state.copyWith(
      dashboardPoliceModelObj: DashboardPoliceModel(),
      barChartConstants: BarChartConstants(-1, dataList, weekDays),
      recentIncident: recentIncident,
      isNotificationPresent: count != 0 ? true : false,
    ));
    emit(state.copyWith(
        dashboardPoliceModelObj: state.dashboardPoliceModelObj.copyWith(
      incidentList: incidentList,
      reportedList: reportedList,
      detectedList: detectedList,
    )));
  }

  _onToolTipEvent(
    DashboardPoliceTooltipEvent event,
    Emitter<DashboardPoliceState> emit,
  ) async {
    emit(state.copyWith(
      dashboardPoliceModelObj: DashboardPoliceModel(),
      barChartConstants: BarChartConstants(event.value, dataList, weekDays),
      recentIncident: recentIncident,
    ));
    emit(state.copyWith(
        dashboardPoliceModelObj: state.dashboardPoliceModelObj.copyWith(
      incidentList: incidentList,
      reportedList: reportedList,
      detectedList: detectedList,
    )));
  }
}
