import 'bloc/sign_up_bloc.dart';
import 'models/sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/widgets/custom_button.dart';
import 'package:rakshak/widgets/custom_text_form_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:rakshak/domain/googleauth/google_auth_helper.dart';
// import 'package:rakshak/domain/facebookauth/facebook_auth_helper.dart';

class SignUpScreen extends StatelessWidget {
  static Widget builder(BuildContext context) {
    return BlocProvider<SignUpBloc>(
        create: (context) =>
            SignUpBloc(SignUpState(signUpModelObj: SignUpModel()))
              ..add(SignUpInitialEvent()),
        child: SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray50,
            resizeToAvoidBottomInset: false,
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 24, top: 39, right: 24, bottom: 39),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "lbl_create".tr,
                                style: TextStyle(
                                    color: ColorConstant.gray900,
                                    fontSize: getFontSize(24),
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: "lbl_rakshak_account".tr,
                                style: TextStyle(
                                    color: ColorConstant.blue500,
                                    fontSize: getFontSize(24),
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w800))
                          ]),
                          textAlign: TextAlign.left),
                      Padding(
                          padding: getPadding(top: 7),
                          child: Text("msg_create_an_accou".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtManrope16.copyWith(
                                  letterSpacing: getHorizontalSize(0.3)))),
                      BlocSelector<SignUpBloc, SignUpState,
                              TextEditingController?>(
                          selector: (state) => state.fullnameController,
                          builder: (context, fullnameController) {
                            return CustomTextFormField(
                                focusNode: FocusNode(),
                                controller: fullnameController,
                                hintText: "lbl_full_name".tr,
                                margin: getMargin(top: 40));
                          }),
                      BlocSelector<SignUpBloc, SignUpState,
                              TextEditingController?>(
                          selector: (state) => state.phonenumberController,
                          builder: (context, phonenumberController) {
                            return CustomTextFormField(
                                focusNode: FocusNode(),
                                controller: phonenumberController,
                                hintText: "lbl_phone_number".tr,
                                margin: getMargin(top: 16),
                                textInputType: TextInputType.phone);
                          }),
                      BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                        return CustomTextFormField(
                            focusNode: FocusNode(),
                            controller: state.passwordController,
                            hintText: "lbl_password".tr,
                            margin: getMargin(top: 16),
                            padding: TextFormFieldPadding.PaddingT14,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.visiblePassword,
                            suffix: InkWell(
                                onTap: () {
                                  context.read<SignUpBloc>().add(
                                      ChangePasswordVisibilityEvent(
                                          value: !state.isShowPassword));
                                },
                                child: Container(
                                    margin: getMargin(
                                        left: 30,
                                        top: 15,
                                        right: 16,
                                        bottom: 14),
                                    child: CustomImageView(
                                        svgPath: state.isShowPassword
                                            ? ImageConstant.imgEye
                                            : ImageConstant.imgEye))),
                            suffixConstraints:
                                BoxConstraints(maxHeight: getVerticalSize(49)),
                            isObscureText: state.isShowPassword);
                      }),
                      CustomButton(
                          height: getVerticalSize(56),
                          text: "lbl_sign_up".tr,
                          margin: getMargin(top: 24),
                          shape: ButtonShape.RoundedBorder10,
                          padding: ButtonPadding.PaddingAll16,
                          fontStyle: ButtonFontStyle.ManropeBold16Gray50_1,
                          onTap: () {
                            onTapSignup(context);
                          }),
                      // Align(
                      //     alignment: Alignment.center,
                      //     child: Padding(
                      //         padding: getPadding(top: 85),
                      //         child: Text("msg_or_continue_wit".tr,
                      //             overflow: TextOverflow.ellipsis,
                      //             textAlign: TextAlign.left,
                      //             style: AppStyle.txtManrope16.copyWith(
                      //                 letterSpacing: getHorizontalSize(0.3))))),
                      // CustomButton(
                      //     height: getVerticalSize(56),
                      //     text: "lbl_google".tr,
                      //     margin: getMargin(top: 24),
                      //     variant: ButtonVariant.OutlineBluegray500,
                      //     shape: ButtonShape.RoundedBorder10,
                      //     padding: ButtonPadding.PaddingT17,
                      //     fontStyle: ButtonFontStyle.ManropeSemiBold16Gray900,
                      //     prefixWidget: Container(
                      //         margin: getMargin(right: 12),
                      //         child: CustomImageView(
                      //             svgPath: ImageConstant.imgGoogle)),
                      //     onTap: () {
                      //       onTapGoogle(context);
                      //     }),
                      // CustomButton(
                      //     height: getVerticalSize(56),
                      //     text: "lbl_facebook".tr,
                      //     margin: getMargin(top: 12),
                      //     variant: ButtonVariant.OutlineBluegray500,
                      //     shape: ButtonShape.RoundedBorder10,
                      //     padding: ButtonPadding.PaddingT17,
                      //     fontStyle: ButtonFontStyle.ManropeSemiBold16Gray900,
                      //     prefixWidget: Container(
                      //         margin: getMargin(right: 12),
                      //         child: CustomImageView(
                      //             imagePath: ImageConstant.imgFacebook,
                      //             height: getSize(24),
                      //             width: getSize(24))),
                      //     onTap: () {
                      //       onTapFacebook(context);
                      //     }),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: getPadding(top: 27, bottom: 5),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("msg_you_already_hav2".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtManrope16.copyWith(
                                            letterSpacing:
                                                getHorizontalSize(0.3))),
                                    GestureDetector(
                                        onTap: () {
                                          onTapTxtSignup(context);
                                        },
                                        child: Padding(
                                            padding: getPadding(left: 4),
                                            child: Text("lbl_sign_in".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtManropeExtraBold16
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.2)))))
                                  ])))
                    ]))));
  }

  onTapSignup(BuildContext context) {
    context.read<SignUpBloc>().add(
          CreateRegisterEvent(
            onCreateRegisterEventSuccess: () {
              _onCreateRegisterEventSuccess(context);
            },
            onCreateRegisterEventError: () {
              _onCreateRegisterEventError(context);
            },
          ),
        );
  }

  void _onCreateRegisterEventSuccess(BuildContext context) {
    NavigatorService.popAndPushNamed(
      AppRoutes.homeContainerScreen,
    );
  }

  void _onCreateRegisterEventError(BuildContext context) {
    Fluttertoast.showToast(
      msg: "msg_something_went_wro".tr,
    );
  }

  // onTapGoogle(BuildContext context) async {
  //   await GoogleAuthHelper().googleSignInProcess().then((googleUser) {
  //     if (googleUser != null) {
  //       //TODO Actions to be performed after signin
  //     } else {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('user data is empty')));
  //     }
  //   }).catchError((onError) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(onError.toString())));
  //   });
  // }

  // onTapFacebook(BuildContext context) async {
  //   await FacebookAuthHelper().facebookSignInProcess().then((facebookUser) {
  //     //TODO Actions to be performed after signin
  //   }).catchError((onError) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(onError.toString())));
  //   });
  // }

  onTapTxtSignup(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.signInScreen,
    );
  }
}
