import 'package:hdbox_app/core/helpers/app_imports.dart';

class BuildTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final IconData icon;
  final double contentPadding;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType type;
  final IconData? suffixIcon;
  final VoidCallback? suffixOnPressed;

  const BuildTextFormField({
    super.key,
     this.label,
    required this.icon,
    this.isPassword = false,
    this.controller,
    this.type = TextInputType.emailAddress,
    this.suffixIcon,
    this.suffixOnPressed,
    this.hint, this.contentPadding=15.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: TextField(
        keyboardType: type,
        obscureText: isPassword,
        controller: controller,
        style: TextStyle(color: ColorManager.white),
        cursorColor: Colors.redAccent,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: ColorManager.white),
          hintText: hint,
          hintStyle: TextStyle(color: ColorManager.white),
          prefixIcon: Icon(icon, color: ColorManager.white),
          suffixIcon: IconButton(
            onPressed: suffixOnPressed,
            icon: Icon(suffixIcon, color: ColorManager.white),
          ),
          border: InputBorder.none,
          contentPadding:  EdgeInsets.symmetric(vertical: contentPadding),
        ),
      ),
    );
  }
}
