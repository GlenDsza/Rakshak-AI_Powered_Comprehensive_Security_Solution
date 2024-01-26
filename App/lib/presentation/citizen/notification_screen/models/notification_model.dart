import 'package:equatable/equatable.dart';
import 'package:rakshak/data/models/notification/notification_model.dart';

// ignore: must_be_immutable
class NotificationModel extends Equatable {
  NotificationModel({this.todayList = const [], this.thisWeekList = const []});

  List<Notification> todayList;

  List<Notification> thisWeekList;

  NotificationModel copyWith(
      {List<Notification>? todayList, List<Notification>? thisWeekList}) {
    return NotificationModel(
      todayList: todayList ?? this.todayList,
      thisWeekList: thisWeekList ?? this.thisWeekList,
    );
  }

  @override
  List<Object?> get props => [todayList, thisWeekList];
}
