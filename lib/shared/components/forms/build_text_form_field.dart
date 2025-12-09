import 'package:flutter/material.dart';
import 'package:hdbox_app/shared/styles/colors.dart';

class BuildTextFormField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType type;
  final IconData? suffixIcon;
  final VoidCallback? suffixOnPressed;

  const BuildTextFormField({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.controller,
    this.type = TextInputType.emailAddress,
    this.suffixIcon,
    this.suffixOnPressed,
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
          prefixIcon: Icon(icon, color: ColorManager.white),
          suffixIcon: IconButton(
            onPressed: suffixOnPressed,
            icon: Icon(suffixIcon, color: ColorManager.white),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}
