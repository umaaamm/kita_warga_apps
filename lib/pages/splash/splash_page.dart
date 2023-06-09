import 'package:flutter/material.dart';
import 'package:kita_warga_apps/pages/home_page.dart';
import 'package:kita_warga_apps/pages/login/login.dart';
import 'package:kita_warga_apps/provider/login_provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _initData() async {
    LoginProvider provider = context.read<LoginProvider>();
    await provider.init();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return provider.token == null ? LoginPages() : HomePages();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
