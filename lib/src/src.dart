import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/layout/movies_homeLayout.dart';
import 'package:hdbox_app/modules/onboarding/get_started_screen.dart';
import 'package:hdbox_app/modules/splash/splash_screen.dart';
import '../shared/cubit/movies_cubit.dart';
import '../shared/styles/colors.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesCubit()..getAllData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorManager.baseColor,
          appBarTheme: AppBarTheme(
            backgroundColor: ColorManager.baseColor,
            elevation: 0.0,
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: ColorManager.white,
            selectionColor: ColorManager.white.withOpacity(0.3),
            selectionHandleColor: ColorManager.white,
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }

  // Widget startWidget({required String uId}) {
  //   Widget? widget;
  //   print(uId);
  //   if (Constants.uId != null) {
  //     widget = MoviesHomeLayout();
  //   } else {
  //     widget = SplashScreen();
  //   }
  //   return widget;
  // }
}
