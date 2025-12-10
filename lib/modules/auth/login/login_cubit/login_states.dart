abstract class LoginStates {}

class InitialLoginState extends LoginStates {}

class LoginIsPasswordChangeState extends InitialLoginState {}

class LoginLoadingState extends InitialLoginState {}

class LoginSuccessState extends InitialLoginState {
  final String uId;

  LoginSuccessState({required this.uId});
}

class LoginErrorState extends InitialLoginState {
  final String error;

  LoginErrorState({required this.error});
}
