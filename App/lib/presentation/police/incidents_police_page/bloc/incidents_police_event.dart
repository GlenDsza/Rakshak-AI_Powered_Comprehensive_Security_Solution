// ignore_for_file: must_be_immutable

part of 'incidents_police_bloc.dart';

@immutable
abstract class IncidentsPoliceEvent extends Equatable {}

class IncidentsPoliceInitialEvent extends IncidentsPoliceEvent {
  @override
  List<Object?> get props => [];
}

class OnIncidentSearch extends IncidentsPoliceEvent {
  OnIncidentSearch({required this.searchVal, required this.incidentType});

  String incidentType;
  String searchVal;

  @override
  List<Object?> get props => [
        searchVal,
        incidentType,
      ];
}

class IncidentTypeChangeEvent extends IncidentsPoliceEvent {
  IncidentTypeChangeEvent({required this.incidentType});

  String incidentType;

  @override
  List<Object?> get props => [
        incidentType,
      ];
}
