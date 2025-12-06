import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class BuildNetworkCard extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String image;

  const BuildNetworkCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: ColorManager.baseColor,
        height: 140.0,
        width: 190.0,
        child: Column(
          children: [
            Container(
              height: 110.0,
              width: 190.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                image,
                height: 130.0,
                width: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              title,
              style: TextStyle(
                color: ColorManager.lightGray,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
