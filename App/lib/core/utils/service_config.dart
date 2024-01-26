import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:rakshak/data/models/notification/notification_model.dart';
import 'package:rakshak/data/repository/repository.dart';
import 'package:rakshak/core/app_export.dart';

class BackgroundService {
  static List<String> notifList = [];
  static var _mobile = PrefUtils().getMobile();
  static var _station = PrefUtils().getStation();
  static var _duty = PrefUtils().getDuty();
  static var getNotifResp = GetNotificationResp(dataList: []);
  static var _repository = Repository();
  static Future<void> initialize() async {
    PrefUtils().init();
    final service = FlutterBackgroundService();
    await service.configure(
        iosConfiguration: IosConfiguration(), // not implemented yet
        androidConfiguration: AndroidConfiguration(
            onStart: onStart,
            isForegroundMode: false,
            autoStart: false,
            autoStartOnBoot: false));
    // await service.startService();
  }

  static Future<void> startBackground() async {
    final service = FlutterBackgroundService();
    var isRunning = await service.isRunning();
    if (!isRunning) {
      notifList = [];
      await PrefUtils().init();
      _mobile = PrefUtils().getMobile();
      _duty = PrefUtils().getDuty();
      _station = PrefUtils().getStation();
      await service.startService();
      FlutterBackgroundService().invoke("setAsBackground");
    }
  }

  static void stopBackground() async {
    final service = FlutterBackgroundService();
    var isRunning = await service.isRunning();
    if (isRunning) {
      service.invoke("stopService");
    }
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });
    await PrefUtils().init();
    await dotenv.load(fileName: ".env");
    _repository = Repository();
    Future.delayed(Duration(seconds: 5), () async {
      if (service is AndroidServiceInstance) {
        try {
          if (PrefUtils().getStation() == "")
            Timer.periodic(const Duration(seconds: 10), (timer) async {
              print("In citizen notif");
              if (_mobile == "") {
                await PrefUtils().init();
                _mobile = PrefUtils().getMobile();
              }
              getNotifResp = await _repository.getNotifications(_mobile);

              if (getNotifResp.dataList!.length > 0) {
                if (PrefUtils().getNotificationList().length == 0) {
                  getNotifResp.dataList!.forEach((element) {
                    notifList.add(element.id!);
                  });
                  await PrefUtils().setNotificationList(notifList);
                  if (notifList.length > 1) {
                    String len = notifList.length.toString();
                    LocalNotifications.showSimpleNotification(
                        title: "$len new notifications",
                        body: "Reported incidents status has been updated",
                        payload: "payload");
                  } else if (notifList.length == 1) {
                    LocalNotifications.showSimpleNotification(
                        title: getNotifResp.dataList!.first.title!,
                        body: getNotifResp.dataList!.first.description!,
                        payload: "payload");
                  }
                } else {
                  if (PrefUtils().getNotificationList().length > 0 &&
                      getNotifResp.dataList!.length > 0 &&
                      PrefUtils().getNotificationList().first !=
                          getNotifResp.dataList!.first.id!) {
                    getNotifResp.dataList!.forEach((element) {
                      notifList.add(element.id!);
                    });
                    await PrefUtils().setNotificationList(notifList);
                    if (getNotifResp.dataList!.length > 1) {
                      String len = getNotifResp.dataList!.length.toString();
                      LocalNotifications.showSimpleNotification(
                          title: "$len new notifications",
                          body: "Reported incidents status has been updated",
                          payload: "payload");
                    } else if (getNotifResp.dataList!.length == 1) {
                      LocalNotifications.showSimpleNotification(
                          title: getNotifResp.dataList!.first.title!,
                          body: getNotifResp.dataList!.first.description!,
                          payload: "payload");
                    }
                  } else {
                    print("No new notifications");
                  }
                }
              } else {
                PrefUtils().setNotificationList([]);
                print("No notifications");
              }
            });
          else
            Timer.periodic(const Duration(seconds: 10), (timer) async {
              print("In police notif");
              if (_duty == "") {
                await PrefUtils().init();
                _duty = PrefUtils().getDuty();
                _station = PrefUtils().getStation();
              }
              getNotifResp =
                  await _repository.getNotificationsForStaff(_duty, _station);

              print(getNotifResp.dataList);

              if (getNotifResp.dataList!.length > 0) {
                if (PrefUtils().getNotificationList().length == 0) {
                  getNotifResp.dataList!.forEach((element) {
                    notifList.add(element.id!);
                  });
                  await PrefUtils().setNotificationList(notifList);
                  if (notifList.length > 1) {
                    String len = notifList.length.toString();
                    LocalNotifications.showSimpleNotification(
                        title: "$len new notifications",
                        body: "$len new incidents detected near $_station",
                        payload: "payload");
                  } else if (notifList.length == 1) {
                    LocalNotifications.showBannerNotification(
                        title: getNotifResp.dataList!.first.title!,
                        body: getNotifResp.dataList!.first.description!,
                        imageUrl: getNotifResp.dataList!.first.image! ??
                            "https://st3.depositphotos.com/23594922/31822/v/450/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",
                        payload: "payload");
                  }
                } else {
                  if (PrefUtils().getNotificationList().length > 0 &&
                      getNotifResp.dataList!.length > 0 &&
                      PrefUtils().getNotificationList().first !=
                          getNotifResp.dataList!.first.id!) {
                    getNotifResp.dataList!.forEach((element) {
                      notifList.add(element.id!);
                    });
                    await PrefUtils().setNotificationList(notifList);
                    if (getNotifResp.dataList!.length > 1) {
                      print("Multiple Notification");
                      String len = getNotifResp.dataList!.length.toString();
                      LocalNotifications.showSimpleNotification(
                          title: "$len new notifications",
                          body: "Reported incidents status has been updated",
                          payload: "payload");
                    } else if (getNotifResp.dataList!.length == 1) {
                      print("1 Notification");
                      LocalNotifications.showBannerNotification(
                          title: getNotifResp.dataList!.first.title!,
                          body: getNotifResp.dataList!.first.description!,
                          imageUrl: getNotifResp.dataList!.first.image! ??
                              "https://st3.depositphotos.com/23594922/31822/v/450/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",
                          payload: "payload");
                    }
                  } else {
                    print("No new notifications");
                  }
                }
              } else {
                PrefUtils().setNotificationList([]);
                print("No notifications");
              }
            });
        } catch (error) {
          print(error);
        }
      }
    });
  }
}
