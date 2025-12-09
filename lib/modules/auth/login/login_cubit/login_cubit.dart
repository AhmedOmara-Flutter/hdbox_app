import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/modules/auth/login/login_cubit/login_states.dart';

class LoginCubit extends Cubit<InitialLoginState> {
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
      emit(LoginSuccessState());
      print(user.user!.uid);
    } catch (error) {
      emit(LoginErrorState(error: error.toString()));
      print('Login error $error');
    }
  }
}
