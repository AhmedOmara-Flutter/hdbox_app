import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/modules/auth/register/register_cubit/register_states.dart';

class RegisterCubit extends Cubit<InitialRegisterState> {
  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool isPassword = true;

  void isPasswordChanged() {
    isPassword = !isPassword;
    emit(RegisterIsPasswordChangeState());
  }

  Future<void> userRegister({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccessState());
      print(user.user!.uid);
    } catch (error) {
      emit(RegisterErrorState(error: error.toString()));
      print('Login error $error');

    }
  }
}
