// ignore_for_file: must_be_immutable

part of 'add_report_bloc.dart';

class AddReportState extends Equatable {
  AddReportState({
    this.incidentTitleController,
    this.incidentDescController,
    this.incidentCategoryValue,
    this.incidentStreetController,
    this.incidentCityController,
    this.incidentPinController,
    this.incidentDistrictValue,
    this.incidentStationValue,
    this.incidentImage,
    this.addReportModelObj,
    this.incidentObj,
  });

  TextEditingController? incidentTitleController;

  TextEditingController? incidentDescController;

  String? incidentCategoryValue;

  TextEditingController? incidentStreetController;

  TextEditingController? incidentCityController;

  TextEditingController? incidentPinController;

  String? incidentDistrictValue;

  String? incidentStationValue;

  String? incidentImage;

  AddReportModel? addReportModelObj;

  Map<String, dynamic>? incidentObj;

  @override
  List<Object?> get props => [
        incidentTitleController,
        incidentDescController,
        incidentCategoryValue,
        incidentStreetController,
        incidentCityController,
        incidentPinController,
        incidentDistrictValue,
        incidentStationValue,
        incidentImage,
        addReportModelObj,
        incidentObj,
      ];

  AddReportState copyWith({
    TextEditingController? incidentTitleController,
    TextEditingController? incidentDescController,
    String? incidentCategoryValue,
    TextEditingController? incidentStreetController,
    TextEditingController? incidentCityController,
    TextEditingController? incidentPinController,
    String? incidentDistrictValue,
    String? incidentStationValue,
    String? incidentImage,
    Map<String, dynamic>? incidentObj,
    AddReportModel? addReportModelObj,
  }) {
    return AddReportState(
      incidentTitleController:
          incidentTitleController ?? this.incidentTitleController,
      incidentDescController:
          incidentDescController ?? this.incidentDescController,
      incidentCategoryValue:
          incidentCategoryValue ?? this.incidentCategoryValue,
      incidentStreetController:
          incidentStreetController ?? this.incidentStreetController,
      incidentCityController:
          incidentCityController ?? this.incidentCityController,
      incidentPinController:
          incidentPinController ?? this.incidentPinController,
      incidentDistrictValue:
          incidentDistrictValue ?? this.incidentDistrictValue,
      incidentStationValue: incidentStationValue ?? this.incidentStationValue,
      incidentImage: incidentImage ?? this.incidentImage,
      incidentObj: incidentObj ?? this.incidentObj,
      addReportModelObj: addReportModelObj ?? this.addReportModelObj,
    );
  }
}
