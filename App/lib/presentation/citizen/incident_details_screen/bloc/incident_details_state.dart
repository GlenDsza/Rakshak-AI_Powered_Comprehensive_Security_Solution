// ignore_for_file: must_be_immutable

part of 'incident_details_bloc.dart';

class IncidentDetailsState extends Equatable {
  IncidentDetailsState({
    this.silderIndex = 0,
    this.incident,
  });

  Incident? incident;

  int silderIndex;

  @override
  List<Object?> get props => [
        silderIndex,
        incident,
      ];
  IncidentDetailsState copyWith({
    int? silderIndex,
    String? radioGroup,
    Incident? incident,
  }) {
    return IncidentDetailsState(
      silderIndex: silderIndex ?? this.silderIndex,
      incident: incident ?? this.incident,
    );
  }
}
