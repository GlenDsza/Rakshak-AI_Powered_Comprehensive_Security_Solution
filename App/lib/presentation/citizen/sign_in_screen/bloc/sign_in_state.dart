// ignore_for_file: must_be_immutable

part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  SignInState({
    this.phonenumberController,
    this.passwordController,
    this.isShowPassword = true,
    this.signInModelObj,
  });

  TextEditingController? phonenumberController;

  TextEditingController? passwordController;

  SignInModel? signInModelObj;

  bool isShowPassword;

  @override
  List<Object?> get props => [
        phonenumberController,
        passwordController,
        isShowPassword,
        signInModelObj,
      ];
  SignInState copyWith({
    TextEditingController? phonenumberController,
    TextEditingController? passwordController,
    bool? isShowPassword,
    SignInModel? signInModelObj,
  }) {
    return SignInState(
      phonenumberController:
          phonenumberController ?? this.phonenumberController,
      passwordController: passwordController ?? this.passwordController,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      signInModelObj: signInModelObj ?? this.signInModelObj,
    );
  }
}
