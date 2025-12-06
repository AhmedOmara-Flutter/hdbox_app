import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class ActionButtonItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const ActionButtonItem({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 31.0, color: ColorManager.white),
          SizedBox(height: 5.0),
          Text(
            label,
            style: TextStyle(
              color: ColorManager.white.withOpacity(0.7),
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
