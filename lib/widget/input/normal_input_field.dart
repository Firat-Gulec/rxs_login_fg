import 'package:flutter/material.dart';

class NormalInputField extends TextFormField {
  NormalInputField(
      {Key? key,
      String? title,
      required ThemeData data,
      required TextEditingController controller,
      required onChanged})
      : super(
          key: key,
          decoration: InputDecoration(
              hoverColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              fillColor: data.colorScheme.background,
              filled: true,
              labelText: '$title'),
          controller: controller,
        );
}
