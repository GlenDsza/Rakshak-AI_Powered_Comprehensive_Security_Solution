// ignore_for_file: must_be_immutable

part of 'home_container_police_bloc.dart';

class HomeContainerPoliceState extends Equatable {
  HomeContainerPoliceState({
    this.id,
    this.fullname,
    this.station,
    this.homeContainerPoliceModelObj,
  });

  HomeContainerPoliceModel? homeContainerPoliceModelObj;

  String? id;
  String? fullname;
  String? station;

  @override
  List<Object?> get props => [
        id,
        fullname,
        station,
        homeContainerPoliceModelObj,
      ];
  HomeContainerPoliceState copyWith({
    String? id,
    String? fullname,
    String? station,
    HomeContainerPoliceModel? homeContainerPoliceModelObj,
  }) {
    return HomeContainerPoliceState(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      station: station ?? this.station,
      homeContainerPoliceModelObj:
          homeContainerPoliceModelObj ?? this.homeContainerPoliceModelObj,
    );
  }
}
