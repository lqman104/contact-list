import 'package:flutter/material.dart';

class Styles {
  static InputDecoration getIconInputDecoration({
    required String hint,
    required IconData iconData,
  }) =>
      InputDecoration(
        hintText: hint,
        prefixIconColor: const Color(0xFFE0E0E0),
        border: InputBorder.none,
        prefixIcon: Icon(iconData),
      );
}
