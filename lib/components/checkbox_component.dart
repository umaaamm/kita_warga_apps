import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/theme.dart';

class checkboxRounded extends StatelessWidget {
  final Function(bool?) toggleCheckboxState;
  final String title;
  const checkboxRounded({
    super.key,
    required this.checkValue,
    required this.title,
    required this.toggleCheckboxState
  });

  final bool checkValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20, top: 10, bottom: 10),
      child: SizedBox(
        height: 60,
        child: CheckboxListTile(
          visualDensity: VisualDensity.compact,
          contentPadding: EdgeInsets.all(0),
          title: Text(title, style: regularTextStyle.copyWith(
              fontSize: 16.sp, color: blueColor),), //    <-- label
          value: checkValue,
          onChanged: toggleCheckboxState,
          controlAffinity: ListTileControlAffinity
              .leading, //  <-- leading Checkbox
          activeColor: blueColor,
          checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}