import 'package:rakshak/data/models/home/get_incident_resp.dart';
import 'package:rakshak/presentation/citizen/home_page/widgets/incident_widget.dart';
import 'package:rakshak/widgets/custom_button.dart';
import 'bloc/incidents_police_bloc.dart';
import 'models/incidents_police_model.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/widgets/custom_search_view.dart';

class IncidentsPolicePage extends StatelessWidget {
  static Widget builder(BuildContext context) {
    return BlocProvider<IncidentsPoliceBloc>(
        create: (context) => IncidentsPoliceBloc(IncidentsPoliceState(
            incidentType: "Reported",
            incidentsPoliceModelObj: IncidentsPoliceModel()))
          ..add(IncidentsPoliceInitialEvent()),
        child: IncidentsPolicePage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray50,
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                width: size.width,
                child: SingleChildScrollView(
                    child: Padding(
                        padding:
                            getPadding(left: 24, top: 24, right: 24, bottom: 5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: getMargin(bottom: 16),
                                  padding: EdgeInsets.all(4),
                                  decoration: AppDecoration.fillBlue50.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder10),
                                  child: BlocSelector<IncidentsPoliceBloc,
                                      IncidentsPoliceState, String>(
                                    selector: (state) => state.incidentType,
                                    builder: (context, incidentType) {
                                      return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () => context
                                                    .read<IncidentsPoliceBloc>()
                                                    .add(
                                                        IncidentTypeChangeEvent(
                                                            incidentType:
                                                                "Reported")),
                                                child: incidentType ==
                                                        "Reported"
                                                    ? CustomButton(
                                                        margin:
                                                            getMargin(left: 4),
                                                        text: "lbl_reported".tr,
                                                        prefixWidget: Container(
                                                            margin: getMargin(
                                                                right: 8),
                                                            child: CustomImageView(
                                                                color: ColorConstant
                                                                    .whiteA700,
                                                                svgPath:
                                                                    ImageConstant
                                                                        .imgMenu1)),
                                                        variant: ButtonVariant
                                                            .FillBlue500,
                                                        shape: ButtonShape
                                                            .RoundedBorder5,
                                                        padding: ButtonPadding
                                                            .PaddingAll12,
                                                        fontStyle: ButtonFontStyle
                                                            .ManropeBold12WhiteA700_1)
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                              margin: getMargin(
                                                                  right: 8),
                                                              child: CustomImageView(
                                                                  color: ColorConstant
                                                                      .black900,
                                                                  svgPath:
                                                                      ImageConstant
                                                                          .imgMenu1)),
                                                          Text(
                                                              "lbl_reported".tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: AppStyle
                                                                  .txtManropeBold12
                                                                  .copyWith(
                                                                      letterSpacing:
                                                                          getHorizontalSize(
                                                                              0.2))),
                                                        ],
                                                      ),
                                              ),
                                            ),
                                            SizedBox(
                                                width: getHorizontalSize(8)),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () => context
                                                    .read<IncidentsPoliceBloc>()
                                                    .add(
                                                        IncidentTypeChangeEvent(
                                                            incidentType:
                                                                "Detected")),
                                                child: incidentType ==
                                                        "Detected"
                                                    ? CustomButton(
                                                        margin:
                                                            getMargin(right: 4),
                                                        text: "lbl_detected".tr,
                                                        prefixWidget: Container(
                                                            margin: getMargin(
                                                                right: 8),
                                                            child: CustomImageView(
                                                                color: ColorConstant
                                                                    .whiteA700,
                                                                svgPath:
                                                                    ImageConstant
                                                                        .imgCctv)),
                                                        variant: ButtonVariant
                                                            .FillBlue500,
                                                        shape: ButtonShape
                                                            .RoundedBorder5,
                                                        padding: ButtonPadding
                                                            .PaddingAll12,
                                                        fontStyle: ButtonFontStyle
                                                            .ManropeBold12WhiteA700_1)
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                              margin: getMargin(
                                                                  right: 8),
                                                              child: CustomImageView(
                                                                  color: ColorConstant
                                                                      .black900,
                                                                  width:
                                                                      getSize(
                                                                          20),
                                                                  svgPath:
                                                                      ImageConstant
                                                                          .imgCctv)),
                                                          Text(
                                                              "lbl_detected".tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: AppStyle
                                                                  .txtManropeBold12
                                                                  .copyWith(
                                                                      letterSpacing:
                                                                          getHorizontalSize(
                                                                              0.2))),
                                                        ],
                                                      ),
                                              ),
                                            ),
                                          ]);
                                    },
                                  )),
                              BlocBuilder<IncidentsPoliceBloc,
                                  IncidentsPoliceState>(
                                builder: (context, state) {
                                  return CustomSearchView(
                                      onChanged: (value) {
                                        return context
                                            .read<IncidentsPoliceBloc>()
                                            .add(OnIncidentSearch(
                                                incidentType:
                                                    state.incidentType,
                                                searchVal: state
                                                    .incidentSearchController!
                                                    .text
                                                    .trim()));
                                      },
                                      focusNode: FocusNode(),
                                      controller:
                                          state.incidentSearchController,
                                      hintText: "lbl_search".tr,
                                      prefix: Container(
                                          margin: getMargin(
                                              left: 16,
                                              top: 16,
                                              right: 12,
                                              bottom: 16),
                                          child: CustomImageView(
                                              svgPath:
                                                  ImageConstant.imgSearch)),
                                      prefixConstraints: BoxConstraints(
                                          maxHeight: getVerticalSize(56)),
                                      suffix: Container(
                                          margin: getMargin(
                                              left: 30,
                                              top: 16,
                                              right: 16,
                                              bottom: 16),
                                          child: CustomImageView(
                                              svgPath:
                                                  ImageConstant.imgSettings)),
                                      suffixConstraints: BoxConstraints(
                                          maxHeight: getVerticalSize(56)));
                                },
                              ),
                              Padding(
                                  padding: getPadding(top: 24),
                                  child: BlocSelector<
                                          IncidentsPoliceBloc,
                                          IncidentsPoliceState,
                                          IncidentsPoliceModel>(
                                      selector: (state) =>
                                          state.incidentsPoliceModelObj,
                                      builder:
                                          (context, incidentsPoliceModelObj) {
                                        return incidentsPoliceModelObj
                                                    .incidentList.length ==
                                                0
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomImageView(
                                                      imagePath: ImageConstant
                                                          .imageNoDataFound,
                                                      height: getSize(150),
                                                      width: getSize(150)),
                                                  Padding(
                                                    padding:
                                                        getPadding(top: 16),
                                                    child: Text(
                                                        "No Reports Found"),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          getPadding(top: 24),
                                                      child: CustomButton(
                                                          width: getSize(200),
                                                          height:
                                                              getVerticalSize(
                                                                  37),
                                                          text:
                                                              "lbl_report_incident"
                                                                  .tr,
                                                          variant: ButtonVariant
                                                              .OutlineBlue500,
                                                          shape: ButtonShape
                                                              .RoundedBorder5,
                                                          padding: ButtonPadding
                                                              .PaddingT10,
                                                          fontStyle: ButtonFontStyle
                                                              .ManropeSemiBold14Blue500,
                                                          prefixWidget: Container(
                                                              margin: getMargin(
                                                                  right: 8),
                                                              child: CustomImageView(
                                                                  svgPath:
                                                                      ImageConstant
                                                                          .imgPlus1))))
                                                ],
                                              )
                                            : ListView.separated(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                separatorBuilder:
                                                    (context, index) {
                                                  return SizedBox(
                                                      height:
                                                          getVerticalSize(2));
                                                },
                                                itemCount:
                                                    incidentsPoliceModelObj
                                                        .tempIncidentList
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  Incident incident =
                                                      incidentsPoliceModelObj
                                                              .tempIncidentList[
                                                          index];
                                                  return IncidentWidget(
                                                      incident,
                                                      onTapIncident: () {
                                                    onTapIncident(
                                                        context, incident);
                                                  });
                                                });
                                      }))
                            ]))))));
  }

  onTapIncident(BuildContext context, Incident incident) {
    NavigatorService.pushNamed(AppRoutes.incidentDetailsScreen, arguments: {
      "incident": incident,
    });
  }

  onTapNotification(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.notificationScreen,
    );
  }
}
