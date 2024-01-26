import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/data/repository/repository.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/police/notification_police_screen/models/notification_police_model.dart';
import 'package:rakshak/data/models/notification/notification_model.dart'
    as notification;
part 'notification_police_event.dart';
part 'notification_police_state.dart';

class NotificationPoliceBloc
    extends Bloc<NotificationPoliceEvent, NotificationPoliceState> {
  NotificationPoliceBloc(NotificationPoliceState initialState)
      : super(initialState) {
    on<NotificationPoliceInitialEvent>(_onInitialize);
  }

  var _repository = Repository();
  List<notification.Notification> todayList = [];
  List<notification.Notification> thisWeekList = [];
  var getNotifResp = notification.GetNotificationResp(dataList: []);

  _onInitialize(
    NotificationPoliceInitialEvent event,
    Emitter<NotificationPoliceState> emit,
  ) async {
    getNotifResp = await _repository.getNotificationsForStaff(
        PrefUtils().getDuty(), PrefUtils().getStation());
    ;

    var categorizedData = categorizeNotifications(getNotifResp.dataList!);
    emit(state.copyWith(
        notificationPoliceModelObj: state.notificationPoliceModelObj.copyWith(
            todayList: categorizedData["todayList"],
            thisWeekList: categorizedData["thisWeekList"])));
    // emit(state.copyWith(
    //     notificationPoliceModelObj: state.notificationPoliceModelObj
    //         .copyWith(todayList: [], thisWeekList: [])));
  }
}
