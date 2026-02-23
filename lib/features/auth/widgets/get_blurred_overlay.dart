import 'dart:ui';
import 'package:hdbox_app/core/helpers/app_imports.dart';

class GetBlurredOverlay extends StatelessWidget {
  const GetBlurredOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: AppSizeManager.s6, sigmaY: AppSizeManager.s6),
        child: Container(
            color: Colors.black.withOpacity(AppSizeManager.s0_4)),
      ),
    );
  }
}
