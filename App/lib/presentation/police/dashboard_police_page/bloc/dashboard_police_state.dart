// ignore_for_file: must_be_immutable

part of 'dashboard_police_bloc.dart';

class DashboardPoliceState extends Equatable {
  DashboardPoliceState({
    this.isNotificationPresent = false,
    required this.barChartConstants,
    required this.dashboardPoliceModelObj,
    this.recentIncident,
  });

  bool isNotificationPresent;
  BarChartConstants barChartConstants;
  Incident? recentIncident;
  DashboardPoliceModel dashboardPoliceModelObj;

  @override
  List<Object?> get props => [
        dashboardPoliceModelObj,
        isNotificationPresent,
        barChartConstants,
        recentIncident,
      ];
  DashboardPoliceState copyWith({
    required DashboardPoliceModel dashboardPoliceModelObj,
    BarChartConstants? barChartConstants,
    bool? isNotificationPresent,
    Incident? recentIncident,
  }) {
    return DashboardPoliceState(
      dashboardPoliceModelObj: dashboardPoliceModelObj,
      isNotificationPresent:
          isNotificationPresent ?? this.isNotificationPresent,
      barChartConstants: barChartConstants ?? this.barChartConstants,
      recentIncident: recentIncident ?? this.recentIncident,
    );
  }
}
