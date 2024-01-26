class Notification {
  String? id;
  String? title;
  String? description;
  String? type;
  String? station_name;
  String? user_id;
  String? created_at;
  String? image;

  Notification({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.station_name,
    required this.user_id,
    required this.created_at,
    required this.image,
  });

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    station_name = json['station_name'];
    user_id = json['user_id'];
    created_at = json['created_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.title != null) {
      data['title'] = this.title;
    }
    if (this.description != null) {
      data['description'] = this.description;
    }
    if (this.type != null) {
      data['type'] = this.type;
    }
    if (this.station_name != null && this.station_name != "") {
      data['station_name'] = this.station_name;
    } else {
      data['station_name'] = "-";
    }
    if (this.user_id != null) {
      data['user_id'] = this.user_id;
    }
    if (this.created_at != null) {
      data['created_at'] = this.created_at;
    }
    if (this.image != null) {
      data['image'] = this.image;
    }
    return data;
  }
}

class GetNotificationResp {
  List<Notification>? dataList;

  GetNotificationResp({this.dataList});

  GetNotificationResp.fromJson(List<dynamic> json) {
    if (json != []) {
      dataList = List<Notification>.from(
        json.map(
          (item) => Notification.fromJson(item),
        ),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.dataList != null) {
      data['data'] = this.dataList!.map((item) => item.toJson()).toList();
    }
    return data;
  }
}
