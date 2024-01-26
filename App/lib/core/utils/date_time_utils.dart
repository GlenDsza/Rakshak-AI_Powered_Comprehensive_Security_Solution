import 'package:rakshak/data/models/notification/notification_model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:core';

const String DD_MM_YYYY = 'dd/MM/yyyy';

extension DateTimeExtension on DateTime {
  /// Return a string representing [date] formatted according to our locale
  String format([
    String pattern = DD_MM_YYYY,
    String? locale,
  ]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
}

String formatDate(String input) {
  DateTime dateTime = DateTime.parse(input);
  String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);
  return formattedDate;
}

String formatTime(String input) {
  DateTime dateTime = DateTime.parse(input);
  String formattedTime = DateFormat('h:mm a').format(dateTime);
  return formattedTime;
}

Map<String, List<Notification>> categorizeNotifications(
    List<Notification> dataList) {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime sevenDaysAgo = today.subtract(Duration(days: 7));

  List<Notification> todayList = [];
  List<Notification> thisWeekList = [];

  for (var data in dataList) {
    DateTime createdAt =
        DateTime.parse(data.created_at ?? "2023-10-07T17:55:02.205998");

    if (createdAt.isAfter(today)) {
      todayList.add(data);
    } else if (createdAt.isAfter(sevenDaysAgo)) {
      thisWeekList.add(data);
    }
  }

  Map<String, List<Notification>> categorizedData = {
    "todayList": todayList,
    "thisWeekList": thisWeekList,
  };

  return categorizedData;
}

String getTimePast(String inputTime) {
  DateTime now = DateTime.now();
  DateTime pastTime = DateTime.parse(inputTime);

  Duration difference = now.difference(pastTime);

  if (difference.inMinutes < 1) {
    return '1 min';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} mins';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hrs';
  } else {
    return '${difference.inDays} days';
  }
}

String getMonthAbbreviation(int month) {
  // List of month abbreviations
  List<String> monthsAbbreviation = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  // Ensure that the month value is within valid range
  if (month >= 1 && month <= 12) {
    return monthsAbbreviation[month - 1];
  } else {
    throw ArgumentError("Invalid month value");
  }
}
