// ignore_for_file: must_be_immutable

part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  EditProfileState({
    this.fullnameOneController,
    this.emailOneController,
    this.addressOneController,
    this.passwordOneController,
    this.editProfileModelObj,
  });

  TextEditingController? fullnameOneController;

  TextEditingController? emailOneController;

  TextEditingController? addressOneController;

  TextEditingController? passwordOneController;

  EditProfileModel? editProfileModelObj;

  @override
  List<Object?> get props => [
        fullnameOneController,
        emailOneController,
        addressOneController,
        passwordOneController,
        editProfileModelObj,
      ];
  EditProfileState copyWith({
    TextEditingController? fullnameOneController,
    TextEditingController? emailOneController,
    TextEditingController? addressOneController,
    TextEditingController? passwordOneController,
    EditProfileModel? editProfileModelObj,
  }) {
    return EditProfileState(
      fullnameOneController:
          fullnameOneController ?? this.fullnameOneController,
      emailOneController: emailOneController ?? this.emailOneController,
      addressOneController: addressOneController ?? this.addressOneController,
      passwordOneController:
          passwordOneController ?? this.passwordOneController,
      editProfileModelObj: editProfileModelObj ?? this.editProfileModelObj,
    );
  }
}
