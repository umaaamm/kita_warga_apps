import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/theme.dart';

class FloatingFooter extends StatelessWidget {
  const FloatingFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width - (2 * 24),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home,
                color: blueColor,
                size: 30.sp,
              ),
              Text(
                'Beranda',
                style:
                    blackTextStyle.copyWith(color: blueColor, fontSize: 12.sp),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle,
                color: blueColor,
                size: 30.sp,
              ),
              Text(
                'Tambah Data',
                style:
                    blackTextStyle.copyWith(color: blueColor, fontSize: 12.sp),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                color: blueColor,
                size: 30.sp,
              ),
              Text(
                'Profil',
                style:
                    blackTextStyle.copyWith(color: blueColor, fontSize: 12.sp),
              )
            ],
          ),
        ],
      ),
    );
  }
}
