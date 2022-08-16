import 'package:flutter/material.dart';

class PasswordInputField extends TextField {
  PasswordInputField({
    Key? key,
    String? title,
    required ThemeData data,
    required TextEditingController controller,
    Widget? suffixIcon,
    bool isSecure = false,
    required bool obscureText,
  }) : super(
          key: key,
          controller: controller,
          decoration: InputDecoration(
            labelText: '$title',
            hoverColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: ThemeData.dark().backgroundColor,
            filled: true,
            suffixIcon: suffixIcon,
          ),
          obscureText: obscureText,
        );
}
