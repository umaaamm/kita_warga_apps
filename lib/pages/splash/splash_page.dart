import 'package:flutter/material.dart';
import 'package:kita_warga_apps/pages/home_page.dart';
import 'package:kita_warga_apps/pages/login/login.dart';

import '../../bloc/bloc_shared_preference.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _initData() async {
    BlockPreference provider = BlockPreference();
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
