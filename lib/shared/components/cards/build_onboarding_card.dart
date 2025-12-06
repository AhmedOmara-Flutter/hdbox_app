import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../styles/colors.dart';

class BuildOnboardingCard extends StatelessWidget {
  final String image;
  final String label;

  const BuildOnboardingCard({
    super.key,
    required this.image,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 140),
        child: Stack(
          alignment: AlignmentGeometry.bottomCenter,
          children: [
            Image.asset('images/$image', height: 520.0),
            Container(
              height: 150.0,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    ColorManager.baseColor,
                    ColorManager.baseColor.withOpacity(1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 70.0,
              color: ColorManager.baseColor,
            ),
            Text(
              label,
              style: GoogleFonts.alegreya(
                color: ColorManager.white,
                fontSize: 37,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
