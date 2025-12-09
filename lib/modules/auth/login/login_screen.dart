import 'dart:ui';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/modules/auth/login/login_cubit/login_cubit.dart';
import 'package:hdbox_app/modules/auth/login/login_cubit/login_states.dart';
import 'package:hdbox_app/modules/auth/register/register_screen.dart';
import 'package:hdbox_app/shared/components/layout/build_full_back.dart';
import '../../../layout/movies_homeLayout.dart';
import '../../../shared/components/buttons/build_play_button.dart';
import '../../../shared/components/forms/build_text_form_field.dart';
import '../../../shared/components/utils/function.dart';
import '../../../shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            showSnakeBar(
              context: context,
              label: 'Welcome back! You are now logged in.',
              color: Colors.green,
            );
            navigateTo(context, MoviesHomeLayout());
          }
          if (state is LoginErrorState) {
            showSnakeBar(
              context: context,
              label: 'Please check your credentials and try again',
              color: ColorManager.red,
            );
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
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
                              const Text(
                                "Welcome Back",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Login to continue watching your favorite movies.",
                                style: style(15.0),
                              ),
                              const SizedBox(height: 35),
                              BuildTextFormField(
                                controller: cubit.emailController,
                                label: "Email",
                                icon: Icons.email_outlined,
                              ),
                              const SizedBox(height: 18),
                              BuildTextFormField(
                                controller: cubit.passwordController,
                                label: "Password",
                                icon: Icons.lock_outline_rounded,
                                isPassword: cubit.isPassword,
                                suffixIcon: cubit.isPassword
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off,
                                suffixOnPressed: () {
                                  cubit.isPasswordChanged();
                                },
                                type: TextInputType.phone,
                              ),
                              const SizedBox(height: 14),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: ColorManager.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 28),
                              ConditionalBuilder(
                                condition: state is! LoginLoadingState,
                                builder: (context) => BuildPlayButton(
                                  onPressed: () async{
                                    await cubit.userLogin(
                                      email: cubit.emailController.text,
                                      password: cubit.passwordController.text,
                                    );
                                  },
                                  label: 'Login',
                                ),
                                fallback: (context) => BuildFullBack(),
                              ),
                              const SizedBox(height: 25.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don’t have an account? ',
                                    style: style(14.0),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      navigateTo(context, RegisterScreen());
                                    },
                                    child: Text(
                                      'Sign Up',
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
