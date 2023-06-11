import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/theme.dart';

class menuPengeluaran extends StatelessWidget {
  final VoidCallback onPressed;
  const menuPengeluaran({
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
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wallet,
              color: Colors.green,
              size: 30.sp,
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              'Pengeluaran',
              style: blackTextStyle.copyWith(fontSize: 11.sp),
            )
          ],
        ),
      ),
    );
  }
}
