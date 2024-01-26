// ignore_for_file: must_be_immutable

part of 'change_language_bloc.dart';

@immutable
abstract class ChangeLanguageEvent extends Equatable {}

class ChangeLanguageInitialEvent extends ChangeLanguageEvent {
  @override
  ChangeLanguageInitialEvent({required this.value});
  String value;
  List<Object?> get props => [value];
}

class LanguageSubmitEvent extends ChangeLanguageEvent {
  LanguageSubmitEvent({required this.value, required this.context});

  String value;
  BuildContext context;

  @override
  List<Object?> get props => [
        value,
        context,
      ];
}

class ChangeRadioButtonEvent extends ChangeLanguageEvent {
  ChangeRadioButtonEvent({required this.value});

  String value;

  @override
  List<Object?> get props => [
        value,
      ];
}
