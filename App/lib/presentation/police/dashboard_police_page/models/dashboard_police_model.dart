import 'package:equatable/equatable.dart';
import 'package:rakshak/data/models/home/get_incident_resp.dart';
import 'package:rakshak/data/models/selectionPopupModel/selection_popup_model.dart';

// ignore: must_be_immutable
class DashboardPoliceModel extends Equatable {
  DashboardPoliceModel(
      {this.incidentList = const [],
      this.reportedList = const [],
      this.detectedList = const []});

  List<Incident> incidentList;
  List<Incident> reportedList;
  List<Incident> detectedList;

  DashboardPoliceModel copyWith(
      {List<Incident>? incidentList,
      List<Incident>? reportedList,
      List<Incident>? detectedList,
      List<SelectionPopupModel>? dropdownItemList}) {
    return DashboardPoliceModel(
      incidentList: incidentList ?? this.incidentList,
      reportedList: reportedList ?? this.reportedList,
      detectedList: detectedList ?? this.detectedList,
    );
  }

  @override
  List<Object?> get props => [incidentList, reportedList, detectedList];
}
