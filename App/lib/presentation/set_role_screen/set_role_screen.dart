import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';

class SetRoleScreen extends StatelessWidget {
  const SetRoleScreen({Key? key}) : super(key: key);

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
                            padding: const EdgeInsets.symmetric(vertical: 22.0),
                            child: Text("lbl_select_role".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtManropeExtraBold24Gray900),
                          )),
                      ElevatedButton(
                        onPressed: () {
                          onTapCitizen(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: CustomImageView(
                                imagePath: ImageConstant.imgCitizen,
                                height: getVerticalSize(50),
                                width: getHorizontalSize(50),
                                margin: getMargin(bottom: 5),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10), // Adjust as needed
                                child: Text(
                                  'lbl_citizen'.tr,
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white70,
                          minimumSize: Size(double.infinity, 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onTapPolice(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: CustomImageView(
                                imagePath: ImageConstant.imgPolice,
                                height: getVerticalSize(50),
                                width: getHorizontalSize(50),
                                margin: getMargin(bottom: 5),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10), // Adjust as needed
                                child: Text(
                                  'lbl_police'.tr,
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white70,
                          minimumSize: Size(double.infinity, 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ]))));
  }

  onTapCitizen(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.signInScreen,
    );
  }

  onTapPolice(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.signInPoliceScreen,
    );
  }
}
