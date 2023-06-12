import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/components/rounded_input_search.dart';
import 'package:kita_warga_apps/pages/kas_bon/list_kas_bon.dart';
import 'package:kita_warga_apps/pages/warga/list_shorting.dart';
import 'package:kita_warga_apps/pages/warga/list_warga.dart';
import 'package:kita_warga_apps/pages/warga/title_warga.dart';
import 'package:kita_warga_apps/theme.dart';

class KasBonPages extends StatefulWidget {
  const KasBonPages({super.key});

  @override
  State<KasBonPages> createState() => _KasBonPagesState();
}

class _KasBonPagesState extends State<KasBonPages> {
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
              onPressed: () {}),
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
            title_warga(Title: "Kas Bon", SubTitle: "Daftar Kas Bon"),
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
              padding: EdgeInsets.only(right: 20, left: 20, top: 5.r),
              child: RoundedInputSearch(
                hintText: "Masukkan nama karyawan",
                onChanged: (value) {},
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(5),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.635,
              decoration: BoxDecoration(
                color: greyColorLight,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r)),
              ),
              child: ListKasBon(),
            ),
          ],
        ),
      ),
    );
  }
}
