import 'package:flutter/material.dart';
import 'package:hdbox_app/shared/components/utils/function.dart';

import '../../styles/colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: style(16.0),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text('See all', style: TextStyle(color: ColorManager.red)),
          ),
        ],
      ),
    );
  }
}
