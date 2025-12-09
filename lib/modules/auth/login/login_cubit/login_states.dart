abstract class LoginStates {}

class InitialLoginState extends LoginStates {}

class LoginIsPasswordChangeState extends InitialLoginState {}

class LoginLoadingState extends InitialLoginState {}

class LoginSuccessState extends InitialLoginState {}

class LoginErrorState extends InitialLoginState {
  final String error;

  LoginErrorState({required this.error});
}
