import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {this.shape,
      this.padding,
      this.variant,
      this.alignment,
      this.margin,
      this.width,
      this.height,
      this.child,
      this.onTap});

  IconButtonShape? shape;

  IconButtonPadding? padding;

  IconButtonVariant? variant;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  double? width;

  double? height;

  Widget? child;

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildIconButtonWidget(),
          )
        : _buildIconButtonWidget();
  }

  _buildIconButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: IconButton(
        visualDensity: VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
        iconSize: getSize(height ?? 0),
        padding: EdgeInsets.all(0),
        icon: Container(
          alignment: Alignment.center,
          width: getSize(width ?? 0),
          height: getSize(height ?? 0),
          padding: _setPadding(),
          decoration: _buildDecoration(),
          child: child,
        ),
        onPressed: onTap,
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      border: _setBorder(),
      borderRadius: _setBorderRadius(),
      boxShadow: _setBoxShadow(),
    );
  }

  _setPadding() {
    switch (padding) {
      case IconButtonPadding.PaddingAll12:
        return getPadding(
          all: 12,
        );
      case IconButtonPadding.PaddingAll5:
        return getPadding(
          all: 5,
        );
      default:
        return getPadding(
          all: 8,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case IconButtonVariant.OutlineBluegray50:
        return ColorConstant.whiteA700;
      case IconButtonVariant.OutlineBluegray50_1:
        return ColorConstant.gray50;
      case IconButtonVariant.FillBluegray50:
        return ColorConstant.blueGray50;
      case IconButtonVariant.FillGray900:
        return ColorConstant.gray900;
      case IconButtonVariant.OutlineGray300_1:
        return ColorConstant.gray5002;
      case IconButtonVariant.OutlineGray5066:
        return ColorConstant.whiteA700;
      case IconButtonVariant.FillBlue500:
        return ColorConstant.blue500;
      case IconButtonVariant.OutlineBluegray40014:
        return ColorConstant.whiteA700;
      case IconButtonVariant.FillGray50:
        return ColorConstant.gray50;
      case IconButtonVariant.OutlineBluegray50_2:
        return ColorConstant.blue500;
      case IconButtonVariant.OutlineGray50:
        return ColorConstant.blue500;
      default:
        return ColorConstant.whiteA700;
    }
  }

  _setBorder() {
    switch (variant) {
      case IconButtonVariant.OutlineBluegray50:
        return Border.all(
          color: ColorConstant.blueGray50,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case IconButtonVariant.OutlineBluegray50_1:
        return Border.all(
          color: ColorConstant.blueGray50,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case IconButtonVariant.OutlineGray300_1:
        return Border.all(
          color: ColorConstant.gray300,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case IconButtonVariant.OutlineGray5066:
        return Border.all(
          color: ColorConstant.gray5066,
          width: getHorizontalSize(
            4.00,
          ),
        );
      case IconButtonVariant.OutlineBluegray50_2:
        return Border.all(
          color: ColorConstant.blueGray50,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case IconButtonVariant.OutlineGray50:
        return Border.all(
          color: ColorConstant.gray50,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case IconButtonVariant.FillBluegray50:
      case IconButtonVariant.FillGray900:
      case IconButtonVariant.FillBlue500:
      case IconButtonVariant.OutlineBluegray40014:
      case IconButtonVariant.FillGray50:
        return null;
      default:
        return Border.all(
          color: ColorConstant.gray300,
          width: getHorizontalSize(
            1.00,
          ),
        );
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case IconButtonShape.RoundedBorder10:
        return BorderRadius.circular(
          getHorizontalSize(
            10.00,
          ),
        );
      case IconButtonShape.RoundedBorder5:
        return BorderRadius.circular(
          getHorizontalSize(
            5.00,
          ),
        );
      case IconButtonShape.CircleBorder24:
        return BorderRadius.circular(
          getHorizontalSize(
            24.00,
          ),
        );
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            20.00,
          ),
        );
    }
  }

  _setBoxShadow() {
    switch (variant) {
      case IconButtonVariant.OutlineBluegray40014:
        return [
          BoxShadow(
            color: ColorConstant.blueGray40014,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              0,
              4,
            ),
          ),
        ];
      case IconButtonVariant.OutlineGray300:
      case IconButtonVariant.OutlineBluegray50:
      case IconButtonVariant.OutlineBluegray50_1:
      case IconButtonVariant.FillBluegray50:
      case IconButtonVariant.FillGray900:
      case IconButtonVariant.OutlineGray300_1:
      case IconButtonVariant.OutlineGray5066:
      case IconButtonVariant.FillBlue500:
      case IconButtonVariant.FillGray50:
      case IconButtonVariant.OutlineBluegray50_2:
      case IconButtonVariant.OutlineGray50:
        return null;
      default:
        return null;
    }
  }
}

enum IconButtonShape {
  CircleBorder20,
  RoundedBorder10,
  RoundedBorder5,
  CircleBorder24,
}

enum IconButtonPadding {
  PaddingAll8,
  PaddingAll12,
  PaddingAll5,
}

enum IconButtonVariant {
  OutlineGray300,
  OutlineBluegray50,
  OutlineBluegray50_1,
  FillBluegray50,
  FillGray900,
  OutlineGray300_1,
  OutlineGray5066,
  FillBlue500,
  OutlineBluegray40014,
  FillGray50,
  OutlineBluegray50_2,
  OutlineGray50,
}
