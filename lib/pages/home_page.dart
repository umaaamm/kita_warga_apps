import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/get_dashboard_last_trx.dart';
import 'package:kita_warga_apps/model/dashboard.dart';
import 'package:kita_warga_apps/model/dashboard_response.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/widget/floating_footer.dart';
import 'package:kita_warga_apps/widget/last_transaction.dart';
import 'package:kita_warga_apps/widget/summary_home.dart';
import 'package:kita_warga_apps/widget/total_balance.dart';

import '../bloc/get_dashboard.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  void initState() {
    super.initState();
    dashboardBloc..getDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DashboardResponse>(
      stream: dashboardBloc.subject.stream,
      builder: (context, AsyncSnapshot<DashboardResponse> snapshot) {
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

  Widget _resultWidget(DashboardResponse data) {
    return Scaffold(
      body: Scaffold(
        body: Container(
          color: yellowColor,
          padding: EdgeInsets.only(top: 25),
          child: SafeArea(
            bottom: false,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      TotalBalance(data.dashboard.total_saldo),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text('Laporan Singkat kali',
                          style: regularTextStyle.copyWith(
                              fontSize: 14.sp,
                              color: blueColor,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 15.h,
                      ),
                      SummaryHome(
                        DashboardResponse(data.dashboard, data.error),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 450.h,
                  decoration: BoxDecoration(
                    color: lightBackground,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35.r),
                        topRight: Radius.circular(35.r)),
                  ),
                  child: LastTransaction(),
                ),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: FloatingFooter(),
        floatingActionButton: FloatingFooter(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
