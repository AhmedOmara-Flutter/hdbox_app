abstract class RegisterStates {}

class InitialRegisterState extends RegisterStates {}

class RegisterIsPasswordChangeState extends InitialRegisterState {}

class RegisterLoadingState extends InitialRegisterState {}

class RegisterSuccessState extends InitialRegisterState {}

class RegisterErrorState extends InitialRegisterState {
  final String error;

  RegisterErrorState({required this.error});
}
