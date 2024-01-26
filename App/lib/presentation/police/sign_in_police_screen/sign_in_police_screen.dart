import 'bloc/sign_in_police_bloc.dart';
import 'models/sign_in_police_model.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/widgets/custom_button.dart';
import 'package:rakshak/widgets/custom_text_form_field.dart';

class SignInPoliceScreen extends StatelessWidget {
  static Widget builder(BuildContext context) {
    return BlocProvider<SignInPoliceBloc>(
        create: (context) => SignInPoliceBloc(
            SignInPoliceState(signInPoliceModelObj: SignInPoliceModel()))
          ..add(SignInPoliceInitialEvent()),
        child: SignInPoliceScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray50,
            resizeToAvoidBottomInset: false,
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 24, top: 39, right: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: CustomImageView(
                            imagePath: ImageConstant.imgLogo,
                            height: getVerticalSize(150),
                            width: getHorizontalSize(150),
                            margin: getMargin(bottom: 5)),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text("lbl_police_login".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtManropeExtraBold24Gray900),
                          )),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: getPadding(top: 20),
                              child: Text("msg_sign_in_to_your".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtManrope16.copyWith(
                                      letterSpacing: getHorizontalSize(0.3))))),
                      BlocSelector<SignInPoliceBloc, SignInPoliceState,
                              TextEditingController?>(
                          selector: (state) => state.idController,
                          builder: (context, idController) {
                            return CustomTextFormField(
                                focusNode: FocusNode(),
                                controller: idController,
                                hintText: "lbl_police_id".tr,
                                margin: getMargin(top: 20),
                                textInputType: TextInputType.text);
                          }),
                      BlocBuilder<SignInPoliceBloc, SignInPoliceState>(
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
                                  context.read<SignInPoliceBloc>().add(
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
                          text: "lbl_sign_in".tr,
                          margin: getMargin(top: 20),
                          shape: ButtonShape.RoundedBorder10,
                          padding: ButtonPadding.PaddingAll16,
                          fontStyle: ButtonFontStyle.ManropeBold16Gray50_1,
                          onTap: () {
                            onTapSignin(context);
                          }),
                      Spacer(),
                    ]))));
  }

  onTapSignin(BuildContext context) {
    context.read<SignInPoliceBloc>().add(
          CreateLoginEvent(
            onCreateLoginEventSuccess: () {
              _onCreateLoginEventSuccess(context);
            },
            onCreateLoginEventError: () {
              _onCreateLoginEventError(context);
            },
          ),
        );
  }

  void _onCreateLoginEventSuccess(BuildContext context) {
    // close virtual keyboard if open
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Login Successfull!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );

    Future.delayed(Duration(seconds: 1), () {
      NavigatorService.pushNamedAndRemoveUntil(
          AppRoutes.homeContainerPoliceScreen,
          arguments: {
            NavigationArgs.id:
                context.read<SignInPoliceBloc>().postPoliceLoginResp.data!.id!,
            NavigationArgs.fullname: context
                .read<SignInPoliceBloc>()
                .postPoliceLoginResp
                .data!
                .staff_name!,
            NavigationArgs.station: context
                .read<SignInPoliceBloc>()
                .postPoliceLoginResp
                .data!
                .station_name!
          });
    });
  }

  void _onCreateLoginEventError(BuildContext context) {
    // close virtual keyboard if open
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Invalid credentials!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
