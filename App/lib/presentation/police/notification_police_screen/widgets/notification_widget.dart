import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/data/models/home/get_incident_resp.dart';
import 'package:rakshak/widgets/custom_icon_button.dart';
import 'package:rakshak/data/models/notification/notification_model.dart'
    as notification;

// ignore: must_be_immutable
class NotificationWidget extends StatelessWidget {
  NotificationWidget(this.notificationObj);

  notification.Notification notificationObj;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapNotificationRow(context, notificationObj),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconButton(
            height: 44,
            width: 44,
            margin: getMargin(
              bottom: 18,
            ),
            variant: IconButtonVariant.FillBluegray50,
            shape: IconButtonShape.RoundedBorder10,
            padding: IconButtonPadding.PaddingAll12,
            child: CustomImageView(
              svgPath: ImageConstant.imgMenu1,
            ),
          ),
          Padding(
            padding: getPadding(
              top: 1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  addEllipsis(notificationObj.title ?? "title", 24),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtManropeBold14.copyWith(
                    letterSpacing: getHorizontalSize(
                      0.2,
                    ),
                  ),
                ),
                Container(
                  width: getHorizontalSize(
                    210,
                  ),
                  margin: getMargin(
                    top: 4,
                  ),
                  child: Text(
                    addEllipsis(
                        notificationObj.description ?? "description", 100),
                    maxLines: null,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtManrope12.copyWith(
                      letterSpacing: getHorizontalSize(
                        0.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: getPadding(
              top: 3,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  getTimePast(notificationObj.created_at ??
                      "2023-10-07T17:55:02.205998"),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtManrope12.copyWith(
                    letterSpacing: getHorizontalSize(
                      0.4,
                    ),
                  ),
                ),
                Container(
                  height: getSize(
                    8,
                  ),
                  width: getSize(
                    8,
                  ),
                  margin: getMargin(
                    top: 17,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.blue500,
                    borderRadius: BorderRadius.circular(
                      getHorizontalSize(
                        4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

onTapNotificationRow(
    BuildContext context, notification.Notification notification) {
  String id = extractId(notification.description ?? "description");

  var incident = Incident(
    id: "ABCD1234",
    image:
        "https://st3.depositphotos.com/23594922/31822/v/450/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",
    title: "IncidentA0",
    description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
    type: "Crime",
    station_name: "Andheri",
    location: "Chakala street",
    source: "User Report",
    status: "Closed",
    created_at: "2023-12-27T00:21:12.102+00:00",
    lat: "26.923884",
    long: "75.801752",
  );
  if (id != "None") {
    // TODO get incident obj via API
    // TODO mark notification as read via API
    NavigatorService.pushNamed(AppRoutes.incidentDetailsScreen, arguments: {
      "incident": incident,
    });
  }
}
