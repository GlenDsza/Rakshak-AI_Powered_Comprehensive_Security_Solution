// ignore_for_file: must_be_immutable

part of 'add_report_bloc.dart';

@immutable
abstract class AddReportEvent extends Equatable {}

class AddReportDetailInitialEvent extends AddReportEvent {
  @override
  List<Object?> get props => [];
}

class AddReportLocationInitialEvent extends AddReportEvent {
  @override
  List<Object?> get props => [];
}

class AddReportEvidenceInitialEvent extends AddReportEvent {
  @override
  List<Object?> get props => [];
}

class AddReportSubmitEvent extends AddReportEvent {
  AddReportSubmitEvent(
      {required this.incidentObj,
      required this.imagePath,
      required this.onAddReportSuccess,
      required this.onAddReportError});

  Map<String, dynamic> incidentObj;
  String? imagePath;
  Function onAddReportSuccess;
  Function onAddReportError;

  @override
  List<Object?> get props =>
      [incidentObj, imagePath, onAddReportSuccess, onAddReportError];
}

class IncidentImageSelectEvent extends AddReportEvent {
  IncidentImageSelectEvent({required this.imagePath});

  String? imagePath;

  @override
  List<Object?> get props => [
        imagePath,
      ];
}

///event for dropdown selection
class IncidentCategorySelectEvent extends AddReportEvent {
  IncidentCategorySelectEvent({required this.value});

  String value;

  @override
  List<Object?> get props => [
        value,
      ];
}

class IncidentDistrictSelectEvent extends AddReportEvent {
  IncidentDistrictSelectEvent({required this.district});

  String district;

  @override
  List<Object?> get props => [
        district,
      ];
}

class IncidentStationSelectEvent extends AddReportEvent {
  IncidentStationSelectEvent({required this.station});

  String station;

  @override
  List<Object?> get props => [
        station,
      ];
}
