// ignore_for_file: must_be_immutable

part of 'change_language_bloc.dart';

class ChangeLanguageState extends Equatable {
  ChangeLanguageState({this.radioGroup});

  String? radioGroup = PrefUtils().getLanguage();

  @override
  List<Object?> get props => [radioGroup];
  ChangeLanguageState copyWith({String? radioGroup}) {
    return ChangeLanguageState(
      radioGroup: radioGroup ?? this.radioGroup,
    );
  }
}
