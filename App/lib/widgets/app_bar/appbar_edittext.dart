import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class AppbarEdittext extends StatelessWidget {
  AppbarEdittext({this.hintText, this.controller, this.margin});

  String? hintText;

  TextEditingController? controller;

  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CustomTextFormField(
        width: getHorizontalSize(
          271,
        ),
        focusNode: FocusNode(),
        controller: controller,
        hintText: "msg_360_stillwater".tr,
        variant: TextFormFieldVariant.OutlineBluegray40014,
        shape: TextFormFieldShape.CircleBorder24,
        padding: TextFormFieldPadding.PaddingT13,
        fontStyle: TextFormFieldFontStyle.ManropeRegular14Gray900,
        prefix: Container(
          margin: getMargin(
            left: 16,
            top: 12,
            right: 8,
            bottom: 12,
          ),
          child: CustomImageView(
            svgPath: ImageConstant.imgLocation2,
          ),
        ),
        prefixConstraints: BoxConstraints(
          maxHeight: getVerticalSize(
            48,
          ),
        ),
        suffix: Container(
          margin: getMargin(
            left: 30,
            top: 12,
            right: 16,
            bottom: 12,
          ),
          child: CustomImageView(
            svgPath: ImageConstant.imgClose,
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: getVerticalSize(
            48,
          ),
        ),
      ),
    );
  }
}
