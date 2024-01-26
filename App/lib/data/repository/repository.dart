import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/data/models/login/post_login_resp.dart';
import 'package:rakshak/data/models/login/post_police_login_resp.dart';
import 'package:rakshak/data/models/me/get_me_resp.dart';
import 'package:rakshak/data/models/register/post_register_resp.dart';
import 'package:rakshak/data/models/register/verify_otp_resp.dart';
import 'package:rakshak/data/models/notification/notification_model.dart';
import 'package:rakshak/data/models/home/get_incident_resp.dart';

import '../apiClient/api_client.dart';

class Repository {
  var _apiClient = ApiClient();

  Future<GetMeResp> fetchMe({Map<String, String> headers = const {}}) async {
    return await _apiClient.fetchMe(
      headers: headers,
    );
  }

  Future<PostLoginResp> createLogin({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.createLogin(
      headers: headers,
      requestData: requestData,
    );
  }

  Future<PostPoliceLoginResp> createPoliceLogin({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.createPoliceLogin(
      headers: headers,
      requestData: requestData,
    );
  }

  Future<PostRegisterResp> createRegister({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.createRegister(
      headers: headers,
      requestData: requestData,
    );
  }

  Future<VerifyOtpResp> verifyOtp({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.verifyOtp(
      headers: headers,
      requestData: requestData,
    );
  }

  Future<GetIncidentResp> getIncident(String mobile) async {
    return await _apiClient.getIncident(mobile);
  }

  Future<GetNotificationResp> getNotifications(String user_id) async {
    if (user_id.isEmpty || user_id == "") {
      await PrefUtils().init();
      user_id = PrefUtils().getMobile();
    }
    return await _apiClient.getNotifications(user_id);
  }

  Future<int> getNotificationCount(String user_id) async {
    if (user_id.isEmpty || user_id == "") {
      await PrefUtils().init();
      user_id = PrefUtils().getMobile();
    }
    return await _apiClient.getNotificationCount(user_id);
  }

  Future<GetNotificationResp> getNotificationsForStaff(
      String duty, String station) async {
    if (duty.isEmpty || duty == "" || station.isEmpty || station == "") {
      await PrefUtils().init();
      duty = PrefUtils().getDuty();
      station = PrefUtils().getStation();
    }
    return await _apiClient.getNotificationsForStaff(duty, station);
  }
}
