import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/model/dashboard_response.dart';
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
              height: 60.h,
              width: 180.h,
              color: whiteColor30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        Text(
                          'Total Pemasukan',
                          style: blueTextStyle.copyWith(fontSize: 12.sp),
                        ),
                        Text(
                            CurrencyFormat.convertToIdr(
                                int.parse(dashboardResponse?.dashboard
                                        ?.total_pemasukan_bulan_ini ??
                                    "0"),
                                0),
                            style: blueTextStyle.copyWith(
                                fontSize: 16.sp, fontWeight: FontWeight.w700))
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
              height: 60.h,
              width: 180.h,
              color: whiteColor30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        Text(
                          'Total Pengeluaran',
                          style: blueTextStyle.copyWith(fontSize: 12.sp),
                        ),
                        Text(
                            CurrencyFormat.convertToIdr(
                                int.parse(dashboardResponse?.dashboard
                                        ?.total_pengeluaran_bulan_ini ??
                                    "0"),
                                0),
                            style: blueTextStyle.copyWith(
                                fontSize: 16.sp, fontWeight: FontWeight.w700))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
