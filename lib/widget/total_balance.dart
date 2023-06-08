import 'package:flutter/material.dart';
import 'package:kita_warga_apps/theme.dart';

class TotalBalance extends StatelessWidget {
  const TotalBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: Container(
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Saldo', style: regularTextStyle.copyWith(fontSize: 12, color: blueColor),),
                Text('Rp 2.345.678', style: blackTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700, color: blueColor),)
              ],
            ),
          ),
        ),
        Spacer(),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            "assets/dummy/profile_picture.png",
            width: 50,
            height: 50,
          ),
        )
      ],
    );
  }
}
