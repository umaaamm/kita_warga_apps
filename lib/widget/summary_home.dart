import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/model/dashboard/dashboard_response.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/currency_format.dart';

class SummaryHome extends StatelessWidget {
  final DashboardResponse? dashboardResponse;

  SummaryHome(this.dashboardResponse);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Flexible(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.w),
                    child: Stack(
                      children: [
                        Container(
                          height: ScreenUtil().setHeight(120),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Container(
                            width: ScreenUtil().setWidth(190),
                            child: Container(
                              child: Image.asset(
                                "assets/images/Chart/pemasukan/pemasukan.png",
                                height: ScreenUtil().setHeight(200),
                                width: ScreenUtil().setWidth(200),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 40.w,
                          right: 0.w,
                          bottom: 15.h,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 7.h),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Text(
                                  'Pemasukan',
                                  style: blackTextStyle.copyWith(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                    CurrencyFormat.convertToIdr(
                                        int.parse(dashboardResponse?.dashboard
                                                ?.total_pemasukan_bulan_ini ??
                                            "0"),
                                        0),
                                    style: blueTextStyle.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Flexible(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.w),
                    child: Stack(
                      children: [
                        Container(
                          height: 120.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Container(
                            width: 190.w,
                            child: Container(
                              child: Container(
                                child: Image.asset(
                                  "assets/images/Chart/pengeluaran/pengeluaran.png",
                                  height: ScreenUtil().setHeight(200),
                                  width: ScreenUtil().setWidth(200),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 40.w,
                          right: 0.w,
                          bottom: 15.h,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 7.r),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                Text(
                                  'Pengeluaran',
                                  style: blackTextStyle.copyWith(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                    CurrencyFormat.convertToIdr(
                                        int.parse(dashboardResponse?.dashboard
                                                ?.total_pengeluaran_bulan_ini ??
                                            "0"),
                                        0),
                                    style: blueTextStyle.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
