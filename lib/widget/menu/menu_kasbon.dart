import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/theme.dart';

class menuKasbon extends StatelessWidget {
  final VoidCallback onPressed;
  const menuKasbon({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 80.h,
        width: 100.w,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wallet,
              color: Colors.red,
              size: 30.sp,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'Kas Bon',
              style: blackTextStyle.copyWith(fontSize: 11.sp),
            )
          ],
        ),
      ),
    );
  }
}
