import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/bloc_shared_preference.dart';
import 'package:kita_warga_apps/pages/login/login.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/currency_format.dart';

class TotalBalance extends StatelessWidget {
  final String totalSaldo;

  TotalBalance(this.totalSaldo);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: Container(
            height: ScreenUtil().setHeight(55),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Saldo (Pemasukan - Pengeluaran)',
                  style: regularTextStyle.copyWith(
                      fontSize: 12.sp, color: blueColor),
                ),
                Text(
                  CurrencyFormat.convertToIdr(int.parse(totalSaldo), 0),
                  style: blackTextStyle.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: blueColor),
                )
              ],
            ),
          ),
        ),
        Spacer(),
        GestureDetector(
          onDoubleTap: () {
            _logout(context);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/dummy/profile_picture.png",
              width: ScreenUtil().setWidth(50),
              height: ScreenUtil().setHeight(50),
            ),
          ),
        )

      ],
    );
  }
  Future<void> _logout(BuildContext context) async {
    BlockPreference provider = BlockPreference();
    await provider.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return LoginPages();
      }),
          (Route<dynamic> route) => false,
    );
  }
}
