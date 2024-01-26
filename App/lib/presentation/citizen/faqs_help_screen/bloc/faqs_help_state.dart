// ignore_for_file: must_be_immutable

part of 'faqs_help_bloc.dart';

class FaqsHelpState extends Equatable {
  FaqsHelpState({
    this.serchController,
    this.faqsHelpModelObj,
  });

  TextEditingController? serchController;

  FaqsHelpModel? faqsHelpModelObj;

  @override
  List<Object?> get props => [
        serchController,
        faqsHelpModelObj,
      ];
  FaqsHelpState copyWith({
    TextEditingController? serchController,
    FaqsHelpModel? faqsHelpModelObj,
  }) {
    return FaqsHelpState(
      serchController: serchController ?? this.serchController,
      faqsHelpModelObj: faqsHelpModelObj ?? this.faqsHelpModelObj,
    );
  }
}
