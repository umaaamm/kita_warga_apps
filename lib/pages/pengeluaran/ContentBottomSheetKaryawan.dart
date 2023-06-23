import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/kasbon/get_list_kasbon.dart';
import 'package:kita_warga_apps/components/rounded_input_search.dart';
import 'package:kita_warga_apps/model/karyawan/karyawan_response.dart';
import 'package:kita_warga_apps/model/kasbon/list_kasbon_response.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/currency_format.dart';

class ContentBottomSheetKaryawan extends StatefulWidget {
  final KaryawanResponse karyawanResponse;
  final Function onPressed;

  const ContentBottomSheetKaryawan({
    super.key,
    required this.onPressed,
    required this.karyawanResponse,
    required TextEditingController controllerNamaKaryawan,
  }) : _controllerKaryawan = controllerNamaKaryawan;

  final TextEditingController _controllerKaryawan;
  @override
  State<ContentBottomSheetKaryawan> createState() =>
      _ContentBottomSheetKaryawanPagesState();
}

class _ContentBottomSheetKaryawanPagesState
    extends State<ContentBottomSheetKaryawan> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              "Pilih Salah Satu Karyawan",
              style: regularTextStyle.copyWith(fontSize: 19, color: blueColor),
            ),
          ),
        ),
        Container(
          // margin: EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.karyawanResponse.karyawan.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){widget.onPressed(widget.karyawanResponse.karyawan[index]);},
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 20.h, right: 20.h, top: 5.h, bottom: 5.h),
                  child: Container(
                    decoration: BoxDecoration(
                        color: greyColorLight,
                        borderRadius: BorderRadius.circular(12.r)),
                    height: 90.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Nama : " +
                                  widget.karyawanResponse
                                      .karyawan[index].nama_karyawan,
                              style: regularTextStyle.copyWith(
                                  fontSize: 16, color: blueColor),
                            ),
                            Text(
                              "Posisi : " +
                                  widget.karyawanResponse
                                          .karyawan[index]
                                          .posisi,
                              style: regularTextStyle.copyWith(
                                  fontSize: 16, color: blueColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
