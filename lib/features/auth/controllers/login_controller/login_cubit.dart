import 'package:hdbox_app/core/helpers/app_imports.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool isPassword = true;

  void isPasswordChanged() {
    isPassword = !isPassword;
    emit(LoginIsPasswordChangeState());
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("UId = ${user.user!.uid}");

      emit(LoginSuccessState(uId: user.user!.uid));
    } catch (error) {
      emit(LoginErrorState(error: error.toString()));
      print('Login error $error');
    }
  }
}
