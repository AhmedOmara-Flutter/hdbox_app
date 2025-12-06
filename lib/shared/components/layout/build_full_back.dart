import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class BuildFullBack extends StatelessWidget {
  const BuildFullBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: ColorManager.red));
  }
}
