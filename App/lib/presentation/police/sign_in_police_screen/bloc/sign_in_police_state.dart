// ignore_for_file: must_be_immutable

part of 'sign_in_police_bloc.dart';

class SignInPoliceState extends Equatable {
  SignInPoliceState({
    this.idController,
    this.passwordController,
    this.isShowPassword = true,
    this.signInPoliceModelObj,
  });

  TextEditingController? idController;

  TextEditingController? passwordController;

  SignInPoliceModel? signInPoliceModelObj;

  bool isShowPassword;

  @override
  List<Object?> get props => [
        idController,
        passwordController,
        isShowPassword,
        signInPoliceModelObj,
      ];
  SignInPoliceState copyWith({
    TextEditingController? idController,
    TextEditingController? passwordController,
    bool? isShowPassword,
    SignInPoliceModel? signInPoliceModelObj,
  }) {
    return SignInPoliceState(
      idController: idController ?? this.idController,
      passwordController: passwordController ?? this.passwordController,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      signInPoliceModelObj: signInPoliceModelObj ?? this.signInPoliceModelObj,
    );
  }
}
