import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/data/models/home/get_incident_resp.dart';
// import 'package:rakshak/widgets/custom_icon_button.dart';
// import 'package:rakshak/widgets/custom_button.dart';

// ignore: must_be_immutable
class IncidentWidget extends StatelessWidget {
  IncidentWidget(this.incident, {this.onTapIncident});

  Incident incident;
  VoidCallback? onTapIncident;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapIncident?.call(),
      child: Container(
          width: double.maxFinite,
          child: Container(
              margin: getMargin(top: 24),
              padding: getPadding(left: 16, top: 14, right: 16, bottom: 14),
              decoration: AppDecoration.outlineGray300
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: getPadding(top: 5, right: 2),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(incident.title ?? "Incident Title",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtManropeBold16
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.2))),
                                    Padding(
                                        padding: getPadding(top: 6),
                                        child: Row(children: [
                                          CustomImageView(
                                              svgPath:
                                                  ImageConstant.imgLocation,
                                              height: getSize(14),
                                              width: getSize(14),
                                              margin: getMargin(bottom: 2)),
                                          Padding(
                                              padding: getPadding(left: 4),
                                              child: Text(
                                                  addEllipsis(
                                                      incident.location ??
                                                          "Incident Location",
                                                      24),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle.txtManrope12
                                                      .copyWith(
                                                          letterSpacing:
                                                              getHorizontalSize(
                                                                  0.4))))
                                        ])),
                                    Padding(
                                        padding: getPadding(top: 6),
                                        child: Row(children: [
                                          CustomImageView(
                                              svgPath: ImageConstant
                                                  .imgPoliceStation,
                                              color: ColorConstant.blue500,
                                              height: getSize(14),
                                              width: getSize(14),
                                              margin: getMargin(bottom: 2)),
                                          Padding(
                                              padding: getPadding(left: 4),
                                              child: Text(
                                                  (incident.station_name ??
                                                          "Unknown") +
                                                      " Station",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle.txtManrope12
                                                      .copyWith(
                                                          letterSpacing:
                                                              getHorizontalSize(
                                                                  0.4))))
                                        ]))
                                  ]),
                              Padding(
                                  padding: getPadding(top: 1, bottom: 3),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          CustomImageView(
                                              svgPath:
                                                  ImageConstant.imgCalendar,
                                              height: getSize(14),
                                              width: getSize(14),
                                              margin: getMargin(bottom: 2)),
                                          Padding(
                                              padding: getPadding(left: 6),
                                              child: Text(
                                                  formatDate(
                                                      incident.created_at ??
                                                          DateTime.now()
                                                              .toString()),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtManropeSemiBold12
                                                      .copyWith(
                                                          letterSpacing:
                                                              getHorizontalSize(
                                                                  0.4))))
                                        ]),
                                        Padding(
                                            padding: getPadding(top: 6),
                                            child: Row(children: [
                                              CustomImageView(
                                                  svgPath: ImageConstant
                                                      .imgClockBlue500,
                                                  height: getSize(14),
                                                  width: getSize(14),
                                                  margin: getMargin(bottom: 2)),
                                              Padding(
                                                  padding: getPadding(left: 6),
                                                  child: Text(
                                                      formatTime(
                                                          incident.created_at ??
                                                              DateTime.now()
                                                                  .toString()),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .txtManropeSemiBold12
                                                          .copyWith(
                                                              letterSpacing:
                                                                  getHorizontalSize(
                                                                      0.4))))
                                            ])),
                                        Padding(
                                            padding: getPadding(top: 6),
                                            child: Row(children: [
                                              CustomImageView(
                                                  svgPath: getIncidentImage(
                                                      incident.status ??
                                                          "status"),
                                                  color: getIncidentColor(
                                                      incident.status ??
                                                          "status"),
                                                  height: getSize(14),
                                                  width: getSize(14),
                                                  margin: getMargin(bottom: 2)),
                                              Padding(
                                                  padding: getPadding(left: 6),
                                                  // add green color to text using style
                                                  child: Text(
                                                      incident.status ??
                                                          "status",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .txtManropeSemiBold12
                                                          .copyWith(
                                                              color: getIncidentColor(
                                                                  incident.status ??
                                                                      "status"),
                                                              letterSpacing:
                                                                  getHorizontalSize(
                                                                      0.4))))
                                            ]))
                                      ]))
                            ])),
                  ]))),
    );
  }
}
