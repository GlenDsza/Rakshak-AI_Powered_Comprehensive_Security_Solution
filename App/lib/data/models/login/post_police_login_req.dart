class PostPoliceLoginReq {
  String? id;
  String? password;

  PostPoliceLoginReq({this.id, this.password});

  PostPoliceLoginReq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.password != null) {
      data['password'] = this.password;
    }
    return data;
  }
}
