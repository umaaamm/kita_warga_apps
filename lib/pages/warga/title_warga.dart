import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme.dart';

class title_warga extends StatelessWidget {
  const title_warga({
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
            'Data Warga',
            style: regularTextStyle.copyWith(
                fontSize: 20.sp,
                color: blueColor,
                fontWeight: FontWeight.w700),
          ),
          Text(
            'Daftar Warga yang anda kelola',
            style: regularTextStyle.copyWith(
                fontSize: 14.sp, color: blueColor),
          ),
        ],
      ),
    );
  }
}