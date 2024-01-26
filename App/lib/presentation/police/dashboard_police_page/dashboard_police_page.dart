import 'package:rakshak/data/models/home/get_incident_resp.dart';
import 'package:rakshak/widgets/custom_icon_button.dart';
import 'bloc/dashboard_police_bloc.dart';
import 'models/dashboard_police_model.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/widgets/app_bar/appbar_iconbutton.dart';
import 'package:rakshak/widgets/app_bar/appbar_image.dart';
import 'package:rakshak/widgets/app_bar/appbar_subtitle_2.dart';
import 'package:rakshak/widgets/app_bar/custom_app_bar.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPolicePage extends StatelessWidget {
  String todayDate = DateTime.now().toLocal().toIso8601String().split('T')[0];
  static Widget builder(BuildContext context) {
    return BlocProvider<DashboardPoliceBloc>(
        create: (context) => DashboardPoliceBloc(DashboardPoliceState(
            barChartConstants:
                BarChartConstants(0, dataListConstants, weekDaysConstants),
            dashboardPoliceModelObj: DashboardPoliceModel()))
          ..add(DashboardPoliceInitialEvent()),
        child: DashboardPolicePage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray50,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
                height: getVerticalSize(60),
                title: Padding(
                    padding: getPadding(left: 24),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppbarSubtitle2(
                              text: "Welcome,",
                              margin: getMargin(right: 136, top: 20)),
                          Padding(
                              padding: getPadding(top: 1),
                              child: Row(children: [
                                AppbarImage(
                                    height: getSize(20),
                                    width: getSize(20),
                                    svgPath: ImageConstant.imgUser,
                                    margin: getMargin(bottom: 3, top: 3)),
                                SizedBox(width: getSize(6)),
                                Text(PrefUtils().getName(),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtManropeExtraBold14Gray900
                                        .copyWith(
                                            letterSpacing:
                                                getHorizontalSize(0.2))),
                              ]))
                        ])),
                actions: [
                  BlocSelector<DashboardPoliceBloc, DashboardPoliceState, bool>(
                    selector: (state) => state.isNotificationPresent,
                    builder: (context, isNotificationPresent) {
                      return AppbarIconbutton(
                          svgPath: isNotificationPresent
                              ? ImageConstant.imgNotificationPresent
                              : ImageConstant.imgNotificationNone,
                          margin: getMargin(left: 12, top: 10, right: 34),
                          onTap: () {
                            onTapNotification(context);
                          });
                    },
                  )
                ],
                styleType: Style.bgFillGray50),
            body: SizedBox(
                width: size.width,
                child: SingleChildScrollView(
                    child: Padding(
                        padding:
                            getPadding(left: 24, top: 24, right: 24, bottom: 5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: getMargin(right: 8),
                                      child: CustomImageView(
                                          width: getSize(20),
                                          svgPath:
                                              ImageConstant.imgPoliceStation)),
                                  Padding(
                                    padding: getPadding(top: 4),
                                    child: Text(
                                        PrefUtils().getStation() + " Station",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtManropeBold12
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.2))),
                                  ),
                                  Padding(
                                    padding: getPadding(top: 4, left: 4),
                                    child: Text(
                                        "(" +
                                            formatDate(
                                                DateTime.now().toString()) +
                                            ")",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtManropeBold12
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.2))),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: getPadding(top: 16),
                                child: BlocSelector<DashboardPoliceBloc,
                                    DashboardPoliceState, DashboardPoliceModel>(
                                  selector: (state) =>
                                      state.dashboardPoliceModelObj,
                                  builder: (context, obj) {
                                    return Row(children: [
                                      Expanded(
                                          child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: AppDecoration.outlineGray300
                                            .copyWith(
                                                borderRadius: BorderRadiusStyle
                                                    .roundedBorder10),
                                        child: Row(
                                          children: [
                                            CustomIconButton(
                                                height: 34,
                                                width: 34,
                                                variant: IconButtonVariant
                                                    .FillBlue500,
                                                shape: IconButtonShape
                                                    .RoundedBorder5,
                                                child: CustomImageView(
                                                    color:
                                                        ColorConstant.whiteA700,
                                                    svgPath: ImageConstant
                                                        .imgMenu1)),
                                            Padding(
                                                padding: getPadding(left: 8),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text("lbl_reported".tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtManrope10
                                                              .copyWith(
                                                                  letterSpacing:
                                                                      getHorizontalSize(
                                                                          0.4))),
                                                      Padding(
                                                          padding: getPadding(
                                                              top: 1),
                                                          child: Text(
                                                              (obj.reportedList.length > 0
                                                                      ? obj
                                                                          .reportedList
                                                                          .where((incident) => incident.created_at!.startsWith(
                                                                              todayDate))
                                                                          .toList()
                                                                          .length
                                                                          .toString()
                                                                      : "0") +
                                                                  " incidents",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: AppStyle
                                                                  .txtManropeBold12
                                                                  .copyWith(
                                                                      letterSpacing:
                                                                          getHorizontalSize(0.3))))
                                                    ])),
                                          ],
                                        ),
                                      )),
                                      SizedBox(width: getSize(10)),
                                      Expanded(
                                          child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: AppDecoration.outlineGray300
                                            .copyWith(
                                                borderRadius: BorderRadiusStyle
                                                    .roundedBorder10),
                                        child: Row(
                                          children: [
                                            CustomIconButton(
                                                height: 34,
                                                width: 34,
                                                variant: IconButtonVariant
                                                    .FillBlue500,
                                                shape: IconButtonShape
                                                    .RoundedBorder5,
                                                child: CustomImageView(
                                                    color:
                                                        ColorConstant.whiteA700,
                                                    svgPath:
                                                        ImageConstant.imgCctv)),
                                            Padding(
                                                padding: getPadding(left: 8),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text("lbl_detected".tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtManrope10
                                                              .copyWith(
                                                                  letterSpacing:
                                                                      getHorizontalSize(
                                                                          0.3))),
                                                      Padding(
                                                          padding: getPadding(
                                                              top: 1),
                                                          child: Text(
                                                              (obj.detectedList.length > 0
                                                                      ? obj
                                                                          .detectedList
                                                                          .where((incident) => incident.created_at!.startsWith(
                                                                              todayDate))
                                                                          .toList()
                                                                          .length
                                                                          .toString()
                                                                      : "0") +
                                                                  " incidents",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: AppStyle
                                                                  .txtManropeBold12
                                                                  .copyWith(
                                                                      letterSpacing:
                                                                          getHorizontalSize(0.4))))
                                                    ])),
                                          ],
                                        ),
                                      )),
                                    ]);
                                  },
                                ),
                              ),
                              Container(
                                margin: getMargin(top: 16, bottom: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: AppDecoration.outlineGray300
                                    .copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder10),
                                child: Column(
                                  children: [
                                    AspectRatio(
                                        aspectRatio: 1,
                                        child: BlocSelector<
                                            DashboardPoliceBloc,
                                            DashboardPoliceState,
                                            BarChartConstants>(
                                          selector: (state) =>
                                              state.barChartConstants,
                                          builder: (context, obj) {
                                            return BarChart(
                                              BarChartData(
                                                alignment: BarChartAlignment
                                                    .spaceBetween,
                                                borderData: FlBorderData(
                                                  show: true,
                                                  border: Border.symmetric(
                                                    horizontal: BorderSide(
                                                      color: ColorConstant
                                                          .whiteA700
                                                          .withOpacity(0.2),
                                                    ),
                                                  ),
                                                ),
                                                titlesData: FlTitlesData(
                                                  show: true,
                                                  leftTitles: AxisTitles(
                                                    drawBelowEverything: true,
                                                    sideTitles: SideTitles(
                                                      showTitles: true,
                                                      reservedSize: 30,
                                                      getTitlesWidget:
                                                          (value, meta) {
                                                        return Text(
                                                          value
                                                              .toInt()
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  bottomTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                      showTitles: true,
                                                      reservedSize: 36,
                                                      getTitlesWidget:
                                                          (value, meta) {
                                                        return obj.getTitles(
                                                            value, meta);
                                                      },
                                                    ),
                                                  ),
                                                  rightTitles:
                                                      const AxisTitles(),
                                                  topTitles: const AxisTitles(),
                                                ),
                                                gridData: FlGridData(
                                                  show: true,
                                                  drawVerticalLine: false,
                                                  getDrawingHorizontalLine:
                                                      (value) => FlLine(
                                                    color: ColorConstant
                                                        .whiteA700
                                                        .withOpacity(0.2),
                                                    strokeWidth: 1,
                                                  ),
                                                ),
                                                barGroups: obj.dataList
                                                    .asMap()
                                                    .entries
                                                    .map((e) {
                                                  final index = e.key;
                                                  final data = e.value;
                                                  return obj.generateBarGroup(
                                                    index,
                                                    data.color,
                                                    data.value,
                                                    data.shadowValue,
                                                  );
                                                }).toList(),
                                                barTouchData: BarTouchData(
                                                    enabled: true,
                                                    handleBuiltInTouches: false,
                                                    touchCallback:
                                                        (event, response) {
                                                      if (response != null &&
                                                          response.spot !=
                                                              null &&
                                                          event
                                                              is FlTapUpEvent) {
                                                        final x = response.spot!
                                                            .touchedBarGroup.x;
                                                        final isShowing =
                                                            obj.showingTooltip ==
                                                                x;
                                                        if (isShowing) {
                                                          context
                                                              .read<
                                                                  DashboardPoliceBloc>()
                                                              .add(
                                                                  DashboardPoliceTooltipEvent(
                                                                      value:
                                                                          -1));
                                                        } else {
                                                          context
                                                              .read<
                                                                  DashboardPoliceBloc>()
                                                              .add(
                                                                  DashboardPoliceTooltipEvent(
                                                                      value:
                                                                          x));
                                                        }
                                                      }
                                                    },
                                                    mouseCursorResolver:
                                                        (event, response) {
                                                      return response == null ||
                                                              response.spot ==
                                                                  null
                                                          ? MouseCursor.defer
                                                          : SystemMouseCursors
                                                              .click;
                                                    }),
                                              ),
                                            );
                                          },
                                        )),
                                    Padding(
                                        padding: getPadding(top: 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "lbl_reported".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle.txtManropeBold12
                                                  .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(
                                                  0.2,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: getMargin(left: 8),
                                              height: getSize(10),
                                              width: getSize(10),
                                              decoration: BoxDecoration(
                                                color: ColorConstant.blue500,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            SizedBox(width: getSize(24)),
                                            Text(
                                              "lbl_detected".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle.txtManropeBold12
                                                  .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(
                                                  0.2,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: getMargin(left: 8),
                                              height: getSize(10),
                                              width: getSize(10),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFCCCCCC),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              BlocSelector<DashboardPoliceBloc,
                                  DashboardPoliceState, Incident?>(
                                selector: (state) => state.recentIncident,
                                builder: (context, incident) {
                                  return incident != null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("lbl_recent_incident".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtManropeBold12
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.2))),
                                            GestureDetector(
                                              onTap: () {
                                                onTapIncident(
                                                    context, incident);
                                              },
                                              child: Container(
                                                  margin: getMargin(
                                                      top: 12, bottom: 12),
                                                  padding: getPadding(
                                                      left: 12,
                                                      top: 13,
                                                      right: 12,
                                                      bottom: 13),
                                                  decoration: AppDecoration
                                                      .outlineGray3002
                                                      .copyWith(
                                                          borderRadius:
                                                              BorderRadiusStyle
                                                                  .roundedBorder10),
                                                  child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        CustomImageView(
                                                            svgPath: incident
                                                                        .source ==
                                                                    "CCTV"
                                                                ? ImageConstant
                                                                    .imgCctv
                                                                : ImageConstant
                                                                    .imgMenu1,
                                                            height: getSize(24),
                                                            width: getSize(24),
                                                            color: ColorConstant
                                                                .blue500,
                                                            margin: getMargin(
                                                                top: 15,
                                                                bottom: 19)),
                                                        Expanded(
                                                            child: Padding(
                                                                padding:
                                                                    getPadding(
                                                                        left:
                                                                            16),
                                                                child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          addEllipsis(
                                                                              incident.title ??
                                                                                  "title",
                                                                              20),
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          textAlign: TextAlign
                                                                              .left,
                                                                          style: AppStyle
                                                                              .txtManropeBold12
                                                                              .copyWith(letterSpacing: getHorizontalSize(0.4))),
                                                                      Padding(
                                                                        padding:
                                                                            getPadding(top: 5),
                                                                        child: Text(
                                                                            addEllipsis(formatDate(incident.created_at ?? DateTime.now().toString()) + " - " + formatTime(incident.created_at ?? DateTime.now().toString()),
                                                                                30),
                                                                            overflow: TextOverflow.ellipsis,
                                                                            textAlign: TextAlign.left,
                                                                            style: AppStyle.txtManrope12Gray900.copyWith(letterSpacing: getHorizontalSize(0.4))),
                                                                      ),
                                                                      Container(
                                                                          width: getHorizontalSize(
                                                                              204),
                                                                          margin: getMargin(
                                                                              top:
                                                                                  5),
                                                                          child: Text(
                                                                              addEllipsis(incident.description ?? "description", 30),
                                                                              overflow: TextOverflow.ellipsis,
                                                                              maxLines: 1,
                                                                              textAlign: TextAlign.left,
                                                                              style: AppStyle.txtManrope12Gray900.copyWith(letterSpacing: getHorizontalSize(0.4)))),
                                                                    ]))),
                                                        CustomImageView(
                                                            svgPath: ImageConstant
                                                                .imgArrowrightBlueGray500,
                                                            height: getSize(20),
                                                            width: getSize(20),
                                                            margin: getMargin(
                                                                left: 38,
                                                                top: 17,
                                                                bottom: 21))
                                                      ])),
                                            ),
                                          ],
                                        )
                                      : SizedBox();
                                },
                              ),
                            ]))))));
  }

  onTapIncident(BuildContext context, Incident incident) {
    NavigatorService.pushNamed(AppRoutes.incidentDetailsScreen, arguments: {
      "incident": incident,
    });
  }

  onTapNotification(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.notificationPoliceScreen,
    );
  }
}
