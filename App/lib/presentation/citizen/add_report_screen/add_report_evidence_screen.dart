import 'dart:io';

import 'bloc/add_report_bloc.dart';
import 'models/add_report_model.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/widgets/app_bar/appbar_iconbutton_1.dart';
import 'package:rakshak/widgets/app_bar/appbar_subtitle.dart';
import 'package:rakshak/widgets/app_bar/custom_app_bar.dart';
import 'package:rakshak/widgets/custom_button.dart';
// import 'package:rakshak/widgets/custom_text_form_field.dart';
// import 'package:multi_dropdown/multiselect_dropdown.dart';

class AddReportEvidenceScreen extends StatelessWidget {
  static Widget builder(BuildContext context) {
    var arg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return BlocProvider<AddReportBloc>(
        create: (context) => AddReportBloc(AddReportState(
            addReportModelObj: AddReportModel(),
            incidentObj: arg["incidentObj"]))
          ..add(AddReportEvidenceInitialEvent()),
        child: AddReportEvidenceScreen());
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
                                text: "lbl_03_03".tr,
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
                                      value: 1.00,
                                      backgroundColor: ColorConstant.blueGray50,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          ColorConstant.blue500))))),
                      Padding(
                          padding: getPadding(top: 26, bottom: 16),
                          child: Text("msg_incident_evidence".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtManropeBold18.copyWith(
                                  letterSpacing: getHorizontalSize(0.2)))),
                      CustomButton(
                          height: getVerticalSize(56),
                          text: "lbl_select_img".tr,
                          suffixWidget: Container(
                              margin: getMargin(left: 10),
                              child: CustomImageView(
                                  svgPath: ImageConstant.imgCamera)),
                          shape: ButtonShape.RoundedBorder10,
                          padding: ButtonPadding.PaddingAll16,
                          variant: ButtonVariant.OutlineGray300,
                          fontStyle: ButtonFontStyle.ManropeBold16Blue500_1,
                          onTap: () {
                            onTapSelect(context);
                          }),
                      Flexible(
                        child: BlocBuilder<AddReportBloc, AddReportState>(
                          builder: (context, state) {
                            return Container(
                              margin: getMargin(top: 30),
                              child: state.incidentImage == null
                                  ? CustomImageView(
                                      imagePath: ImageConstant.imageNoDataFound,
                                      height: getSize(200),
                                      width: getSize(200),
                                      radius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      alignment: Alignment.center,
                                    )
                                  : CustomImageView(
                                      file: File(state.incidentImage!),
                                      height: getSize(200),
                                      width: getSize(200),
                                      radius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      alignment: Alignment.center,
                                    ),
                            );
                          },
                        ),
                      ),
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
                          text: "lbl_submit".tr,
                          shape: ButtonShape.RoundedBorder10,
                          padding: ButtonPadding.PaddingAll16,
                          fontStyle: ButtonFontStyle.ManropeBold16WhiteA700_1,
                          onTap: () {
                            onTapSubmit(context);
                          })
                    ]))));
  }

  onTapSelect(BuildContext context) async {
    await PermissionManager.askForPermission(Permission.camera);
    await PermissionManager.askForPermission(Permission.storage);
    await FileManager().showModelSheetForImage(getImages: (value) async {
      if (value != [] && value.isNotEmpty) {
        context
            .read<AddReportBloc>()
            .add(IncidentImageSelectEvent(imagePath: value.first));
      }
    });
  }

  onTapSubmit(BuildContext context) {
    final bloc = BlocProvider.of<AddReportBloc>(context);
    Map<String, dynamic> incident = bloc.state.incidentObj ?? {};

    context.read<AddReportBloc>().add(AddReportSubmitEvent(
          incidentObj: incident,
          imagePath: bloc.state.incidentImage ?? "",
          onAddReportSuccess: (String text) {
            _onAddReportSuccess(context, text);
          },
          onAddReportError: (String text) {
            _onAddReportError(context, text);
          },
        ));

    // NavigatorService.pushNamed(AppRoutes.addReportLocationScreen, arguments: {
    //   "incidentObj": incident,
    // });
  }

  onTapArrowleft5(BuildContext context) {
    NavigatorService.goBack();
  }

  void _onAddReportSuccess(BuildContext context, String text) {
    // close virtual keyboard if open
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );
    // Delay the below operation by 1 second
    Future.delayed(Duration(seconds: 1), () {
      NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeContainerScreen,
          arguments: {
            NavigationArgs.mobile: PrefUtils().getMobile(),
            NavigationArgs.fullname: PrefUtils().getName(),
          });
    });
  }

  void _onAddReportError(BuildContext context, String text) {
    // close virtual keyboard if open
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
