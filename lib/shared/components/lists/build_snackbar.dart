import 'package:flutter/material.dart';
import 'package:hdbox_app/shared/styles/colors.dart';

class BuildSnackBar {
  static void showWatchlistSnackBar({
    required BuildContext context,
    required String message,
    required VoidCallback onPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xff1C1C1C),
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                'VIEW',
                style: TextStyle(
                  color: ColorManager.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
