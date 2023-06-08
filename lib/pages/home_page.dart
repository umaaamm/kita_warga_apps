import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/widget/floating_footer.dart';
import 'package:kita_warga_apps/widget/last_transaction.dart';
import 'package:kita_warga_apps/widget/summary_home.dart';
import 'package:kita_warga_apps/widget/total_balance.dart';

class HomePages extends StatelessWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        TotalBalance(),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Laporan Singkat', style: regularTextStyle.copyWith(fontSize: 16, color: blueColor, fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: 15,
                        ),
                        SummaryHome(),
                        SizedBox(
                          height: 15,
                        ),
                        SummaryHome(),
                        Spacer(),
                      ],
                    ),
                  ),
                  Container(
                    height: 530,
                    decoration: BoxDecoration(
                    color: Color(0xFFF4F6F8),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)
                      ),
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
    );
  }
}
