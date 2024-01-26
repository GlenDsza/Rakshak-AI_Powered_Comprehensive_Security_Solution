import 'package:equatable/equatable.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

// ignore: must_be_immutable
class AddReportModel extends Equatable {
  AddReportModel(
      {this.incidentCategoryList = const [],
      this.incidentDistrictList = const [],
      this.incidentStationList = const []});

  List<ValueItem> incidentCategoryList;
  List<ValueItem> incidentDistrictList;
  List<ValueItem> incidentStationList;

  AddReportModel copyWith(
      {List<ValueItem>? incidentCategoryList,
      List<ValueItem>? incidentDistrictList,
      List<ValueItem>? incidentStationList}) {
    return AddReportModel(
      incidentCategoryList: incidentCategoryList ?? this.incidentCategoryList,
      incidentDistrictList: incidentDistrictList ?? this.incidentDistrictList,
      incidentStationList: incidentStationList ?? this.incidentStationList,
    );
  }

  @override
  List<Object?> get props =>
      [incidentCategoryList, incidentDistrictList, incidentStationList];
}
