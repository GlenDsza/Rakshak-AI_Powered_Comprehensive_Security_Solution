// ignore_for_file: must_be_immutable

part of 'dashboard_police_bloc.dart';

@immutable
abstract class DashboardPoliceEvent extends Equatable {}

class DashboardPoliceInitialEvent extends DashboardPoliceEvent {
  @override
  List<Object?> get props => [];
}

class DashboardPoliceTooltipEvent extends DashboardPoliceEvent {
  DashboardPoliceTooltipEvent({required this.value});
  int value;
  @override
  List<Object?> get props => [
        value,
      ];
}
