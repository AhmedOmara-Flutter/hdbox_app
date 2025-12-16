import 'package:flutter/material.dart';
import '../../styles/colors.dart';

class SegmentedTabSelector extends StatelessWidget {
  final String label;
  final Color color;
  final BorderRadius borderRadius;

  const SegmentedTabSelector({
    super.key,
    required this.label,
    required this.color,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: ColorManager.red,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(color: ColorManager.white, width: 0.5),
      ),
      width: 110.0,
      height: 32.0,
      child: Center(
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
