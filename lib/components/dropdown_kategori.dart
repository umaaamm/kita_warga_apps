
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/kategori_bloc/get_list_kategori_bloc.dart';
import 'package:kita_warga_apps/components/alert_logout.dart';
import 'package:kita_warga_apps/model/kategori/kategori.dart';
import 'package:kita_warga_apps/model/kategori/kategori_response.dart';

import '../theme.dart';
import '../utils/constant.dart';

class dropdownKategori extends StatefulWidget {
  final Kategori? dropdownValueParent;
  final void Function(Kategori?) onChanged;

  const dropdownKategori({
    super.key,
    required this.onChanged,
    required this.dropdownValueParent,
  });

  @override
  State<dropdownKategori> createState() => _dropdownKategoriState();
}

class _dropdownKategoriState extends State<dropdownKategori> {
  bool isRefresh = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListKategoriBloc..getListKategori();
    setState(() {
      isRefresh = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<KategoriResponse>(
      stream: getListKategoriBloc.subject.stream,
      builder: (context, AsyncSnapshot<KategoriResponse> snapshot) {
        print(snapshot);
        if (!snapshot.hasData) {
          return _buildLoadingWidget();
        }

        if (snapshot.hasError) {
          if (snapshot.data!.responsExpired.isExpired) {
            return AlertLogout();
          }
          return _buildErrorWidget(snapshot.error.toString());
        }

        final list = snapshot.data!;
        if (list.error != null && list.error!.isNotEmpty) {
          if (list.responsExpired.isExpired) {
            return AlertLogout();
          }
          return _buildErrorWidget(list.error.toString());
        }
        ;

        if (list.kategori.isEmpty) {
          return _buildNoDataWidget();
        }

        return ContainerDropDown(kategoriResponse: list,dropdownValue: widget.dropdownValueParent, onChanged: widget.onChanged,);
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(blueColor),
                strokeWidth: 4.0,
              ),
            )
          ],
        ));
  }


  Widget _buildNoDataWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(
                  Icons.supervised_user_circle,
                ),
                iconSize: 50,
                color: blueColor,
                splashColor: blueColor,
                onPressed: () {},
              ),
            ),
            Flexible(
              child: Text(
                "Data Warga yang anda cari tidak ditemukan.",
                textAlign:TextAlign.center,
                style:
                regularTextStyle.copyWith(fontSize: 16, color: blueColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isRefresh
                ? _buildLoadingWidget()
                : Container(
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(
                  Icons.refresh,
                ),
                iconSize: 50,
                color: blueColor,
                splashColor: blueColor,
                onPressed: () {
                  setState(() {
                    isRefresh = true;
                  });
                  getListKategoriBloc..getListKategori();
                },
              ),
            ),
            Text(
              isRefresh
                  ? "Sedang Mengambil Data"
                  : "Tekan Icon untuk mengulagi",
              style: regularTextStyle.copyWith(fontSize: 16, color: blueColor),
            ),
            Text(
              isRefresh ? "" : "Ops!, Terjadi kesalahan.",
              style: regularTextStyle.copyWith(fontSize: 16, color: blueColor),
            ),
          ],
        ),
      ),
    );
  }

}

class ContainerDropDown extends StatelessWidget {
  final Kategori? dropdownValue;
  final void Function(Kategori?) onChanged;
  final KategoriResponse kategoriResponse;
  const ContainerDropDown({
    super.key,
    required this.kategoriResponse,
    required this.dropdownValue,
    required this.onChanged
  });


  @override
  Widget build(BuildContext context) {
    print(dropdownValue?.nama_kategori_transaksi);

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: "Pilih Salah Satu Kategori",
          labelStyle:
          regularTextStyle.copyWith(fontSize: 16.sp, color: blueColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: blueColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: greyColorLight),
          ),
        ),
        child: Container(
          height: 30,
          child: DropdownButton<Kategori>(
            isExpanded: true,
            iconSize: 28,
            hint: Text(
              "Pilih Salah Satu Kategori",
              style: regularTextStyle.copyWith(
                  fontSize: 16.sp, color: greyColorLight),
            ),
            value: dropdownValue ?? kategoriResponse.kategori.first,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: blueColorConstant,
            ),
            elevation: 16,
            style: regularTextStyle.copyWith(fontSize: 16.sp, color: blueColor),
            underline: SizedBox(),
            onChanged: onChanged,
            items: kategoriResponse.kategori.map<DropdownMenuItem<Kategori>>((Kategori value) {
              return DropdownMenuItem<Kategori>(
                value: value,
                child: Text(value.nama_kategori_transaksi),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
