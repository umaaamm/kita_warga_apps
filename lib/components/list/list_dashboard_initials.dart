import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/currency_format.dart';
import 'package:kita_warga_apps/utils/text_format.dart';

class ListDashboardInitials extends StatelessWidget {
  final String? name;
  final String? value;
  final String? date;
  final int? index;
  final bool isDate;
  final Icon? gambarIcon;
  final bool isCurrency;
  const ListDashboardInitials({
    Key? key,
    this.name,
    this.value,
    this.date,
    this.index,
    this.gambarIcon,
    this.isCurrency = false,
    this.isDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      margin: EdgeInsets.only(
        left: 10.w,
        right: 10.w,
        bottom: 10.w
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Center(
                child: Container(
                    width: ScreenUtil().setHeight(60),
                    height: ScreenUtil().setHeight(60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: blueColor,
                    ),
                    child: Center(
                      child: Text(
                        TextFormat.getInitials(this.name as String),
                        style: blackTextStyle.copyWith(
                            color: whiteColor, fontSize: 30.sp),
                      ),
                    )),
              )),
          Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.name.toString(),
                    style: regularTextStyle.copyWith(
                        fontSize: 21,
                        color: blueColor,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    this.isCurrency ?
                    CurrencyFormat.convertToIdr(
                        int.parse(this.value.toString()), 0) : this.value.toString(),
                    style: regularTextStyle.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: blueColor),
                  ),

                  Text(
                    this.isDate ?
                    CurrencyFormat.convertDateEpoch(
                        int.parse(this.date.toString())) : this.date.toString(),
                    style: regularTextStyle.copyWith(
                        fontSize: 12, color: blueColor),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 20.w),
            child: gambarIcon,
          )
        ],
      ),
    );
  }
}
