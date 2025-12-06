import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class BuildActionButtonRow extends StatelessWidget {
  final VoidCallback myListPressed;
  final VoidCallback playPressed;
  final VoidCallback infoPressed;

  const BuildActionButtonRow({
    super.key,
    required this.myListPressed,
    required this.playPressed,
    required this.infoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: myListPressed,
          child: Column(
            children: [
              Icon(Icons.add, color: ColorManager.white),
              Text('My List', style: TextStyle(color: ColorManager.white)),
            ],
          ),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          icon: Icon(Icons.add, color: ColorManager.white),
          onPressed: playPressed,
          label: Text('Play', style: TextStyle(color: ColorManager.white)),
        ),
        GestureDetector(
          onTap: infoPressed,
          child: Column(
            children: [
              Icon(Icons.info_outline, color: ColorManager.white),
              Text('Info', style: TextStyle(color: ColorManager.white)),
            ],
          ),
        ),
      ],
    );
  }
}
