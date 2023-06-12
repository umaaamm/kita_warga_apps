import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/theme.dart';

class TextInputBorderBottom extends StatelessWidget {
  final String labelText;
  final String hintText;
  final ValueChanged<String> onChanged;
  const TextInputBorderBottom({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        onChanged: onChanged,
        style: regularTextStyle.copyWith(
            fontSize: 16.sp),
        cursorColor: blueColor,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: regularTextStyle.copyWith(fontSize: 16.sp,color: blueColor),
          hintText: hintText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: greyColorLight, width: 2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: blueColor, width: 2),
          ),
        ),
      ),
    );
  }
}
