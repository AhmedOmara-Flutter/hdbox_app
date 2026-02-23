import 'package:hdbox_app/core/helpers/app_imports.dart';

class AppRoot extends StatelessWidget {
  final String uId;
  final bool isSeen;

  const AppRoot({super.key, required this.uId, required this.isSeen});

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
        home:SplashScreen(uId: uId,isSeen: isSeen,) ,
      ),
    );
  }
}
