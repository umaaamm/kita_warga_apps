import 'package:flutter/material.dart';
import 'package:kita_warga_apps/components/text_field_container.dart';
import 'package:kita_warga_apps/theme.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: blueColor,
        decoration: InputDecoration(
          hintText: "Masukkan password",
          icon: Icon(
            Icons.lock,
            color: blueColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: blueColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
