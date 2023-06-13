import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/bloc_shared_preference.dart';
import 'package:kita_warga_apps/pages/login/login.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/constant.dart';

class AlertLogout extends StatelessWidget {
  const AlertLogout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(

      child: AlertDialog(
        title: const Text('Sesi Berakhir'),
        content: Text(
          AppConstant.msgIxpired,
          style: regularTextStyle.copyWith(fontSize: 17.sp, color: blueColor),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => _logout(context),
            child: Text(
              'Keluar',
              style: regularTextStyle.copyWith(fontSize: 17.sp, color: blueColor),
            ),
          ),
        ],
      ),
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