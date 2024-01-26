import 'bloc/profile_bloc.dart';
import 'models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/widgets/custom_switch.dart';
import 'package:rakshak/widgets/app_bar/appbar_subtitle.dart';
import 'package:rakshak/widgets/app_bar/custom_app_bar.dart';
import 'package:rakshak/widgets/custom_button.dart';
import 'package:rakshak/widgets/custom_icon_button.dart';

class ProfilePage extends StatelessWidget {
  static Widget builder(BuildContext context) {
    return BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc(ProfileState(
            profileModelObj: ProfileModel(),
            isSelectedNotification: PrefUtils().getNotificationStatus()))
          ..add(ProfileInitialEvent()),
        child: ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              backgroundColor: ColorConstant.gray50,
              appBar: CustomAppBar(
                  height: getVerticalSize(48),
                  centerTitle: true,
                  title: AppbarSubtitle(
                    text: "lbl_profile".tr,
                    margin: EdgeInsets.only(top: 16),
                  )),
              body: Container(
                  width: double.maxFinite,
                  padding: getPadding(left: 24, top: 32, right: 24, bottom: 32),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: getSize(70),
                            width: getSize(70),
                            child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CustomImageView(
                                      imagePath: ImageConstant.imgUserSample,
                                      height: getSize(80),
                                      width: getSize(80),
                                      radius: BorderRadius.circular(
                                          getHorizontalSize(35)),
                                      alignment: Alignment.center),
                                  CustomIconButton(
                                      height: 24,
                                      width: 24,
                                      variant:
                                          IconButtonVariant.OutlineBluegray50_2,
                                      shape: IconButtonShape.RoundedBorder10,
                                      padding: IconButtonPadding.PaddingAll5,
                                      alignment: Alignment.bottomRight,
                                      onTap: () {
                                        onTapBtnEdit(context);
                                      },
                                      child: CustomImageView(
                                          svgPath: ImageConstant.imgEdit12x12))
                                ])),
                        Padding(
                            padding: getPadding(top: 8),
                            child: Text(PrefUtils().getName(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtManropeBold18.copyWith(
                                    letterSpacing: getHorizontalSize(0.2)))),
                        Padding(
                            padding: getPadding(top: 4),
                            child: Text(PrefUtils().getMobile(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtManropeMedium14Bluegray500)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: getPadding(top: 31),
                                    child: Text("lbl_settings".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtManropeExtraBold14Bluegray500
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.2))))),
                            Padding(
                                padding: getPadding(top: 16),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomIconButton(
                                          height: 40,
                                          width: 40,
                                          variant:
                                              IconButtonVariant.FillBluegray50,
                                          shape:
                                              IconButtonShape.RoundedBorder10,
                                          padding:
                                              IconButtonPadding.PaddingAll12,
                                          child: CustomImageView(
                                              color: ColorConstant.blue500,
                                              svgPath: ImageConstant
                                                  .imgNotificationNone)),
                                      Padding(
                                          padding: getPadding(
                                              left: 16, top: 12, bottom: 7),
                                          child: Text("lbl_notification".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtManropeSemiBold14Gray900)),
                                      Spacer(),
                                      BlocSelector<ProfileBloc, ProfileState,
                                              bool?>(
                                          selector: (state) =>
                                              state.isSelectedNotification,
                                          builder: (context,
                                              isSelectedNotification) {
                                            return CustomSwitch(
                                                value: isSelectedNotification,
                                                onChanged: (value) {
                                                  context.read<ProfileBloc>().add(
                                                      ChangeNotificationSwitchEvent(
                                                          value: value));
                                                });
                                          })
                                    ])),
                            Padding(
                                padding: getPadding(top: 16),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomIconButton(
                                          height: 40,
                                          width: 40,
                                          variant:
                                              IconButtonVariant.FillBluegray50,
                                          shape:
                                              IconButtonShape.RoundedBorder10,
                                          padding:
                                              IconButtonPadding.PaddingAll12,
                                          child: CustomImageView(
                                              color: ColorConstant.blue500,
                                              svgPath:
                                                  ImageConstant.imgDarkMode)),
                                      Padding(
                                          padding: getPadding(
                                              left: 16, top: 12, bottom: 7),
                                          child: Text("lbl_dark_mode".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtManropeSemiBold14Gray900)),
                                      Spacer(),
                                      BlocSelector<ProfileBloc, ProfileState,
                                              bool?>(
                                          selector: (state) =>
                                              state.isSelectedDark,
                                          builder: (context, isSelectedDark) {
                                            return CustomSwitch(
                                                value: isSelectedDark,
                                                onChanged: (value) {
                                                  context
                                                      .read<ProfileBloc>()
                                                      .add(
                                                          ChangeDarkSwitchEvent(
                                                              value: value));
                                                });
                                          })
                                    ])),
                            Padding(
                                padding: getPadding(top: 16),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomIconButton(
                                          height: 40,
                                          width: 40,
                                          variant:
                                              IconButtonVariant.FillBluegray50,
                                          shape:
                                              IconButtonShape.RoundedBorder10,
                                          padding:
                                              IconButtonPadding.PaddingAll12,
                                          child: CustomImageView(
                                              color: ColorConstant.blue500,
                                              svgPath:
                                                  ImageConstant.imgLanguage)),
                                      Padding(
                                          padding: getPadding(
                                              left: 16, top: 10, bottom: 9),
                                          child: Text("lbl_language".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtManropeSemiBold14Gray900)),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () => NavigatorService.pushNamed(
                                          AppRoutes.changeLanguageScreen,
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                                padding: getPadding(
                                                    top: 2, bottom: 1),
                                                child: Text(
                                                    PrefUtils().getLanguage() ==
                                                            "hi"
                                                        ? "lbl_hindi".tr
                                                        : "lbl_english".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtManropeSemiBold14)),
                                            CustomImageView(
                                                svgPath: ImageConstant
                                                    .imgArrowrightBlueGray500,
                                                height: getSize(20),
                                                width: getSize(20),
                                                margin: getMargin(
                                                    left: 4, bottom: 3))
                                          ],
                                        ),
                                      ),
                                    ])),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: getPadding(top: 32),
                                    child: Text("lbl_support".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtManropeExtraBold14Bluegray500
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.2))))),
                            Padding(
                                padding: getPadding(top: 16),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomIconButton(
                                          height: 40,
                                          width: 40,
                                          variant:
                                              IconButtonVariant.FillBluegray50,
                                          shape:
                                              IconButtonShape.RoundedBorder10,
                                          padding:
                                              IconButtonPadding.PaddingAll12,
                                          child: CustomImageView(
                                              color: ColorConstant.blue500,
                                              svgPath: ImageConstant.imgAbout)),
                                      Padding(
                                          padding: getPadding(
                                              left: 16, top: 12, bottom: 7),
                                          child: Text("lbl_about".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtManropeSemiBold14Gray900)),
                                      Spacer(),
                                      CustomImageView(
                                          svgPath: ImageConstant
                                              .imgArrowrightBlueGray500,
                                          height: getSize(20),
                                          width: getSize(20),
                                          margin:
                                              getMargin(top: 10, bottom: 10))
                                    ])),
                            GestureDetector(
                                onTap: () {
                                  onTapFaqs(context);
                                },
                                child: Padding(
                                    padding: getPadding(top: 16, bottom: 5),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomIconButton(
                                              height: 40,
                                              width: 40,
                                              variant: IconButtonVariant
                                                  .FillBluegray50,
                                              shape: IconButtonShape
                                                  .RoundedBorder10,
                                              padding: IconButtonPadding
                                                  .PaddingAll12,
                                              child: CustomImageView(
                                                  color: ColorConstant.blue500,
                                                  svgPath:
                                                      ImageConstant.imgMenu1)),
                                          Padding(
                                              padding: getPadding(
                                                  left: 16, top: 12, bottom: 7),
                                              child: Text("lbl_faqs".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtManropeSemiBold14Gray900)),
                                          Spacer(),
                                          CustomImageView(
                                              svgPath: ImageConstant
                                                  .imgArrowrightBlueGray500,
                                              height: getSize(20),
                                              width: getSize(20),
                                              margin: getMargin(
                                                  top: 10, bottom: 10))
                                        ])))
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: CustomButton(
                              height: getVerticalSize(50),
                              width: getHorizontalSize(327),
                              text: "lbl_logout".tr,
                              suffixWidget: Container(
                                  margin: getMargin(left: 10),
                                  child: Icon(
                                    Icons.logout,
                                    color: ColorConstant.blue500,
                                    size: 16,
                                  )),
                              shape: ButtonShape.RoundedBorder10,
                              padding: ButtonPadding.PaddingAll12,
                              variant: ButtonVariant.OutlineBlue500_1,
                              fontStyle: ButtonFontStyle.ManropeBold14Blue500_1,
                              onTap: () async {
                                BackgroundService.stopBackground();
                                PrefUtils().clearPreferencesData();
                                await NavigatorService.pushNamedAndRemoveUntil(
                                    AppRoutes.setRoleScreen);
                              }),
                        )
                      ]))));
    });
  }

  onTapBtnEdit(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.editProfileScreen,
    );
  }

  onTapFaqs(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.faqsGetHelpScreen,
    );
  }
}
