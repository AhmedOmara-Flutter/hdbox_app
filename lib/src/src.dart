import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/modules/splash/splash_screen.dart';
import '../layout/movies_homeLayout.dart';
import '../shared/components/utils/function.dart';
import '../shared/cubit/movies_cubit.dart';
import '../shared/styles/colors.dart';

class AppRoot extends StatelessWidget {
  final String uId;

  const AppRoot({super.key, required this.uId});

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
          //todo
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: ColorManager.white,
            selectionColor: ColorManager.white.withOpacity(0.3),
            selectionHandleColor: ColorManager.white,
          ),
          //todo
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        home: SplashScreen(uId: uId),
      ),
    );
  }
}
