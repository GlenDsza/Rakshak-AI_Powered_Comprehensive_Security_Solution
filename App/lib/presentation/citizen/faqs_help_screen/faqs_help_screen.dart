import '../faqs_help_screen/widgets/questions_item_widget.dart';
import 'bloc/faqs_help_bloc.dart';
import 'models/faqs_help_model.dart';
import 'models/questions_item_model.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/widgets/app_bar/appbar_iconbutton_1.dart';
import 'package:rakshak/widgets/app_bar/appbar_subtitle.dart';
import 'package:rakshak/widgets/app_bar/custom_app_bar.dart';
import 'package:rakshak/widgets/custom_search_view.dart';

class FaqsGetHelpScreen extends StatelessWidget {
  static Widget builder(BuildContext context) {
    return BlocProvider<FaqsHelpBloc>(
        create: (context) =>
            FaqsHelpBloc(FaqsHelpState(faqsHelpModelObj: FaqsHelpModel()))
              ..add(FaqsHelpInitialEvent()),
        child: FaqsGetHelpScreen());
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
                      onTapArrowleft17(context);
                    }),
                centerTitle: true,
                title: AppbarSubtitle(
                  text: "lbl_faqs".tr,
                  margin: EdgeInsets.only(top: 16),
                )),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 24, top: 36, right: 24, bottom: 36),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlocSelector<FaqsHelpBloc, FaqsHelpState,
                              TextEditingController?>(
                          selector: (state) => state.serchController,
                          builder: (context, serchController) {
                            return CustomSearchView(
                                focusNode: FocusNode(),
                                controller: serchController,
                                hintText: "msg_search_question".tr,
                                padding: SearchViewPadding.PaddingT17,
                                prefix: Container(
                                    margin: getMargin(
                                        left: 16,
                                        top: 16,
                                        right: 12,
                                        bottom: 16),
                                    child: CustomImageView(
                                        svgPath: ImageConstant.imgSearch)),
                                prefixConstraints: BoxConstraints(
                                    maxHeight: getVerticalSize(56)),
                                suffix: Padding(
                                    padding: EdgeInsets.only(
                                        right: getHorizontalSize(15)),
                                    child: IconButton(
                                        onPressed: () {
                                          serchController!.clear();
                                        },
                                        icon: Icon(Icons.clear,
                                            color: Colors.grey.shade600))));
                          }),
                      Padding(
                          padding: getPadding(top: 26),
                          child: Text("msg_frequently_aske".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtManropeBold18.copyWith(
                                  letterSpacing: getHorizontalSize(0.2)))),
                      Padding(
                          padding: getPadding(top: 22),
                          child: BlocSelector<FaqsHelpBloc, FaqsHelpState,
                                  FaqsHelpModel?>(
                              selector: (state) => state.faqsHelpModelObj,
                              builder: (context, faqsHelpModelObj) {
                                return Container(
                                  height: getSize(500),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: faqsHelpModelObj
                                              ?.questionsItemList.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        QuestionsItemModel model =
                                            faqsHelpModelObj?.questionsItemList[
                                                    index] ??
                                                QuestionsItemModel();
                                        return QuestionsItemWidget(model,
                                            onSelectedExpandableList: (value) {
                                          context.read<FaqsHelpBloc>().add(
                                              UpdateExpandableListEvent(
                                                  index: index,
                                                  isSelected: value));
                                        });
                                      }),
                                );
                              })),
                    ]))));
  }

  onTapArrowleft17(BuildContext context) {
    NavigatorService.goBack();
  }
}
