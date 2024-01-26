import 'bloc/change_language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/widgets/custom_radio_button.dart';
import 'package:rakshak/widgets/app_bar/appbar_subtitle.dart';
import 'package:rakshak/widgets/app_bar/custom_app_bar.dart';
import 'package:rakshak/widgets/app_bar/appbar_iconbutton_1.dart';
import 'package:rakshak/widgets/custom_button.dart';

class ChangeLanguageScreen extends StatelessWidget {
  static Widget builder(BuildContext context) {
    return BlocProvider<ChangeLanguageBloc>(
      create: (context) {
        return ChangeLanguageBloc(ChangeLanguageState())
          ..add(ChangeLanguageInitialEvent(value: PrefUtils().getLanguage()));
      },
      child: ChangeLanguageScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray50,
            appBar: CustomAppBar(
                height: getVerticalSize(48),
                leadingWidth: 64,
                leading: AppbarIconbutton1(
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 24, top: 16),
                    onTap: () {
                      onTapBack(context);
                    }),
                centerTitle: true,
                title: AppbarSubtitle(
                  text: "lbl_select_language".tr,
                  margin: EdgeInsets.only(top: 16),
                )),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 24, top: 16, right: 24, bottom: 32),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: getPadding(left: 8, top: 18),
                          child: BlocSelector<ChangeLanguageBloc,
                                  ChangeLanguageState, String?>(
                              selector: (state) => state.radioGroup,
                              builder: (context, radioGroup) {
                                return Column(
                                  children: [
                                    CustomRadioButton(
                                        text: "lbl_english".tr,
                                        value: "lbl_english".tr,
                                        groupValue: radioGroup,
                                        margin: getMargin(left: 8, top: 18),
                                        fontStyle: RadioFontStyle
                                            .ManropeMedium14Gray900,
                                        onChange: (value) {
                                          context
                                              .read<ChangeLanguageBloc>()
                                              .add(ChangeRadioButtonEvent(
                                                  value: value));
                                        }),
                                    CustomRadioButton(
                                        text: "lbl_hindi".tr,
                                        value: "lbl_hindi".tr,
                                        groupValue: radioGroup,
                                        margin: getMargin(left: 8, top: 18),
                                        fontStyle: RadioFontStyle
                                            .ManropeMedium14Gray900,
                                        onChange: (value) {
                                          context
                                              .read<ChangeLanguageBloc>()
                                              .add(ChangeRadioButtonEvent(
                                                  value: value));
                                        }),
                                    // Spacer(),
                                    Padding(
                                      padding: getPadding(top: 32),
                                      child: CustomButton(
                                          height: getVerticalSize(56),
                                          text: "lbl_submit".tr,
                                          shape: ButtonShape.RoundedBorder10,
                                          padding: ButtonPadding.PaddingAll16,
                                          fontStyle: ButtonFontStyle
                                              .ManropeBold16WhiteA700_1,
                                          onTap: () {
                                            onTapSubmit(radioGroup, context);
                                          }),
                                    )
                                  ],
                                );
                              })),
                    ]))));
  }

  onTapSubmit(String? language, BuildContext context) {
    context.read<ChangeLanguageBloc>().add(
        LanguageSubmitEvent(value: language ?? 'English', context: context));
  }

  onTapBack(BuildContext context) {
    NavigatorService.goBack();
  }
}
