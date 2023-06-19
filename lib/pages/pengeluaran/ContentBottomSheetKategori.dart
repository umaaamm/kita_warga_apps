import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/model/kategori/kategori_response.dart';
import 'package:kita_warga_apps/theme.dart';

class ContentBottomSheetKategori extends StatefulWidget {
  final KategoriResponse kategoriResponse;
  final TextEditingController _controllerNamaKategori;
  final Function onPressed;
  const ContentBottomSheetKategori({
    super.key,
    required this.onPressed,
    required this.kategoriResponse,
    required TextEditingController controllerNamaKategori,
  }) : _controllerNamaKategori = controllerNamaKategori;

  @override
  State<ContentBottomSheetKategori> createState() =>
      _ContentBottomSheetKategoriPagesState();
}

class _ContentBottomSheetKategoriPagesState
    extends State<ContentBottomSheetKategori> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              "Pilih Salah Satu Kategori",
              style: regularTextStyle.copyWith(fontSize: 19, color: blueColor),
            ),
          ),
        ),
        Container(
          // margin: EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.kategoriResponse.kategori.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){widget.onPressed(widget.kategoriResponse.kategori[index]);},
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 20.h, right: 20.h, top: 5.h, bottom: 5.h),
                  child: Container(
                    decoration: BoxDecoration(
                        color: greyColorLight,
                        borderRadius: BorderRadius.circular(12.r)),
                    height: 50.h,
                    child: Center(
                      child: Text(
                        widget.kategoriResponse
                            .kategori[index].nama_kategori_transaksi,
                        style: regularTextStyle.copyWith(
                            fontSize: 17, color: blueColor),
                      ),
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
