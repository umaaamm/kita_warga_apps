import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/get_dashboard_last_trx.dart';
import 'package:kita_warga_apps/model/dashboard_last_trx.dart';
import 'package:kita_warga_apps/model/dashboard_last_trx_response.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/currency_format.dart';
import 'package:kita_warga_apps/utils/text_format.dart';

class ListKasBon extends StatefulWidget {
  const ListKasBon({super.key});

  @override
  State<ListKasBon> createState() => _ListKasBonState();
}

class _ListKasBonState extends State<ListKasBon> {
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
          return _buildErrorWidget(snapshot.error.toString());
        }

        final list = snapshot.data!;
        if (list.error != null && list.error!.isNotEmpty) {
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
              EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w, bottom: 12.h),
          child: Text(
            'Daftar Warga',
            style: blackTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.dashboardLastTrx.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  margin: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                      bottom: index == lastTrx.length - 1 ? 75.h : 8.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Center(
                            child: Container(
                                width: ScreenUtil().setWidth(70),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: blueColor,
                                ),
                                child: Center(
                                  child: Text(
                                    TextFormat.getInitials(
                                        lastTrx[index].nama as String),
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
                                    fontSize: 21,
                                    color: blueColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                CurrencyFormat.convertToIdr(
                                    int.parse(lastTrx[index].balance), 0),
                                style: regularTextStyle.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: blueColor),
                              ),
                              Text(
                                CurrencyFormat.convertDateEpoch(
                                    int.parse(lastTrx[index].tanggal)),
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
