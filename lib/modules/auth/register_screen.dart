import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/components/buttons/build_play_button.dart';
import '../../shared/components/forms/build_text_form_field.dart';
import '../../shared/components/utils/function.dart';
import '../../shared/styles/colors.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        Text(
                          "Create Account",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Join us & enjoy unlimited movies and shows.",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 35),
                        BuildTextFormField(
                          icon: Icons.person,
                          label: "Username",
                        ),
                        const SizedBox(height: 18),
                        BuildTextFormField(
                          icon: Icons.email_outlined,
                          label: "Email Address",
                        ),
                        const SizedBox(height: 18),
                        BuildTextFormField(
                          icon: Icons.password,
                          label: "Password",
                          isPassword: true,
                        ),
                        const SizedBox(height: 28),
                        BuildPlayButton(
                          onPressed: () {
                            navigateTo(context, LoginScreen());
                          },
                          label: 'Create Account',
                        ),
                        const SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                navigateTo(context, LoginScreen());
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
  }
}
