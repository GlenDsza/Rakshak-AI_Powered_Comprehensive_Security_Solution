import 'package:rakshak/core/app_export.dart';

class GetIncidentResp {
  List<Incident>? dataList;

  GetIncidentResp({this.dataList});

  GetIncidentResp.fromJson(List<dynamic> json) {
    if (json != []) {
      dataList = List<Incident>.from(
        json.map(
          (item) => Incident.fromJson(item),
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

class Incident {
  String? id;
  String? image;
  String? title;
  String? description;
  String? type;
  String? station_name;
  String? location;
  String? source;
  String? status;
  String? lat;
  String? long;
  String? created_at;

  Incident({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.type,
    required this.station_name,
    required this.location,
    required this.source,
    required this.status,
    required this.lat,
    required this.long,
    required this.created_at,
  });

  Incident.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    station_name = json['station_name'];
    location = json['location'];
    source = json['source'];
    status = json['status'];
    lat = json['lat'];
    long = json['long'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.image != null) {
      data['image'] = this.image;
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
    if (this.station_name != null) {
      data['station_name'] = this.station_name;
    }
    if (this.location != null) {
      data['location'] = this.location;
    }
    if (this.source != null) {
      data['source'] = this.source;
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    if (this.lat != null) {
      data['lat'] = this.lat;
    }
    if (this.long != null) {
      data['long'] = this.long;
    }
    if (this.created_at != null) {
      data['created_at'] = this.created_at;
    }
    return data;
  }
}

int compareIncidentByCreatedAt(Incident a, Incident b) {
  DateTime createdAtA = DateTime.parse(a.created_at ?? "");
  DateTime createdAtB = DateTime.parse(b.created_at ?? "");
  return createdAtB.compareTo(createdAtA);
}

Map<String, List<Incident>> separateIncidentPerDates(
    List<Incident> userReports) {
  Map<String, List<Incident>> incidentsByDate = {};
  String todaysDate = DateTime.now().toString();
  for (Incident incident in userReports) {
    // Extract date from the created_at field
    DateTime dateTime = DateTime.parse(incident.created_at ?? todaysDate);
    String date =
        "${dateTime.day.toString().padLeft(2, '0')} ${getMonthAbbreviation(dateTime.month)}";

    // String date = (incident.created_at ?? todaysDate).substring(8, 10) +
    //     '/' +
    //     (incident.created_at ?? todaysDate).substring(5, 7);

    DateTime currentDate = DateTime.now();
    DateTime incidentDate = DateTime.parse(incident.created_at ?? todaysDate);

    if (currentDate.difference(incidentDate).inDays < 6) {
      // Add the incident to the corresponding date category
      incidentsByDate.putIfAbsent(date, () => []);
      incidentsByDate[date]!.add(incident);
    }
  }
  return incidentsByDate;
}
