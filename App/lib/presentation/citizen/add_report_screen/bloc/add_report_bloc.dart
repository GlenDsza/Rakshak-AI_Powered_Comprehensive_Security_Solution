import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/utils/progress_dialog_utils.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/citizen/add_report_screen/models/add_report_model.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
part 'add_report_event.dart';
part 'add_report_state.dart';

class AddReportBloc extends Bloc<AddReportEvent, AddReportState> {
  AddReportBloc(AddReportState initialState) : super(initialState) {
    on<AddReportDetailInitialEvent>(_onDetailInitialize);
    on<AddReportLocationInitialEvent>(_onLocationInitialize);
    on<AddReportEvidenceInitialEvent>(_onEvidenceInitialize);
    on<IncidentCategorySelectEvent>(_onSelectCategory);
    on<IncidentDistrictSelectEvent>(_onSelectDistrict);
    on<IncidentStationSelectEvent>(_onSelectStation);
    on<IncidentImageSelectEvent>(_onSelectImage);
    on<AddReportSubmitEvent>(_onSubmit);
  }

  Map<String, dynamic> incident = {};
  String url = dotenv.get('BASE_URL', fallback: "defaultUrl");

  _onSelectCategory(
    IncidentCategorySelectEvent event,
    Emitter<AddReportState> emit,
  ) {
    emit(state.copyWith(incidentCategoryValue: event.value));
  }

  _onSelectDistrict(
    IncidentDistrictSelectEvent event,
    Emitter<AddReportState> emit,
  ) {
    emit(state.copyWith(
        addReportModelObj: state.addReportModelObj?.copyWith(
            incidentStationList: getIncidentStationList(event.district))));
    emit(state.copyWith(incidentDistrictValue: event.district));
  }

  _onSelectStation(
    IncidentStationSelectEvent event,
    Emitter<AddReportState> emit,
  ) {
    emit(state.copyWith(incidentStationValue: event.station));
  }

  _onSelectImage(
    IncidentImageSelectEvent event,
    Emitter<AddReportState> emit,
  ) {
    emit(state.copyWith(incidentImage: event.imagePath));
  }

  List<ValueItem> fillIncidentCategoryList() {
    return incidentCategoryConst;
  }

  List<ValueItem> fillIncidentDistrictList() {
    return incidentDistrictConst;
  }

  _onDetailInitialize(
    AddReportDetailInitialEvent event,
    Emitter<AddReportState> emit,
  ) async {
    emit(state.copyWith(
        incidentTitleController: TextEditingController(),
        incidentDescController: TextEditingController()));
    emit(state.copyWith(
        addReportModelObj: state.addReportModelObj
            ?.copyWith(incidentCategoryList: fillIncidentCategoryList())));
  }

  _onLocationInitialize(
    AddReportLocationInitialEvent event,
    Emitter<AddReportState> emit,
  ) async {
    emit(state.copyWith(
        incidentStreetController: TextEditingController(),
        incidentCityController: TextEditingController(),
        incidentPinController: TextEditingController()));
    emit(state.copyWith(
        addReportModelObj: state.addReportModelObj
            ?.copyWith(incidentDistrictList: fillIncidentDistrictList())));
  }

  _onEvidenceInitialize(
    AddReportEvidenceInitialEvent event,
    Emitter<AddReportState> emit,
  ) async {}

  _onSubmit(
    AddReportSubmitEvent event,
    Emitter<AddReportState> emit,
  ) async {
    print(event.incidentObj);
    incident = event.incidentObj;

    var uri = Uri.parse('$url/incidents/user_incident');
    var request = http.MultipartRequest('POST', uri)
      ..headers['Content-Type'] = 'multipart/form-data'
      ..fields['title'] = incident['title'].toString().trim()
      ..fields['description'] = incident['description'].toString().trim()
      ..fields['type'] = incident['type'].toString().trim()
      ..fields['station_name'] = "Andheri"
      ..fields['location'] = incident['location'].toString().trim()
      ..fields['source'] = PrefUtils().getMobile();

    File file = File(state.incidentImage!);
    List<String> allowedExtensions = ['jpg', 'jpeg', 'png'];
    String fileExtension = file.path.split('.').last.toLowerCase();
    if (allowedExtensions.contains(fileExtension)) {
      request.files.add(await http.MultipartFile.fromPath('image', file.path,
          contentType: MediaType("image", fileExtension)));

      try {
        ProgressDialogUtils.showProgressDialog();
        await isNetworkConnected();
        var response = await request.send();
        ProgressDialogUtils.hideProgressDialog();
        var responseData = await response.stream.bytesToString();
        print('Response Data: $responseData');

        if (response.statusCode == 200) {
          print('Uploaded successfully.');
          event.onAddReportSuccess.call("Incident Reported Successfully");
        } else {
          event.onAddReportError.call("Incident Report Failed");
        }
      } catch (e) {
        event.onAddReportError.call(e.toString());
        print(e);
      }
    } else {
      print('Invalid file extension: $fileExtension');
    }
  }

  Future isNetworkConnected() async {
    if (!await NetworkInfo().isConnected()) {
      throw NoInternetException('No Internet Found!');
    }
  }
}
