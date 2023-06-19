import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/bloc_shared_preference.dart';
import 'package:kita_warga_apps/components/alert_logout.dart';
import 'package:kita_warga_apps/model/dashboard/dashboard_response.dart';
import 'package:kita_warga_apps/pages/login/login.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:kita_warga_apps/widget/floating_footer.dart';
import 'package:kita_warga_apps/widget/last_transaction.dart';
import 'package:kita_warga_apps/widget/summary_home.dart';
import 'package:kita_warga_apps/widget/total_balance.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../bloc/dashboard/get_dashboard.dart';

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
  void dispose() {
    super.dispose();
    dashboardBloc..drainStream();
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
          if (snapshot.data!.responseExpired.isExpired) {
            return AlertLogout();
          }
          return _buildErrorWidget(snapshot.error.toString());
        }

        final list = snapshot.data!;
        if (list.error != null && list.error!.isNotEmpty) {
          if (snapshot.data!.responseExpired.isExpired) {
            return AlertLogout();
          }
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

  Future<void> _refreshDashboard() async {
    dashboardBloc..getDashboard();
  }

  Widget _resultWidget(DashboardResponse data) {
    return Scaffold(
      body: Scaffold(
        body: Container(
          color: yellowColor,
          padding: EdgeInsets.only(top: 25),
          child: SafeArea(
            bottom: false,
            child: LiquidPullToRefresh(
              springAnimationDurationInMilliseconds: 700,
              height: 80,
              backgroundColor: blueColor,
              color: yellowColor,
              showChildOpacityTransition: false,
              onRefresh: _refreshDashboard, // refresh callback
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.r),
                    child: Column(
                      children: [
                        TotalBalance(data.dashboard.total_saldo),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text('Laporan Singkat',
                            style: regularTextStyle.copyWith(
                                fontSize: 14.sp,
                                color: blueColor,
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: 10.h,
                        ),
                        SummaryHome(
                          DashboardResponse(
                              data.dashboard, data.error, data.responseExpired),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: ScreenUtil().setHeight(400),
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
        ),
        // bottomNavigationBar: FloatingFooter(),
        floatingActionButton: FloatingFooter(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
