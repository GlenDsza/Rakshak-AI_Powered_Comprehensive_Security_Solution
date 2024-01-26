class GetMeResp {
  String? status;
  String? message;
  Data? data;

  GetMeResp({this.status, this.message, this.data});

  GetMeResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.status != null) {
      data['status'] = this.status;
    }
    if (this.message != null) {
      data['message'] = this.message;
    }
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  int? loginRetryLimit;
  String? username;
  String? email;
  String? name;
  String? profile;
  int? role;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  bool? isActive;
  dynamic loginReactiveTime;
  int? userType;
  String? id;

  Data(
      {this.loginRetryLimit,
      this.username,
      this.email,
      this.name,
      this.profile,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.isDeleted,
      this.isActive,
      this.loginReactiveTime,
      this.userType,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    loginRetryLimit = json['loginRetryLimit'];
    username = json['username'];
    email = json['email'];
    name = json['name'];
    profile = json['profile'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    loginReactiveTime = json['loginReactiveTime'];
    userType = json['userType'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.loginRetryLimit != null) {
      data['loginRetryLimit'] = this.loginRetryLimit;
    }
    if (this.username != null) {
      data['username'] = this.username;
    }
    if (this.email != null) {
      data['email'] = this.email;
    }
    if (this.name != null) {
      data['name'] = this.name;
    }
    if (this.profile != null) {
      data['profile'] = this.profile;
    }
    if (this.role != null) {
      data['role'] = this.role;
    }
    if (this.createdAt != null) {
      data['createdAt'] = this.createdAt;
    }
    if (this.updatedAt != null) {
      data['updatedAt'] = this.updatedAt;
    }
    if (this.isDeleted != null) {
      data['isDeleted'] = this.isDeleted;
    }
    if (this.isActive != null) {
      data['isActive'] = this.isActive;
    }
    if (this.loginReactiveTime != null) {
      data['loginReactiveTime'] = this.loginReactiveTime;
    }
    if (this.userType != null) {
      data['userType'] = this.userType;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    return data;
  }
}
