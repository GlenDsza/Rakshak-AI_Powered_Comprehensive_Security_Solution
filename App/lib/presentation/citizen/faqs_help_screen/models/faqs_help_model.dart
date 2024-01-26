import 'package:equatable/equatable.dart';
import 'questions_item_model.dart';

// ignore: must_be_immutable
class FaqsHelpModel extends Equatable {
  FaqsHelpModel({this.questionsItemList = const []});

  List<QuestionsItemModel> questionsItemList;

  FaqsHelpModel copyWith({List<QuestionsItemModel>? questionsItemList}) {
    return FaqsHelpModel(
      questionsItemList: questionsItemList ?? this.questionsItemList,
    );
  }

  @override
  List<Object?> get props => [questionsItemList];
}
