import 'package:hdbox_app/core/helpers/app_imports.dart';

class GetDarkGradientBottomOverlay extends StatelessWidget {
  const GetDarkGradientBottomOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(AppSizeManager.s0_7),
              Colors.black.withOpacity(AppSizeManager.s0_9),
            ],
          ),
        ),
      ),
    );
  }
}
