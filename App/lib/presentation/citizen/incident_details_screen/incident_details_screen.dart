import 'bloc/incident_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/widgets/custom_icon_button.dart';

class IncidentDetailsScreen extends StatelessWidget {
  static Widget builder(BuildContext context) {
    var arg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return BlocProvider<IncidentDetailsBloc>(
      create: (context) {
        return IncidentDetailsBloc(IncidentDetailsState(
          incident: arg["incident"],
        ))
          ..add(IncidentDetailsInitialEvent());
      },
      child: IncidentDetailsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConstant.gray50,
      body: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
              child: Padding(
                  padding: getPadding(left: 16, top: 33, bottom: 5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            CustomIconButton(
                              height: 36,
                              width: 36,
                              variant: IconButtonVariant.OutlineGray300_1,
                              child: CustomImageView(
                                svgPath: ImageConstant.imgArrowleft,
                                height: getSize(20),
                                width: getSize(20),
                              ),
                              onTap: () {
                                onTapBack(context);
                              },
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Reported Incident",
                                overflow: TextOverflow.ellipsis,
                                style: AppStyle.txtManropeExtraBold18.copyWith(
                                  letterSpacing: getHorizontalSize(0.2),
                                ),
                              ),
                            ),
                          ],
                        ),
                        BlocBuilder<IncidentDetailsBloc, IncidentDetailsState>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: getPadding(left: 8, top: 34),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Title",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtManropeBold16
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.2))),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(state.incident?.title ?? "-",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtManropeRegular14Gray900
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.2)))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Incident ID",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtManropeBold16
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.2))),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(state.incident?.id ?? "-",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtManropeRegular14Gray900
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.2)))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(left: 8, top: 24),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Date",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtManropeBold16
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.2))),
                                            SizedBox(
                                              height: 4,
                                            ),
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
                                                      formatDate(state.incident
                                                              ?.created_at ??
                                                          DateTime.now()
                                                              .toString()),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .txtManropeRegular14Gray900
                                                          .copyWith(
                                                              letterSpacing:
                                                                  getHorizontalSize(
                                                                      0.2))))
                                            ]),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Status",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtManropeBold16
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.2))),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Padding(
                                                padding: getPadding(top: 4),
                                                child: Row(children: [
                                                  CustomImageView(
                                                      svgPath: getIncidentImage(
                                                          state.incident
                                                                  ?.status ??
                                                              "status"),
                                                      color: getIncidentColor(
                                                          state.incident
                                                                  ?.status ??
                                                              "status"),
                                                      height: getSize(14),
                                                      width: getSize(14),
                                                      margin:
                                                          getMargin(top: 2)),
                                                  Padding(
                                                      padding:
                                                          getPadding(left: 6),
                                                      // add green color to text using style
                                                      child: Text(
                                                          state.incident
                                                                  ?.status ??
                                                              "status",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtManropeRegular14Gray900
                                                              .copyWith(
                                                                  color: getIncidentColor(state
                                                                          .incident
                                                                          ?.status ??
                                                                      "status"),
                                                                  letterSpacing:
                                                                      getHorizontalSize(
                                                                          0.2))))
                                                ]))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(left: 8, top: 24),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Police Station",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtManropeBold16
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.2))),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Padding(
                                                padding: getPadding(top: 4),
                                                child: Row(children: [
                                                  CustomImageView(
                                                      svgPath: ImageConstant
                                                          .imgPoliceStation,
                                                      color:
                                                          ColorConstant.blue500,
                                                      height: getSize(14),
                                                      width: getSize(14),
                                                      margin:
                                                          getMargin(bottom: 2)),
                                                  Padding(
                                                      padding:
                                                          getPadding(left: 4),
                                                      child: Text(
                                                          state.incident
                                                                  ?.station_name ??
                                                              "Unknown" +
                                                                  " Police Station",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtManropeRegular14Gray900
                                                              .copyWith(
                                                                  letterSpacing:
                                                                      getHorizontalSize(
                                                                          0.2))))
                                                ]))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Category",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtManropeBold16
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.2))),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(state.incident?.type ?? "-",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtManropeRegular14Gray900
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.2)))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                state.incident?.description != null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding:
                                                  getPadding(left: 8, top: 34),
                                              child: Text("lbl_description".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtManropeBold16
                                                      .copyWith(
                                                          letterSpacing:
                                                              getHorizontalSize(
                                                                  0.2)))),
                                          Container(
                                              width: getHorizontalSize(327),
                                              margin: getMargin(
                                                  left: 8, top: 13, right: 39),
                                              child: Text(
                                                  state.incident?.description ??
                                                      "-",
                                                  maxLines: null,
                                                  textAlign: TextAlign.justify,
                                                  style: AppStyle
                                                      .txtManropeRegular14Gray900))
                                        ],
                                      )
                                    : SizedBox(),
                                Padding(
                                    padding: getPadding(left: 8, top: 34),
                                    child: Text("lbl_image_evidence".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtManropeBold16
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.2)))),
                                Padding(
                                    padding:
                                        getPadding(left: 8, top: 13, right: 39),
                                    child: Row(children: [
                                      CustomImageView(
                                          url: state.incident?.image ??
                                              ImageConstant.noImageUrl,
                                          height: getVerticalSize(250),
                                          width: getHorizontalSize(250)),
                                    ])),
                                Padding(
                                    padding: getPadding(left: 8, top: 32),
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding:
                                                getPadding(left: 4, right: 4),
                                            child: Text(
                                                "lbl_location".tr + ": ",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtManropeBold16
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.2)))),
                                        CustomImageView(
                                            svgPath: ImageConstant.imgLocation,
                                            height: getSize(14),
                                            width: getSize(14),
                                            margin: getMargin(bottom: 2)),
                                        Padding(
                                            padding: getPadding(left: 4),
                                            child: Text(
                                                addEllipsis(
                                                    state.incident?.location ??
                                                        "location",
                                                    35),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtManropeRegular14Gray900
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.2)))),
                                      ],
                                    )),
                                Container(
                                    height: getVerticalSize(152),
                                    width: getHorizontalSize(327),
                                    margin: getMargin(left: 8, top: 15),
                                    child: Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          CustomImageView(
                                              imagePath: ImageConstant
                                                  .imgMapsiclemap152x3271,
                                              height: getVerticalSize(152),
                                              width: getHorizontalSize(327),
                                              radius: BorderRadius.circular(
                                                  getHorizontalSize(16)),
                                              alignment: Alignment.center),
                                          CustomImageView(
                                              svgPath:
                                                  ImageConstant.imgEye80x80,
                                              height: getSize(80),
                                              width: getSize(80),
                                              alignment: Alignment.topLeft,
                                              margin:
                                                  getMargin(left: 93, top: 31))
                                        ])),
                              ],
                            );
                          },
                        ),
                      ])))),
    ));
  }
}

onTapBack(BuildContext context) {
  NavigatorService.goBack();
}
