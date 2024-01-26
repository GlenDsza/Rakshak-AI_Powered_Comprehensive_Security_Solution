// ignore_for_file: must_be_immutable

part of 'home_container_police_bloc.dart';

@immutable
abstract class HomeContainerPoliceEvent extends Equatable {}

class HomeContainerPoliceInitialEvent extends HomeContainerPoliceEvent {
  @override
  List<Object?> get props => [];
}
