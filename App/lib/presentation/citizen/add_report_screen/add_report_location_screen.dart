import 'bloc/add_report_bloc.dart';
import 'models/add_report_model.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/widgets/app_bar/appbar_iconbutton_1.dart';
import 'package:rakshak/widgets/app_bar/appbar_subtitle.dart';
import 'package:rakshak/widgets/app_bar/custom_app_bar.dart';
import 'package:rakshak/widgets/custom_button.dart';
import 'package:rakshak/widgets/custom_text_form_field.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class AddReportLocationScreen extends StatelessWidget {
  static Widget builder(BuildContext context) {
    var arg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return BlocProvider<AddReportBloc>(
        create: (context) => AddReportBloc(AddReportState(
            addReportModelObj: AddReportModel(),
            incidentObj: arg["incidentObj"]))
          ..add(AddReportLocationInitialEvent()),
        child: AddReportLocationScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray50,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
                height: getVerticalSize(48),
                leadingWidth: 64,
                leading: AppbarIconbutton1(
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 24, top: 16),
                    onTap: () {
                      onTapArrowleft5(context);
                    }),
                centerTitle: true,
                title: AppbarSubtitle(
                  text: "msg_add_new_report".tr,
                  margin: EdgeInsets.only(top: 16),
                )),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 24, top: 32, right: 24, bottom: 32),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: getPadding(top: 7, bottom: 5),
                                child: Text("lbl_incident".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:
                                        AppStyle.txtManropeSemiBold14Gray900)),
                            CustomButton(
                                height: getVerticalSize(33),
                                width: getHorizontalSize(76),
                                text: "lbl_02_03".tr,
                                fontStyle: ButtonFontStyle
                                    .ManropeSemiBold14WhiteA700_1)
                          ]),
                      Padding(
                          padding: getPadding(top: 16),
                          child: Container(
                              height: getVerticalSize(6),
                              width: getHorizontalSize(327),
                              decoration: BoxDecoration(
                                  color: ColorConstant.blueGray50,
                                  borderRadius: BorderRadius.circular(
                                      getHorizontalSize(3))),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      getHorizontalSize(3)),
                                  child: LinearProgressIndicator(
                                      value: 0.66,
                                      backgroundColor: ColorConstant.blueGray50,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          ColorConstant.blue500))))),
                      Padding(
                          padding: getPadding(top: 26),
                          child: Text("msg_incident_location".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtManropeBold18.copyWith(
                                  letterSpacing: getHorizontalSize(0.2)))),
                      BlocSelector<AddReportBloc, AddReportState,
                              TextEditingController?>(
                          selector: (state) => state.incidentStreetController,
                          builder: (context, incidentStreetController) {
                            return CustomTextFormField(
                                focusNode: FocusNode(),
                                controller: incidentStreetController,
                                hintText: "lbl_street_address".tr,
                                margin: getMargin(top: 13));
                          }),
                      BlocSelector<AddReportBloc, AddReportState,
                              TextEditingController?>(
                          selector: (state) => state.incidentCityController,
                          builder: (context, incidentCityController) {
                            return CustomTextFormField(
                                focusNode: FocusNode(),
                                controller: incidentCityController,
                                hintText: "lbl_city_name".tr,
                                margin: getMargin(top: 12));
                          }),
                      BlocSelector<AddReportBloc, AddReportState,
                              AddReportModel?>(
                          selector: (state) => state.addReportModelObj,
                          builder: (context, addReportModelObj) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: MultiSelectDropDown(
                                focusNode: FocusNode(),
                                hint: "lbl_select_police_district".tr,
                                onOptionSelected:
                                    (List<ValueItem> selectedOptions) {
                                  context.read<AddReportBloc>().add(
                                      IncidentDistrictSelectEvent(
                                          district:
                                              selectedOptions.first.value ??
                                                  ""));
                                },
                                options:
                                    addReportModelObj?.incidentDistrictList ??
                                        [],
                                selectionType: SelectionType.single,
                                chipConfig:
                                    const ChipConfig(wrapType: WrapType.wrap),
                                dropdownHeight: 200,
                                backgroundColor: ColorConstant.blueGray50,
                                borderColor: Color.fromARGB(0, 0, 0, 0),
                                hintStyle: TextStyle(
                                  color: ColorConstant.blueGray500,
                                  fontSize: getFontSize(
                                    14,
                                  ),
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w500,
                                  height: getVerticalSize(
                                    1.43,
                                  ),
                                ),
                                optionTextStyle: TextStyle(
                                  color: ColorConstant.blueGray500,
                                  fontSize: getFontSize(
                                    14,
                                  ),
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w500,
                                  height: getVerticalSize(
                                    1.43,
                                  ),
                                ),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                            );
                          }),
                      BlocSelector<AddReportBloc, AddReportState,
                              TextEditingController?>(
                          selector: (state) => state.incidentPinController,
                          builder: (context, incidentPinController) {
                            return CustomTextFormField(
                                focusNode: FocusNode(),
                                controller: incidentPinController,
                                hintText: "lbl_pin_code".tr,
                                margin: getMargin(top: 12, bottom: 5),
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.number);
                          }),
                      BlocSelector<AddReportBloc, AddReportState,
                              AddReportModel?>(
                          selector: (state) => state.addReportModelObj,
                          builder: (context, addReportModelObj) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: MultiSelectDropDown(
                                focusNode: FocusNode(),
                                hint: "lbl_select_police_station".tr,
                                onOptionSelected:
                                    (List<ValueItem> selectedOptions) {
                                  context.read<AddReportBloc>().add(
                                      IncidentStationSelectEvent(
                                          station:
                                              selectedOptions.first.value ??
                                                  ""));
                                },
                                options:
                                    addReportModelObj?.incidentStationList ??
                                        [],
                                selectionType: SelectionType.single,
                                chipConfig:
                                    const ChipConfig(wrapType: WrapType.wrap),
                                dropdownHeight: 200,
                                backgroundColor: ColorConstant.blueGray50,
                                borderColor: Color.fromARGB(0, 0, 0, 0),
                                hintStyle: TextStyle(
                                  color: ColorConstant.blueGray500,
                                  fontSize: getFontSize(
                                    14,
                                  ),
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w500,
                                  height: getVerticalSize(
                                    1.43,
                                  ),
                                ),
                                optionTextStyle: TextStyle(
                                  color: ColorConstant.blueGray500,
                                  fontSize: getFontSize(
                                    14,
                                  ),
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w500,
                                  height: getVerticalSize(
                                    1.43,
                                  ),
                                ),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                            );
                          }),
                    ])),
            bottomNavigationBar: Container(
                padding: getPadding(all: 24),
                decoration: AppDecoration.outlineBluegray1000f,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomButton(
                          height: getVerticalSize(56),
                          text: "lbl_next".tr,
                          shape: ButtonShape.RoundedBorder10,
                          padding: ButtonPadding.PaddingAll16,
                          fontStyle: ButtonFontStyle.ManropeBold16WhiteA700_1,
                          onTap: () {
                            onTapNext(context);
                          })
                    ]))));
  }

  onTapNext(BuildContext context) {
    final bloc = BlocProvider.of<AddReportBloc>(context);
    Map<String, dynamic> incident = bloc.state.incidentObj ?? {};
    String street = bloc.state.incidentStreetController?.text.trim() ?? "";
    String city = bloc.state.incidentCityController?.text.trim() ?? "";
    String pin = bloc.state.incidentPinController?.text.trim() ?? "";
    String district = bloc.state.incidentDistrictValue ?? "";
    String location = "${street}, ${city}, ${district}, PIN-${pin}";
    String station = bloc.state.incidentStationValue ?? "";

    incident["location"] = location;
    incident["stationName"] = station;
    NavigatorService.pushNamed(AppRoutes.addReportEvidenceScreen, arguments: {
      "incidentObj": incident,
    });
  }

  onTapArrowleft5(BuildContext context) {
    NavigatorService.goBack();
  }
}
