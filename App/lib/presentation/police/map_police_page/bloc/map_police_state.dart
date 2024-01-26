// ignore_for_file: must_be_immutable

part of 'map_police_bloc.dart';

class MapPoliceState extends Equatable {
  MapPoliceState({
    this.mapPoliceModelObj,
    this.plotType = "Surveillance",
    this.incidentsList = const [],
    this.policeMarkerIcon,
    this.objIcon,
    required this.cctvList,
  });

  MapPoliceModel? mapPoliceModelObj;
  String? plotType = "Surveillance";
  List<Cctv> cctvList = cctvConstants;
  List<Incident> incidentsList = [];
  BitmapDescriptor? policeMarkerIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
  BitmapDescriptor? objIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);

  @override
  List<Object?> get props => [
        cctvList,
        mapPoliceModelObj,
        plotType,
        incidentsList,
        policeMarkerIcon,
        objIcon,
      ];

  MapPoliceState copyWith({
    MapPoliceModel? mapPoliceModelObj,
    String? plotType,
    List<Cctv>? cctvList,
    List<Incident>? incidentsList,
    BitmapDescriptor? policeMarkerIcon,
    BitmapDescriptor? objIcon,
  }) {
    return MapPoliceState(
      mapPoliceModelObj: mapPoliceModelObj ?? this.mapPoliceModelObj,
      plotType: plotType ?? this.plotType,
      cctvList: cctvList ?? this.cctvList,
      incidentsList: incidentsList ?? this.incidentsList,
      policeMarkerIcon: policeMarkerIcon ?? this.policeMarkerIcon,
      objIcon: objIcon ?? this.objIcon,
    );
  }
}
