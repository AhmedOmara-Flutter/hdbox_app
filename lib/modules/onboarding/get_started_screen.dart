import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/components/utils/function.dart';
import '../../shared/styles/colors.dart';
import '../auth/login/login_screen.dart';
import '../auth/register/register_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Image(
                  image: AssetImage('images/getStarted.png'),
                  height: 500.0,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                Container(
                  height: 500.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        ColorManager.baseColor,
                        ColorManager.baseColor.withOpacity(0.38),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 500.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ColorManager.baseColor,
                        ColorManager.baseColor.withOpacity(0.0),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Let's Get\nStarted",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            height: 1.1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                children: [
                  rowButton(
                    label: 'Sign up for free',
                    onPressed: () {
                      navigateTo(context, RegisterScreen());
                    },
                  ),
                  rowButton(
                    label: 'Continue with Google',
                    onPressed: () {},
                    icon: 'google.png',
                  ),
                  rowButton(
                    label: 'Continue with Apple',
                    onPressed: () {},
                    icon: 'apple.png',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20.0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            navigateTo(context, LoginScreen());
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                            child: Text('Log in', style: style(15.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowButton({
    required String label,
    String? icon,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          width: double.infinity,
          height: 50.0,
          decoration: BoxDecoration(
            color: ColorManager.darkGray,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: MaterialButton(
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset('images/$icon', scale: 30),
                    ),
                  Text(label, style: style(15.0)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 15.0),
      ],
    );
  }
}
