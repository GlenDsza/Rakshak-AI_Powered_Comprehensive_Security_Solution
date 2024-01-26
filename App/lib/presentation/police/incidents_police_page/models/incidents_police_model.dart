import 'package:equatable/equatable.dart';
import 'package:rakshak/data/models/home/get_incident_resp.dart';
import 'package:rakshak/data/models/selectionPopupModel/selection_popup_model.dart';

// ignore: must_be_immutable
class IncidentsPoliceModel extends Equatable {
  IncidentsPoliceModel(
      {this.incidentList = const [], this.tempIncidentList = const []});

  List<Incident> incidentList;
  List<Incident> tempIncidentList;

  IncidentsPoliceModel copyWith(
      {List<Incident>? incidentList,
      List<Incident>? tempIncidentList,
      List<SelectionPopupModel>? dropdownItemList}) {
    return IncidentsPoliceModel(
      incidentList: incidentList ?? this.incidentList,
      tempIncidentList: tempIncidentList ?? this.tempIncidentList,
    );
  }

  @override
  List<Object?> get props => [incidentList, tempIncidentList];
}
