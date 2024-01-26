// ignore_for_file: must_be_immutable

part of 'home_container_bloc.dart';

@immutable
abstract class HomeContainerEvent extends Equatable {}

class HomeContainerInitialEvent extends HomeContainerEvent {
  @override
  List<Object?> get props => [];
}
