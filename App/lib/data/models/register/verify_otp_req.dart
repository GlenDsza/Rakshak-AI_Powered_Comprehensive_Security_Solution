class VerifyOtpReq {
  String? mobile;
  String? password;
  String? otp;

  VerifyOtpReq({this.mobile, this.password, this.otp});

  VerifyOtpReq.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    password = json['password'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.mobile != null) {
      data['mobile'] = this.mobile;
    }
    if (this.password != null) {
      data['password'] = this.password;
    }
    if (this.otp != null) {
      data['otp'] = this.otp;
    }
    return data;
  }
}
