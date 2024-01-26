import 'package:rakshak/presentation/citizen/sign_up_screen/bloc/sign_up_bloc.dart';
import 'package:rakshak/presentation/citizen/sign_up_screen/models/sign_up_model.dart';

import 'bloc/verify_phone_number_bloc.dart';
import 'models/verify_phone_number_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/widgets/custom_button.dart';
import 'package:rakshak/widgets/custom_icon_button.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  static Widget builder(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) => VerifyPhoneNumberBloc(VerifyPhoneNumberState(
              verifyPhoneNumberModelObj: VerifyPhoneNumberModel()))
            ..add(VerifyPhoneNumberInitialEvent())),
      BlocProvider(
          create: (_) => SignUpBloc(SignUpState(signUpModelObj: SignUpModel())))
    ], child: VerifyPhoneNumberScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray50,
            resizeToAvoidBottomInset: false,
            body: BlocListener<VerifyPhoneNumberBloc, VerifyPhoneNumberState>(
              listener: (context, state) {
                if (state is VerifyPhoneNumberSuccess) {
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Account created Successfully!",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Future.delayed(Duration(seconds: 1), () {
                    NavigatorService.pushNamedAndRemoveUntil(
                        AppRoutes.signInScreen);
                  });
                }
              },
              child: Container(
                  width: double.maxFinite,
                  padding: getPadding(left: 23, top: 8, right: 23, bottom: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomIconButton(
                            height: 40,
                            width: 40,
                            margin: getMargin(left: 1),
                            onTap: () {
                              onTapBtnArrowleft(context);
                            },
                            child: CustomImageView(
                                svgPath: ImageConstant.imgArrowleft)),
                        Padding(
                            padding: getPadding(left: 1, top: 34),
                            child: Text("msg_verify_phone_nu".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtManropeExtraBold24Gray900)),
                        Container(
                            width: getHorizontalSize(299),
                            margin: getMargin(left: 1, top: 7, right: 28),
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "msg_we_send_a_code2".tr,
                                      style: TextStyle(
                                          color: ColorConstant.blueGray500,
                                          fontSize: getFontSize(14),
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(
                                      // get mobile from shredprefs and add it in text

                                      text:
                                          PrefUtils().getMobile().substring(6) +
                                              "msg_783_enter".tr,
                                      style: TextStyle(
                                          color: ColorConstant.gray900,
                                          fontSize: getFontSize(14),
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.w600))
                                ]),
                                textAlign: TextAlign.left)),
                        Padding(
                            padding: getPadding(left: 1, top: 47),
                            child: BlocSelector<
                                    VerifyPhoneNumberBloc,
                                    VerifyPhoneNumberState,
                                    TextEditingController?>(
                                selector: (state) => state.otpController,
                                builder: (context, otpController) {
                                  return PinCodeTextField(
                                      appContext: context,
                                      controller: otpController,
                                      length: 6,
                                      obscureText: false,
                                      obscuringCharacter: '*',
                                      keyboardType: TextInputType.number,
                                      autoDismissKeyboard: true,
                                      enableActiveFill: true,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (value) {
                                        otpController?.text = value;
                                      },
                                      textStyle: TextStyle(
                                          color: ColorConstant.gray900,
                                          fontSize: getFontSize(20),
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.w800),
                                      pinTheme: PinTheme(
                                          fieldHeight: getHorizontalSize(46),
                                          fieldWidth: getHorizontalSize(46),
                                          shape: PinCodeFieldShape.box,
                                          borderRadius: BorderRadius.circular(
                                              getHorizontalSize(12)),
                                          selectedFillColor:
                                              ColorConstant.blueGray50,
                                          activeFillColor:
                                              ColorConstant.blueGray50,
                                          inactiveFillColor:
                                              ColorConstant.blueGray50,
                                          inactiveColor: ColorConstant.fromHex(
                                              "#1212121D"),
                                          selectedColor: ColorConstant.fromHex(
                                              "#1212121D"),
                                          activeColor: ColorConstant.fromHex(
                                              "#1212121D")));
                                })),
                        Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: getPadding(top: 33),
                                child: Text("lbl_resend_code".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtManropeSemiBold16Blue500
                                        .copyWith(
                                            letterSpacing:
                                                getHorizontalSize(0.2))))),
                        CustomButton(
                            height: getVerticalSize(56),
                            text: "lbl_confirm".tr,
                            margin: getMargin(left: 1, top: 50, bottom: 5),
                            shape: ButtonShape.RoundedBorder10,
                            padding: ButtonPadding.PaddingAll16,
                            fontStyle: ButtonFontStyle.ManropeBold16WhiteA700_1,
                            onTap: () {
                              onTapConfirm(context);
                            })
                      ])),
            )));
  }

  onTapBtnArrowleft(BuildContext context) {
    NavigatorService.goBack();
  }

  onTapConfirm(BuildContext context) {
    final bloc = BlocProvider.of<VerifyPhoneNumberBloc>(context);

    bloc.add(VerifyOTPEvent(
        enteredOTP: bloc.state.otpController?.text ?? '', password: "-"));
  }
}
