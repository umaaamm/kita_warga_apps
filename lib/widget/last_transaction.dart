import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kita_warga_apps/bloc/dashboard/get_dashboard_last_trx.dart';
import 'package:kita_warga_apps/components/alert_logout.dart';
import 'package:kita_warga_apps/model/dashboard/dashboard_last_trx.dart';
import 'package:kita_warga_apps/model/dashboard/dashboard_last_trx_response.dart';
import 'package:kita_warga_apps/pages/kas_bon/kas_bon_pages.dart';
import 'package:kita_warga_apps/pages/warga/warga_pages.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/currency_format.dart';
import 'package:kita_warga_apps/utils/text_format.dart';
import 'package:kita_warga_apps/widget/menu/menu_kasbon.dart';
import 'package:kita_warga_apps/widget/menu/menu_pengeluaran.dart';
import 'package:kita_warga_apps/widget/menu/menu_warga.dart';

class LastTransaction extends StatefulWidget {
  @override
  _LastTransactionState createState() => _LastTransactionState();
}

class _LastTransactionState extends State<LastTransaction> {
  @override
  void initState() {
    super.initState();
    dashboardLastTrxBloc..getDashboardLastTrx();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DashboardLastTrxResponse>(
      stream: dashboardLastTrxBloc.subject.stream,
      builder: (context, AsyncSnapshot<DashboardLastTrxResponse> snapshot) {
        if (!snapshot.hasData) {
          return _buildLoadingWidget();
        }

        if (snapshot.hasError) {
          if (snapshot.data!.responsExpired.isExpired) {
            return AlertLogout();
          }
          return _buildErrorWidget(snapshot.error.toString());
        }

        final list = snapshot.data!;
        if (list.error != null && list.error!.isNotEmpty) {
          if (list.responsExpired.isExpired) {
            return AlertLogout();
          }
          return _buildErrorWidget(list.error.toString());
        }
        ;

        return _resultWidget(list);
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _resultWidget(DashboardLastTrxResponse data) {
    List<DashboardLastTrx>? lastTrx = data.dashboardLastTrx;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin:
              EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w, bottom: 15.h),
          child: Text(
            'Fitur Aplikasi',
            style: blackTextStyle.copyWith(
              fontSize: 16.sp,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            menuPengeluaran(
              onPressed: () {},
            ),
            menuWarga(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WargaPages();
                    },
                  ),
                );
              },
            ),
            menuKasbon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return KasBonPages();
                    },
                  ),
                );
              },
            )
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin:
              EdgeInsets.only(top: 30.h, left: 15.w, right: 15.w, bottom: 20),
          child: Text(
            'Transaksi Terakhir',
            style: blackTextStyle.copyWith(
              fontSize: 16.sp,
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: whiteColor30,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.dashboardLastTrx.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  margin: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                      bottom: index == lastTrx.length - 1
                          ? ScreenUtil().setHeight(100)
                          : ScreenUtil().setHeight(8)),
                  decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.r,
                          ),
                          child: Center(
                            child: Container(
                                width: ScreenUtil().setWidth(70),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: whiteColor30,
                                ),
                                child: Center(
                                  child: Text(
                                    TextFormat.getInitials(
                                        lastTrx[index].nama.toString()),
                                    style: blackTextStyle.copyWith(
                                        color: whiteColor, fontSize: 45.sp),
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
                                lastTrx[index].nama,
                                style: regularTextStyle.copyWith(
                                    fontSize: 14.sp, color: yellowColor),
                              ),
                              Text(
                                CurrencyFormat.convertToIdr(
                                    int.parse(lastTrx[index].balance), 0),
                                style: regularTextStyle.copyWith(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w700,
                                    color: yellowColor),
                              ),
                              Text(
                                CurrencyFormat.convertDateEpoch(
                                    int.parse(lastTrx[index].tanggal)),
                                style: regularTextStyle.copyWith(
                                    fontSize: 12.sp, color: yellowColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: 20.w),
                        child: Icon(
                          int.parse(lastTrx[index].keterangan) == 1
                              ? Icons.arrow_circle_down
                              : Icons.arrow_circle_up,
                          color: int.parse(lastTrx[index].keterangan) == 1
                              ? Colors.red
                              : Colors.green,
                          size: 30.sp,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
