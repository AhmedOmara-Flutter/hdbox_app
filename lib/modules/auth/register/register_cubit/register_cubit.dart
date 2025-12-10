import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/models/user_model.dart';
import 'package:hdbox_app/modules/auth/register/register_cubit/register_states.dart';
import 'package:hdbox_app/shared/components/constants.dart';

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

  Future<void> createUser({
    required String email,
    required String password,
    required String uId,
    required String username,
    required String bio,
    required String cover,
    required String image,
  }) async {
    UserModel user = UserModel(
      bio: bio,
      cover: cover,
      image: image,
      email: email,
      password: password,
      name: username,
      uId: uId,
    );
    emit(CreateUserLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(user.toMap())
        .then((value) {
          emit(CreateUserSuccessState());
        })
        .catchError((error) {
          emit(CreateUserErrorState(error: error.toString()));
        });
  }

  Future<void> userRegister({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(RegisterLoadingState());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      createUser(
        email: email,
        password: password,
        uId: user.user!.uid,
        username: username,
        bio: 'Write your bio...',
        cover:
            'https://img.freepik.com/premium-photo/businessman-holding-hand-icon-user-manwoman-3d-style-internet-icons-interface-foreground-global-network-media-concept_150455-19928.jpg?w=1060',
        image:
            'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?t=st=1720966897~exp=1720970497~hmac=61d976e5a023f5f5cbc9f2cd6b4f8cd906379bae966272e627916c8829e07a50&w=740',
      );
      Constants.uId=user.user!.uid;
      emit(RegisterSuccessState());
    } catch (error) {
      emit(RegisterErrorState(error: error.toString()));
      print('Login error $error');
    }
  }
}
