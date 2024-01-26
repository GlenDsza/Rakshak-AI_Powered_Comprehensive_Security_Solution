class PostRegisterResp {
  Data? data;

  PostRegisterResp({this.data});

  PostRegisterResp.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data.addAll(this.data!.toJson());
    }
    return data;
  }
}

class Data {
  String? fullname;
  String? mobile;
  bool? is_verified;
  bool? active;

  Data({
    this.fullname,
    this.mobile,
    this.is_verified,
    this.active,
  });

  Data.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    mobile = json['mobile'];
    is_verified = json['is_verified'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.fullname != null) {
      data['fullname'] = this.fullname;
    }
    if (this.mobile != null) {
      data['mobile'] = this.mobile;
    }
    if (this.is_verified != null) {
      data['is_verified'] = this.is_verified;
    }
    if (this.active != null) {
      data['active'] = this.active;
    }
    return data;
  }
}
