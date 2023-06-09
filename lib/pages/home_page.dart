import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
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
                        height: 30,
                      ),
                      Text('Laporan Singkat',
                          style: regularTextStyle.copyWith(
                              fontSize: 16,
                              color: blueColor,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 15,
                      ),
                      SummaryHome(DashboardResponse(data.dashboard, data.error)),
                      SizedBox(
                        height: 15,
                      ),
                      // SummaryHome(DashboardResponse(data.dashboard, data.error)),
                      // Spacer(),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.62,
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F6F8),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
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
