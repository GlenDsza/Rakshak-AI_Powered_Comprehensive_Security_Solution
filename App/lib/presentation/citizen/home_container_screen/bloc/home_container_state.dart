// ignore_for_file: must_be_immutable

part of 'home_container_bloc.dart';

class HomeContainerState extends Equatable {
  HomeContainerState({
    this.mobile,
    this.fullname,
    this.homeContainerModelObj,
  });

  HomeContainerModel? homeContainerModelObj;

  var mobile;
  var fullname;

  @override
  List<Object?> get props => [
        mobile,
        fullname,
        homeContainerModelObj,
      ];
  HomeContainerState copyWith({
    var mobile,
    var fullname,
    HomeContainerModel? homeContainerModelObj,
  }) {
    return HomeContainerState(
      mobile: mobile ?? this.mobile,
      fullname: fullname ?? this.fullname,
      homeContainerModelObj:
          homeContainerModelObj ?? this.homeContainerModelObj,
    );
  }
}
