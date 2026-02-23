import 'package:hdbox_app/core/helpers/app_imports.dart';

class GetBackgroundImage extends StatelessWidget {
  const GetBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        AssetsManager.authBackGround,
        fit: BoxFit.cover,
      ),
    );
  }
}
