// ignore_for_file: must_be_immutable

part of 'incidents_police_bloc.dart';

class IncidentsPoliceState extends Equatable {
  IncidentsPoliceState({
    this.incidentSearchController,
    this.incidentType = 'Reported',
    required this.incidentsPoliceModelObj,
  });

  String incidentType;

  TextEditingController? incidentSearchController;

  IncidentsPoliceModel incidentsPoliceModelObj;

  @override
  List<Object?> get props => [
        incidentSearchController,
        incidentsPoliceModelObj,
        incidentType,
      ];
  IncidentsPoliceState copyWith({
    TextEditingController? incidentSearchController,
    String? incidentType,
    required IncidentsPoliceModel incidentsPoliceModelObj,
  }) {
    return IncidentsPoliceState(
      incidentType: incidentType ?? this.incidentType,
      incidentSearchController:
          incidentSearchController ?? this.incidentSearchController,
      incidentsPoliceModelObj: incidentsPoliceModelObj,
    );
  }
}
