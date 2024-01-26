class PostRegisterReq {
  String? mobile;
  String? password;
  String? fullname;

  PostRegisterReq({this.mobile, this.password, this.fullname});

  PostRegisterReq.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    password = json['password'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.mobile != null) {
      data['mobile'] = this.mobile;
    }
    if (this.password != null) {
      data['password'] = this.password;
    }
    if (this.fullname != null) {
      data['fullname'] = this.fullname;
    }
    return data;
  }
}
