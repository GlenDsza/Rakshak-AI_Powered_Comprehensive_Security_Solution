// ignore_for_file: must_be_immutable

part of 'incident_details_bloc.dart';

@immutable
abstract class IncidentDetailsEvent extends Equatable {}

class IncidentDetailsInitialEvent extends IncidentDetailsEvent {
  @override
  List<Object?> get props => [];
}
