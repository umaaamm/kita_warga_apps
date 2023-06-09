import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/pages/splash/splash_page.dart';
import 'package:kita_warga_apps/provider/login_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return ChangeNotifierProvider(
          create: (BuildContext context) {
            return LoginProvider();
          },
          child: const MaterialApp(
            home: SplashPage(),
          ),
        );
      },
      // child: ChangeNotifierProvider(
      //   create: (BuildContext context) {
      //     return LoginProvider();
      //   },
      //   child: const MaterialApp(
      //     home: SplashPage(),
      //   ),
      // ),
    );
  }
}
