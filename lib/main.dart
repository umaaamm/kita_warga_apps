import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/pages/splash/splash_page.dart';
import 'package:kita_warga_apps/repository/login_repository.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return RepositoryProvider(
          create: (BuildContext context) {
            return LoginRepository();
          },
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
          ),
        );
      },
    );
  }
}
