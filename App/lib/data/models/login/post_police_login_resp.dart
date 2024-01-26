class PostPoliceLoginResp {
  Data? data;

  PostPoliceLoginResp({this.data});

  PostPoliceLoginResp.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  String? phone;
  String? photo;
  String? staff_name;
  String? status;
  String? id;
  String? station_name;
  String? duty;

  Data({
    this.id,
    this.phone,
    this.photo,
    this.staff_name,
    this.status,
    this.station_name,
    this.duty,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    photo = json['photo'];
    staff_name = json['staff_name'];
    status = json['status'];
    station_name = json['station_name'];
    duty = json['duty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.phone != null) {
      data['phone'] = this.phone;
    }
    if (this.photo != null) {
      data['photo'] = this.photo;
    }
    if (this.staff_name != null) {
      data['staff_name'] = this.staff_name;
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    if (this.station_name != null) {
      data['station_name'] = this.station_name;
    }
    if (this.duty != null) {
      data['duty'] = this.duty;
    }
    return data;
  }
}
