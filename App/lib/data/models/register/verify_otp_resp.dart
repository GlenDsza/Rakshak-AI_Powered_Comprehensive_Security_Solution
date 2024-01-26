class VerifyOtpResp {
  Data? data;

  VerifyOtpResp({this.data});

  VerifyOtpResp.fromJson(Map<String, dynamic> json) {
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
  String? mobile;
  String? fullname;

  Data({
    this.fullname,
    this.mobile,
  });

  Data.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.fullname != null) {
      data['fullname'] = this.fullname;
    }
    if (this.mobile != null) {
      data['mobile'] = this.mobile;
    }
    return data;
  }
}
