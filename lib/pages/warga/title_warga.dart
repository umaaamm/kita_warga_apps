import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme.dart';

class title_warga extends StatelessWidget {
  final String Title;
  final String SubTitle;

  const title_warga({
    required this.Title,
    required this.SubTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Title,
            style: regularTextStyle.copyWith(
                fontSize: 20.sp,
                color: blueColor,
                fontWeight: FontWeight.w700),
          ),
          Text(
            SubTitle,
            style: regularTextStyle.copyWith(
                fontSize: 14.sp, color: blueColor),
          ),
        ],
      ),
    );
  }
}