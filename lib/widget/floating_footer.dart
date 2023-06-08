import 'package:flutter/material.dart';
import 'package:kita_warga_apps/theme.dart';

class FloatingFooter extends StatelessWidget {
  const FloatingFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width - (2 * 24),
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(23)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home,
                color: blueColor,
                size: 30.0,
              ),
              Text('Beranda', style: blackTextStyle.copyWith(color: blueColor, fontSize: 12),)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle,
                color: blueColor,
                size: 30.0,
              ),
              Text('Tambah Data', style: blackTextStyle.copyWith(color: blueColor, fontSize: 12),)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                color: blueColor,
                size: 30.0,
              ),
              Text('Profil', style: blackTextStyle.copyWith(color: blueColor, fontSize: 12),)
            ],
          ),
        ],
      ),
    );
  }
}
