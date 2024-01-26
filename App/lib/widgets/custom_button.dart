import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.margin,
      this.onTap,
      this.width,
      this.height,
      this.text,
      this.prefixWidget,
      this.suffixWidget});

  ButtonShape? shape;

  ButtonPadding? padding;

  ButtonVariant? variant;

  ButtonFontStyle? fontStyle;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  VoidCallback? onTap;

  double? width;

  double? height;

  String? text;

  Widget? prefixWidget;

  Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildButtonWidget(),
          )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: TextButton(
        onPressed: onTap,
        style: _buildTextButtonStyle(),
        child: _buildButtonWithOrWithoutIcon(),
      ),
    );
  }

  _buildButtonWithOrWithoutIcon() {
    if (prefixWidget != null || suffixWidget != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixWidget ?? SizedBox(),
          Text(
            text ?? "",
            textAlign: TextAlign.center,
            style: _setFontStyle(),
          ),
          suffixWidget ?? SizedBox(),
        ],
      );
    } else {
      return Text(
        text ?? "",
        textAlign: TextAlign.center,
        style: _setFontStyle(),
      );
    }
  }

  _buildTextButtonStyle() {
    return TextButton.styleFrom(
      fixedSize: Size(
        width ?? double.maxFinite,
        height ?? getVerticalSize(40),
      ),
      padding: _setPadding(),
      backgroundColor: _setColor(),
      side: _setTextButtonBorder(),
      shadowColor: _setTextButtonShadowColor(),
      shape: RoundedRectangleBorder(
        borderRadius: _setBorderRadius(),
      ),
    );
  }

  _setPadding() {
    switch (padding) {
      case ButtonPadding.PaddingAll16:
        return getPadding(
          all: 17,
        );
      case ButtonPadding.PaddingAll13:
        return getPadding(
          all: 13,
        );
      case ButtonPadding.PaddingT17:
        return getPadding(
          top: 17,
          right: 17,
          bottom: 17,
        );
      case ButtonPadding.PaddingT7:
        return getPadding(
          top: 8,
          right: 8,
          bottom: 8,
        );
      case ButtonPadding.PaddingAll12:
        return getPadding(
          all: 10,
        );
      case ButtonPadding.PaddingT10:
        return getPadding(
          top: 12,
          right: 12,
          bottom: 12,
        );
      case ButtonPadding.PaddingT9:
        return getPadding(
          left: 10,
          top: 10,
          bottom: 10,
        );
      default:
        return getPadding(
          all: 6,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case ButtonVariant.OutlineBluegray500:
        return ColorConstant.blueGray50;
      case ButtonVariant.FillBlue50:
        return ColorConstant.blue50;
      case ButtonVariant.OutlineBlue500_1:
        return ColorConstant.gray50;
      case ButtonVariant.FillGray900:
        return ColorConstant.gray900;
      case ButtonVariant.OutlineGray300:
        return ColorConstant.whiteA700;
      case ButtonVariant.OutlineBluegray500_1:
        return ColorConstant.gray900;
      case ButtonVariant.OutlineGray300_1:
        return ColorConstant.gray50;
      case ButtonVariant.OutlineBluegray40014:
        return ColorConstant.whiteA700;
      case ButtonVariant.OutlineBlue500_2:
        return ColorConstant.whiteA700;
      case ButtonVariant.FillBluegray50:
        return ColorConstant.blueGray50;
      case ButtonVariant.OutlineBlue500_3:
        return ColorConstant.blueGray50;
      case ButtonVariant.OutlineBlue500:
        return null;
      default:
        return ColorConstant.blue500;
    }
  }

  _setTextButtonBorder() {
    switch (variant) {
      case ButtonVariant.OutlineBluegray500:
        return BorderSide(
          color: ColorConstant.blueGray500,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineBlue500:
        return BorderSide(
          color: ColorConstant.blue500,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineBlue500_1:
        return BorderSide(
          color: ColorConstant.blue500,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineGray300:
        return BorderSide(
          color: ColorConstant.gray300,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineBluegray500_1:
        return BorderSide(
          color: ColorConstant.blueGray500,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineGray300_1:
        return BorderSide(
          color: ColorConstant.gray300,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineBlue500_2:
        return BorderSide(
          color: ColorConstant.blue500,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineBlue500_3:
        return BorderSide(
          color: ColorConstant.blue500,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.FillBlue500:
      case ButtonVariant.FillBlue50:
      case ButtonVariant.FillGray900:
      case ButtonVariant.OutlineBluegray40014:
      case ButtonVariant.FillBluegray50:
        return null;
      default:
        return null;
    }
  }

  _setTextButtonShadowColor() {
    switch (variant) {
      case ButtonVariant.OutlineBluegray40014:
        return ColorConstant.blueGray40014;
      case ButtonVariant.FillBlue500:
      case ButtonVariant.OutlineBluegray500:
      case ButtonVariant.OutlineBlue500:
      case ButtonVariant.FillBlue50:
      case ButtonVariant.OutlineBlue500_1:
      case ButtonVariant.FillGray900:
      case ButtonVariant.OutlineGray300:
      case ButtonVariant.OutlineBluegray500_1:
      case ButtonVariant.OutlineGray300_1:
      case ButtonVariant.OutlineBlue500_2:
      case ButtonVariant.FillBluegray50:
      case ButtonVariant.OutlineBlue500_3:
        return null;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.RoundedBorder10:
        return BorderRadius.circular(
          getHorizontalSize(
            10.00,
          ),
        );
      case ButtonShape.RoundedBorder5:
        return BorderRadius.circular(
          getHorizontalSize(
            5.00,
          ),
        );
      case ButtonShape.CustomBorderTL10:
        return BorderRadius.only(
          topLeft: Radius.circular(
            getHorizontalSize(
              10.00,
            ),
          ),
          topRight: Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ),
          bottomLeft: Radius.circular(
            getHorizontalSize(
              10.00,
            ),
          ),
          bottomRight: Radius.circular(
            getHorizontalSize(
              10.00,
            ),
          ),
        );
      case ButtonShape.CircleBorder13:
        return BorderRadius.circular(
          getHorizontalSize(
            13.00,
          ),
        );
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            16.00,
          ),
        );
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
      case ButtonFontStyle.ManropeBold16WhiteA700_1:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.38,
          ),
        );
      case ButtonFontStyle.ManropeBold16Bluegray50:
        return TextStyle(
          color: ColorConstant.blueGray50,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.38,
          ),
        );
      case ButtonFontStyle.ManropeBold16Gray50_1:
        return TextStyle(
          color: ColorConstant.gray50,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.38,
          ),
        );
      case ButtonFontStyle.ManropeSemiBold16Gray900:
        return TextStyle(
          color: ColorConstant.gray900,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
          height: getVerticalSize(
            1.38,
          ),
        );
      case ButtonFontStyle.ManropeSemiBold14Blue500:
        return TextStyle(
          color: ColorConstant.blue500,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
          height: getVerticalSize(
            1.43,
          ),
        );
      case ButtonFontStyle.ManropeBold14WhiteA700:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.43,
          ),
        );
      case ButtonFontStyle.ManropeMedium14Gray900:
        return TextStyle(
          color: ColorConstant.gray900,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w500,
          height: getVerticalSize(
            1.43,
          ),
        );
      case ButtonFontStyle.ManropeBold14Blue500_1:
        return TextStyle(
          color: ColorConstant.blue500,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.43,
          ),
        );
      case ButtonFontStyle.ManropeSemiBold14WhiteA700_1:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
          height: getVerticalSize(
            1.43,
          ),
        );
      case ButtonFontStyle.ManropeMedium12Gray900:
        return TextStyle(
          color: ColorConstant.gray900,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w500,
          height: getVerticalSize(
            1.42,
          ),
        );
      case ButtonFontStyle.SFProDisplayMedium10Bluegray50:
        return TextStyle(
          color: ColorConstant.blueGray50,
          fontSize: getFontSize(
            10,
          ),
          fontFamily: 'SF Pro Display',
          fontWeight: FontWeight.w500,
          height: getVerticalSize(
            1.20,
          ),
        );
      case ButtonFontStyle.ManropeBold12Gray300_1:
        return TextStyle(
          color: ColorConstant.gray300,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.42,
          ),
        );
      case ButtonFontStyle.ManropeBold12WhiteA700_1:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.42,
          ),
        );
      case ButtonFontStyle.ManropeBold14Gray900_1:
        return TextStyle(
          color: ColorConstant.gray900,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.43,
          ),
        );
      case ButtonFontStyle.ManropeBold16Blue500_1:
        return TextStyle(
          color: ColorConstant.blue500,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.38,
          ),
        );
      case ButtonFontStyle.ManropeSemiBold14Bluegray500_1:
        return TextStyle(
          color: ColorConstant.blueGray500,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
          height: getVerticalSize(
            1.43,
          ),
        );
      case ButtonFontStyle.ManropeExtraBold10Gray900:
        return TextStyle(
          color: ColorConstant.gray900,
          fontSize: getFontSize(
            10,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w800,
          height: getVerticalSize(
            1.40,
          ),
        );
      case ButtonFontStyle.ManropeSemiBold14Gray900_1:
        return TextStyle(
          color: ColorConstant.gray900,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
          height: getVerticalSize(
            1.43,
          ),
        );
      default:
        return TextStyle(
          color: ColorConstant.gray900,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.42,
          ),
        );
    }
  }
}

