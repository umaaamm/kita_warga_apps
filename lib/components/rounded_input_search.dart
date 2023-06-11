import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/components/text_field_container.dart';
import 'package:kita_warga_apps/theme.dart';

class RoundedInputSearch extends StatelessWidget {
  final String? hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputSearch({
    Key? key,
    this.hintText,
    this.icon = Icons.search,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        style: regularTextStyle.copyWith(
            fontSize: 16.sp),
        cursorColor: blueColor,
        decoration: InputDecoration(
          suffixIcon: Icon(
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
