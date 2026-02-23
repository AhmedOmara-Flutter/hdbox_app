import 'package:hdbox_app/core/helpers/app_imports.dart';

class AuthFooter extends StatelessWidget {
  final String? label;
  final String? buttonName;
  final VoidCallback? buttonOnPressed;

  const AuthFooter({
    super.key,
    this.label,
    this.buttonOnPressed,
    this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$label', style: style(FontManager.s13)),
        SizedBox(width: AppSizeManager.s10),
        InkWell(
          onTap: buttonOnPressed,
          child: Text(
            '$buttonName',
            style: style(FontManager.s15, color: ColorManager.red),
          ),
        ),
      ],
    );
  }
}
