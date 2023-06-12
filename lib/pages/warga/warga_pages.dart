import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/components/rounded_input_search.dart';
import 'package:kita_warga_apps/pages/warga/list_shorting.dart';
import 'package:kita_warga_apps/pages/warga/list_warga.dart';
import 'package:kita_warga_apps/pages/warga/title_warga.dart';

import '../../theme.dart';

class WargaPages extends StatefulWidget {
  @override
  _WargaPagesState createState() => _WargaPagesState();
}

class _WargaPagesState extends State<WargaPages> {
  var dataTest = ['Semua', 'Terbaru', 'A-z', 'Z-a', 'Terlama'];
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          new IconButton(
              color: Colors.black,
              icon: new Icon(Icons.add_circle),
              onPressed: () {
                print("hahah");
              }),
        ],
        leading: new IconButton(
            color: Colors.black,
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            title_warga(),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            ListShorting(
                dataTest: dataTest,
                onPressed: () {
                  print("hahaha");
                },
                isTapped: isTapped,
                isActive: 0),
            Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: RoundedInputSearch(
                hintText: "Masukkan nama warga",
                onChanged: (value) {},
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.635,
              decoration: BoxDecoration(
                color: greyColorLight,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r)),
              ),
              child: ListWarga(),
            ),
          ],
        ),
      ),
    );
  }
}
