abstract class LoginStates {}

class InitialLoginState extends LoginStates {}

class LoginIsPasswordChangeState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String uId;

  LoginSuccessState({required this.uId});
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState({required this.error});
}
