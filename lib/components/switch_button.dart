import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/theme.dart';

class SwitchButton extends StatelessWidget {
  final Function(bool?) toggleSwitchState;
  final String title;
  const SwitchButton({
    super.key,
    required this.title,
    required this.toggleSwitchState,
    required this.checkValue,
  });

  final bool checkValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: regularTextStyle.copyWith(
                  fontSize: 16.sp, color: blueColor),
            ),
          ),
          Switch(
            value: checkValue,
            onChanged: toggleSwitchState,
            activeTrackColor: blueColor50,
            activeColor: blueColor,
          ),
        ],
      ),
    );
  }
}
