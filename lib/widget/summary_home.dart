import 'package:flutter/material.dart';
import 'package:kita_warga_apps/theme.dart';

class SummaryHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 80,
                width: 180,
                color: whiteColor30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Text('Total Pengeluaran', style: blueTextStyle.copyWith(fontSize: 14 ),),
                          Text('Rp 1.234.234', style: blueTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w700 ))
                        ],
                      ),
                    )
                  ],
                ),
              ),),
            SizedBox(
              width: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 80,
                width: 180,
                color: whiteColor30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Text('Total Pengeluaran', style: blueTextStyle.copyWith(fontSize: 14 ),),
                          Text('Rp 1.234.234', style: blueTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w700 ))
                        ],
                      ),
                    )
                  ],
                ),
              ),)
          ]),
    );
  }
}
