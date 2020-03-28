import 'package:setiuwetlandstourbooking/app/sign_in/validators.dart';

enum StaffSignInFormType { signIn, register }

class StaffSignInModel with EmailAndPasswordValidators {
  StaffSignInModel({

    this.email = '',
    this.password = '',
    this.formType = StaffSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

  final String email;
  final String password;
  final StaffSignInFormType formType;
  final bool isLoading;
  final bool submitted;
  String get primaryButtonText {
    return formType == StaffSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
  }





  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get secondaryButtonText {
    return formType == StaffSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account?Sign in';
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  StaffSignInModel copyWith({
    String email,
    String password,
    StaffSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    return StaffSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
//model.copyWith(email:email)
}