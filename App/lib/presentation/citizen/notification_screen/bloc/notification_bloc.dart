import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/data/repository/repository.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/citizen/notification_screen/models/notification_model.dart';
import 'package:rakshak/data/models/notification/notification_model.dart'
    as notification;
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(NotificationState initialState) : super(initialState) {
    on<NotificationInitialEvent>(_onInitialize);
  }

  var _repository = Repository();
  List<notification.Notification> todayList = [];
  List<notification.Notification> thisWeekList = [];
  var getNotifResp = notification.GetNotificationResp(dataList: []);

  _onInitialize(
    NotificationInitialEvent event,
    Emitter<NotificationState> emit,
  ) async {
    getNotifResp = await _repository.getNotifications(PrefUtils().getMobile());

    var categorizedData = categorizeNotifications(getNotifResp.dataList!);
    emit(state.copyWith(
        notificationModelObj: state.notificationModelObj.copyWith(
            todayList: categorizedData["todayList"],
            thisWeekList: categorizedData["thisWeekList"])));
    // emit(state.copyWith(
    //     notificationModelObj: state.notificationModelObj
    //         .copyWith(todayList: [], thisWeekList: [])));
  }
}
