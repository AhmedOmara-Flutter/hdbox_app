import 'package:hdbox_app/core/helpers/app_imports.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: PaddingManager.p30,
        horizontal: PaddingManager.p10,
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
        color: ColorManager.white,
      ),
    );
  }
}
