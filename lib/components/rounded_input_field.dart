import 'package:flutter/material.dart';
import 'package:kita_warga_apps/components/text_field_container.dart';
import 'package:kita_warga_apps/theme.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: blueColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: blueColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
