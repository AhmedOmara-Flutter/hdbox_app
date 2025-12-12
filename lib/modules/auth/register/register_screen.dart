import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/modules/auth/register/register_cubit/register_cubit.dart';
import 'package:hdbox_app/modules/auth/register/register_cubit/register_states.dart';
import 'package:hdbox_app/shared/components/layout/build_full_back.dart';

import '../../../shared/components/buttons/build_play_button.dart';
import '../../../shared/components/forms/build_text_form_field.dart';
import '../../../shared/components/utils/function.dart';
import '../../../shared/styles/colors.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (cotext, state) {
          if (state is RegisterSuccessState) {
            showSnakeBar(
              context: context,
              label: 'Your account has been created successfully!',
              color: Colors.green,
            );
            navigateTo(context, LoginScreen(),isReplacement: true);
          }
          if (state is RegisterErrorState) {
            showSnakeBar(
              context: context,
              label: 'Please check your credentials and try again',
              color: ColorManager.red,
            );
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Scaffold(
              body: Stack(
                children: [
                  // Background Image
                  Positioned.fill(
                    child: Image.asset(
                      "images/auth-background.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Blurred Overlay for cinematic look
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(color: Colors.black.withOpacity(0.4)),
                    ),
                  ),
                  // Dark gradient bottom overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.9),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30.0,
                      horizontal: 10.0,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      color: ColorManager.white,
                    ),
                  ),
                  // Content
                  Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 100.0),
                              Text("Create Account", style: style(32.0)),
                              const SizedBox(height: 10),
                              Text(
                                "Join us & enjoy unlimited movies and shows.",
                                style: style(15.0),
                              ),
                              const SizedBox(height: 35),
                              BuildTextFormField(
                                controller: cubit.usernameController,
                                icon: Icons.person,
                                label: "Username",
                              ),
                              const SizedBox(height: 18),
                              BuildTextFormField(
                                controller: cubit.emailController,
                                icon: Icons.email_outlined,
                                label: "Email Address",
                              ),
                              const SizedBox(height: 18),
                              BuildTextFormField(
                                suffixIcon: cubit.isPassword
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off,
                                controller: cubit.passwordController,
                                icon: Icons.password,
                                label: "Password",
                                isPassword: cubit.isPassword,
                                suffixOnPressed: () {
                                  cubit.isPasswordChanged();
                                },
                                type: TextInputType.phone,
                              ),
                              const SizedBox(height: 28),
                              ConditionalBuilder(
                                condition: state is! RegisterLoadingState,
                                builder: (context) => BuildPlayButton(
                                  onPressed: ()  async{
                                   await cubit.userRegister(
                                      email: cubit.emailController.text,
                                      password: cubit.passwordController.text,
                                     username: cubit.usernameController.text,
                                    );
                                  },
                                  label: 'Create Account',
                                ),
                                fallback: (context) => BuildFullBack(),
                              ),
                              const SizedBox(height: 25.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account? ',
                                    style: style(14.0),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      navigateTo(context, LoginScreen(),isReplacement: true);
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: ColorManager.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