enum ButtonShape {
  Square,
  RoundedBorder10,
  RoundedBorder5,
  CustomBorderTL10,
  RoundedBorder16,
  CircleBorder13,
}

enum ButtonPadding {
  PaddingAll16,
  PaddingAll13,
  PaddingT17,
  PaddingT7,
  PaddingAll6,
  PaddingAll12,
  PaddingT10,
  PaddingT9,
}

enum ButtonVariant {
  FillBlue500,
  OutlineBluegray500,
  OutlineBlue500,
  FillBlue50,
  OutlineBlue500_1,
  FillGray900,
  OutlineGray300,
  OutlineBluegray500_1,
  OutlineGray300_1,
  OutlineBluegray40014,
  OutlineBlue500_2,
  FillBluegray50,
  OutlineBlue500_3,
}

enum ButtonFontStyle {
  ManropeBold16WhiteA700_1,
  ManropeBold16Bluegray50,
  ManropeBold16Gray50_1,
  ManropeSemiBold16Gray900,
  ManropeSemiBold14Blue500,
  ManropeBold14WhiteA700,
  ManropeMedium14Gray900,
  ManropeBold14Blue500_1,
  ManropeSemiBold14WhiteA700_1,
  ManropeMedium12Gray900,
  SFProDisplayMedium10Bluegray50,
  ManropeBold12Gray900,
  ManropeBold12Gray300_1,
  ManropeBold12WhiteA700_1,
  ManropeBold14Gray900_1,
  ManropeBold16Blue500_1,
  ManropeSemiBold14Bluegray500_1,
  ManropeExtraBold10Gray900,
  ManropeSemiBold14Gray900_1,
}
