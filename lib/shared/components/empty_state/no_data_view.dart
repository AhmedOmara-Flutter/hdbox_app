import 'package:flutter/material.dart';
import '../../styles/colors.dart';
import '../layout/build_appbar_screens.dart';
import '../utils/function.dart';

class NoDataView extends StatelessWidget {
  final String image;
  final String title;
  final String? buttonText;
  final VoidCallback? onPressed;
  final String appBarTitle;

  const NoDataView({
    super.key,
    this.image = 'video.png',
    required this.title,
    this.buttonText,
    this.onPressed,
    required this.appBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppbarScreen(title: appBarTitle),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/$image', height: 140.0, width: 140.0),
          SizedBox(height: 8.0),
          Center(child: Text(title, style: style(16.0))),
          SizedBox(height: 8.0),
          if (buttonText != null && onPressed != null)
            MaterialButton(
              color: ColorManager.red,
              onPressed: onPressed,
              child: Text(buttonText!, style: style(12.0)),
            ),
        ],
      ),
    );
  }
}
