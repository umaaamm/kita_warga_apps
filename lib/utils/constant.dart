import 'package:flutter/material.dart';

const blueColorConstant = Color(0xFF0b093b);
const yellowColorConstant = Color(0xFFF2B300);
const kPrimaryLightColor = Color(0xFFF1E6FF);

class AppConstant {
  static const String accessToken = 'accessToken';
  static const String isLogin = 'is_login';
  static const String idPerumahan = 'idPerumahan';
  static const String idWarga = 'idWarga';
  static const String idPengurus = 'idPengurus';
  static const String isExpired = 'isExpired';
  static const String msgIxpired = 'Sesi Berakhir, Silahkan Login Ulang.';


  static int valueShorting(String shorting) {
    switch (shorting) {
      case 'Semua':
      case 'Terbaru':
        return 1;
      case 'A-z':
        return 1;
      case 'Z-a':
        return 2;
      default:
        return 1;
    }
  }
}
