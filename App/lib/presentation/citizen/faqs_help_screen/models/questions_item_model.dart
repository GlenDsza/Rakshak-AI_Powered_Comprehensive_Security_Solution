import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class QuestionsItemModel extends Equatable {
  QuestionsItemModel(
      {this.howdoesrelaxworOneTxt = "How does Rakshak work?",
      this.descriptionTxt =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Laoreet nulla lorem eget praesent arcu. Nam tellus faucibus blandit dis est ultrices pretium.\nDui faucibus malesuada viverra suspendisse at dictumst aenean eget dolor. Orci ornare morbi ut nibh ultricies at lobortis.",
      this.isSelected = false});

  String howdoesrelaxworOneTxt;

  String descriptionTxt;

  bool isSelected;

  QuestionsItemModel copyWith(
      {String? howdoesrelaxworOneTxt,
      String? descriptionTxt,
      bool? isSelected}) {
    return QuestionsItemModel(
      howdoesrelaxworOneTxt:
          howdoesrelaxworOneTxt ?? this.howdoesrelaxworOneTxt,
      descriptionTxt: descriptionTxt ?? this.descriptionTxt,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props =>
      [howdoesrelaxworOneTxt, descriptionTxt, isSelected];
}
