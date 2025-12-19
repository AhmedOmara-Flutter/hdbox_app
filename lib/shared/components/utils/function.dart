import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../layout/movies_homeLayout.dart';
import '../../../modules/splash/splash_screen.dart';
import '../../styles/colors.dart';

void navigateTo(
  BuildContext context,
  Widget screen, {
  bool isReplacement = false,
}) {
  if (isReplacement) {
    //todo
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionDuration: Duration(milliseconds: 350),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutQuart,
              ),
              child: child,
            ),
      ),
    );
  } else {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionDuration: Duration(milliseconds: 350),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutQuart,
              ),
              child: child,
            ),
      ),
    );
  }
}

Widget shadowBellowPhoto({required double shadow}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          ColorManager.baseColor,
          ColorManager.baseColor.withOpacity(shadow),
          ColorManager.baseColor.withOpacity(0.1),
          Colors.transparent,
        ],
      ),
    ),
  );
}

TextStyle style(double fontSize,{Color color=Colors.white}) {
  return TextStyle(
    color:color,
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
    height: 1.1,
  );
}

String formattedDate({required String date}) {
  if (date == null || date.isEmpty) return "inValid date";
  try {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('MMMM d, yyyy').format(dateTime);
  } on Exception catch (e) {
    return 'inValid date';
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnakeBar({
  required BuildContext context,
  required String label,
  required Color color,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(label),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

// Widget startWidget({required String uId}) {
//   Widget? widget;
//   if (uId.isNotEmpty) {
//     widget = MoviesHomeLayout();
//   } else {
//     widget = SplashScreen();
//   }
//   return widget;
// }

Widget emptyWatchlistMessage(String type) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.bookmark_border,
          size: 70,
          color: Colors.grey.withOpacity(0.6),
        ),
        const SizedBox(height: 15),
        Text(
          type == 'movie'
              ? 'No movies in your watchlist'
              : 'No TV shows in your watchlist',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

String formatName(String input) {
  if (input.isEmpty) return input;

  String result = '';

  for (int i = 0; i < input.length; i++) {
    String char = input[i];

    if (char == char.toUpperCase() && char != char.toLowerCase()) {
      result += ' ';
    }

    result += char;
  }

  return result.trim().replaceFirst(result[0], result[0].toUpperCase());
}
