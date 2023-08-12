
import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {

  final void Function(String value) onChange;

  const PasswordFormField({
    super.key,
    required this.onChange
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _hidePassword = true;

  IconData getIconData() {
    final IconData iconData;

    if (_hidePassword) {
      iconData = Icons.visibility_outlined;
    } else {
      iconData = Icons.visibility_off_outlined;
    }

    return iconData;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChange,
      obscureText: _hidePassword,
      decoration: InputDecoration(
          hintText: 'Password',
          border: InputBorder.none,
          prefixIconColor: Colors.grey.shade300,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(getIconData()),
            onPressed: () {
              setState(() {
                _hidePassword = !_hidePassword;
              });
            },
          )),
    );
  }
}
