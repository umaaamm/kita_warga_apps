import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/pengeluaran/get_list_pengeluaran.dart';
import 'package:kita_warga_apps/bloc/warga/get_list_warga.dart';
import 'package:kita_warga_apps/components/rounded_input_search.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_request.dart';
import 'package:kita_warga_apps/model/warga/get_list_warga_request.dart';
import 'package:kita_warga_apps/pages/pengeluaran/list_pengeluaran.dart';
import 'package:kita_warga_apps/pages/warga/add_warga/add_warga_pages.dart';
import 'package:kita_warga_apps/pages/warga/list_shorting.dart';
import 'package:kita_warga_apps/pages/warga/list_warga.dart';
import 'package:kita_warga_apps/pages/warga/title_warga.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'dart:async';

import '../../theme.dart';
import 'add_pengeluaran/add_pengeluaran.dart';

class PengeluaranPages extends StatefulWidget {
  @override
  _PengeluaranPagesState createState() => _PengeluaranPagesState();
}

class _PengeluaranPagesState extends State<PengeluaranPages> {
  Timer? _debounce;

  var dataTest = ['Semua', 'Terbaru', 'A-z', 'Z-a'];
  bool isTapped = false;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              color: Colors.black,
              icon: new Icon(Icons.add_circle),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddPengeluaranPages();
                    },
                  ),
                );
              }),
        ],
        leading: IconButton(
            color: Colors.black,
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.maybePop(context);
            }),
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          // physics: ClampingScrollPhysics(),
          children: [
            const title_warga(
                Title: "Daftar Pengeluaran",
                SubTitle: "Daftar Pengeluaran yang anda Kelola"),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            ListShorting(
                dataTest: dataTest,
                onPressed: (index) {
                  getListWargaBloc
                    ..getListWarga(GetListWargaRequest(
                        AppConstant.valueShorting(dataTest[index]), ""));
                },
                isTapped: isTapped,
                isActive: 0),
            Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: RoundedInputSearch(
                hintText: "Masukkan pengeluaran",
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    getListPengeluaranBloc
                      ..getListPengeluaran(GetListPengeluaranRequest(3, value));
                  });
                },
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
              child: ListPengeluaranWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
