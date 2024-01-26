class PostLoginReq {
  String? mobile;
  String? password;

  PostLoginReq({this.mobile, this.password});

  PostLoginReq.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.mobile != null) {
      data['mobile'] = this.mobile;
    }
    if (this.password != null) {
      data['password'] = this.password;
    }
    return data;
  }
}
