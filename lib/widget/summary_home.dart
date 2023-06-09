import 'package:flutter/material.dart';
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
              height: 80,
              width: 180,
              color: whiteColor30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          'Total Pemasukan',
                          style: blueTextStyle.copyWith(fontSize: 14),
                        ),
                        Text(CurrencyFormat.convertToIdr(int.parse(dashboardResponse?.dashboard?.total_pemasukan_bulan_ini ?? "0"),0),
                            style: blueTextStyle.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w700))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Flexible(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 80,
              width: 180,
              color: whiteColor30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          'Total Pengeluaran',
                          style: blueTextStyle.copyWith(fontSize: 14),
                        ),
                        Text(CurrencyFormat.convertToIdr(int.parse(dashboardResponse?.dashboard?.total_pengeluaran_bulan_ini ?? "0"),0),
                            style: blueTextStyle.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w700))
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
