import '../models/questions_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rakshak/presentation/citizen/faqs_help_screen/models/faqs_help_model.dart';
part 'faqs_help_event.dart';
part 'faqs_help_state.dart';

class FaqsHelpBloc extends Bloc<FaqsHelpEvent, FaqsHelpState> {
  FaqsHelpBloc(FaqsHelpState initialState) : super(initialState) {
    on<FaqsHelpInitialEvent>(_onInitialize);
    on<UpdateExpandableListEvent>(_updateExpandableList);
  }

  _updateExpandableList(
    UpdateExpandableListEvent event,
    Emitter<FaqsHelpState> emit,
  ) {
    List<QuestionsItemModel> newList = List<QuestionsItemModel>.from(
        state.faqsHelpModelObj!.questionsItemList);
    newList[event.index] =
        newList[event.index].copyWith(isSelected: event.isSelected);
    emit(state.copyWith(
        faqsHelpModelObj:
            state.faqsHelpModelObj?.copyWith(questionsItemList: newList)));
  }

  List<QuestionsItemModel> fillQuestionsItemList() {
    return List.generate(4, (index) => QuestionsItemModel());
  }

  _onInitialize(
    FaqsHelpInitialEvent event,
    Emitter<FaqsHelpState> emit,
  ) async {
    emit(state.copyWith(serchController: TextEditingController()));
    emit(state.copyWith(
        faqsHelpModelObj: state.faqsHelpModelObj
            ?.copyWith(questionsItemList: fillQuestionsItemList())));
  }
}
