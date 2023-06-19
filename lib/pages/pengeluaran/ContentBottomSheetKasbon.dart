import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/model/kasbon/list_kasbon_response.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/currency_format.dart';

class ContentBottomSheetKasbon extends StatefulWidget {
  final ListKasbonResponse listKasbonResponse;
  final Function onPressed;
  const ContentBottomSheetKasbon({
    super.key,
    required this.onPressed,
    required this.listKasbonResponse,
    required TextEditingController controllerNamaKategori,
  }) : _controllerKasbon = controllerNamaKategori;

  final TextEditingController _controllerKasbon;
  @override
  State<ContentBottomSheetKasbon> createState() =>
      _ContentBottomSheetKategoriPagesState();
}

class _ContentBottomSheetKategoriPagesState
    extends State<ContentBottomSheetKasbon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              "Pilih Salah Satu Kasbon",
              style: regularTextStyle.copyWith(fontSize: 19, color: blueColor),
            ),
          ),
        ),
        Container(
          // margin: EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.listKasbonResponse.listKasbon.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){widget.onPressed(widget.listKasbonResponse.listKasbon[index]);},
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
                                  widget.listKasbonResponse
                                      .listKasbon[index].nama_karyawan +
                                  " - " +
                                  CurrencyFormat.convertToIdr(
                                      int.parse(widget.listKasbonResponse
                                          .listKasbon[index].pinjaman),
                                      0) +
                                  " - " +
                                  widget.listKasbonResponse.listKasbon[index].tenor +
                                  " Bulan",
                              style: regularTextStyle.copyWith(
                                  fontSize: 16, color: blueColor),
                            ),
                            Text(
                              "Angsuran perbulan : " +
                                  CurrencyFormat.convertToIdr(
                                      int.parse(widget.listKasbonResponse
                                          .listKasbon[index]
                                          .angsuran_per_bulan),
                                      0),
                              style: regularTextStyle.copyWith(
                                  fontSize: 16, color: blueColor),
                            ),
                            Text(
                              "Deskripsi : " +
                                  widget.listKasbonResponse
                                      .listKasbon[index].detail_transaksi,
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
