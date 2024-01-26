// ignore_for_file: must_be_immutable

part of 'faqs_help_bloc.dart';

@immutable
abstract class FaqsHelpEvent extends Equatable {}

class FaqsHelpInitialEvent extends FaqsHelpEvent {
  @override
  List<Object?> get props => [];
}

///event for change ExpandableList selection
class UpdateExpandableListEvent extends FaqsHelpEvent {
  UpdateExpandableListEvent({
    required this.index,
    this.isSelected,
  });

  int index;

  bool? isSelected;

  @override
  List<Object?> get props => [
        index,
        isSelected,
      ];
}
