import 'package:rakshak/data/models/home/get_incident_resp.dart';
import 'package:rakshak/presentation/citizen/home_page/widgets/incident_widget.dart';
import 'package:rakshak/widgets/custom_button.dart';
import 'bloc/home_bloc.dart';
import 'models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/widgets/app_bar/appbar_iconbutton.dart';
import 'package:rakshak/widgets/app_bar/appbar_image.dart';
import 'package:rakshak/widgets/app_bar/appbar_subtitle_2.dart';
import 'package:rakshak/widgets/app_bar/custom_app_bar.dart';
import 'package:rakshak/widgets/custom_search_view.dart';

class HomePage extends StatelessWidget {
  static Widget builder(BuildContext context) {
    return BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(HomeState(homeModelObj: HomeModel()))
          ..add(HomeInitialEvent()),
        child: HomePage());
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
                  BlocSelector<HomeBloc, HomeState, bool>(
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
                            children: [
                              BlocSelector<HomeBloc, HomeState,
                                      TextEditingController?>(
                                  selector: (state) =>
                                      state.incidentSearchController,
                                  builder: (context, incidentSearchController) {
                                    return CustomSearchView(
                                        onChanged: (value) {
                                          return context.read<HomeBloc>().add(
                                              OnIncidentSearch(
                                                  searchVal:
                                                      incidentSearchController!
                                                          .text
                                                          .trim()));
                                        },
                                        focusNode: FocusNode(),
                                        controller: incidentSearchController,
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
                                  }),
                              Padding(
                                  padding: getPadding(top: 24),
                                  child: BlocSelector<HomeBloc, HomeState,
                                          HomeModel>(
                                      selector: (state) => state.homeModelObj,
                                      builder: (context, homeModelObj) {
                                        return homeModelObj
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
                                                itemCount: homeModelObj
                                                    .tempIncidentList.length,
                                                itemBuilder: (context, index) {
                                                  Incident incident =
                                                      homeModelObj
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
