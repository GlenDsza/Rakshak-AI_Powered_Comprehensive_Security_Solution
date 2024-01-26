// ignore_for_file: must_be_immutable

part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {}

class HomeInitialEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class OnIncidentSearch extends HomeEvent {
  OnIncidentSearch({required this.searchVal});

  String searchVal;

  @override
  List<Object?> get props => [
        searchVal,
      ];
}
