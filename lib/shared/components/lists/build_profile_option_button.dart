import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hdbox_app/shared/components/utils/function.dart';

class BuildProfileOptionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  const BuildProfileOptionButton({super.key, required this.icon, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xff1a1a1a),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 15),
            Text(
              title,
              style: style(14.0),
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white38,
                size: 16,
              ),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
