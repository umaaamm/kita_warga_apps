import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/components/checkbox_component.dart';
import 'package:kita_warga_apps/components/dropdown_component.dart';
import 'package:kita_warga_apps/components/text_input_border_bottom.dart';
import 'package:kita_warga_apps/pages/warga/title_warga.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/constant.dart';

class AddWargaPages extends StatefulWidget {
  const AddWargaPages({super.key});

  @override
  State<AddWargaPages> createState() => _AddWargaPagesState();
}

class _AddWargaPagesState extends State<AddWargaPages> {
  static const List<String> list = <String>[
    'Pilih Salah Satu',
    'Laki-Laki',
    'Perempuan'
  ];
  String dropdownValue = list.first;
  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
              title_warga(
                Title: "Tambah Warga",
                SubTitle: "Silahkan tambah warga baru anda",
              ),
              SizedBox(height: 20,),
              TextInputBorderBottom(
                  labelText: "Nama Warga",
                  hintText: "Masukkan nama warga",
                  onChanged: (value) {
                    print(value);
                  }),
              TextInputBorderBottom(
                  labelText: "Status Perkawinan",
                  hintText: "Masukkan status perkawinan",
                  onChanged: (value) {
                    print(value);
                  }),
              dropdownCustom(
                  textHint: "Jenis Kelamin",
                  title: "Pilih Jenis Kelamin",
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  dropdownValue: dropdownValue,
                  list: list),
              TextInputBorderBottom(
                  labelText: "Email",
                  hintText: "Masukkan email warga",
                  onChanged: (value) {
                    print(value);
                  }),
              TextInputBorderBottom(
                  labelText: "No Handphone",
                  hintText: "Masukkan nomor handphone",
                  onChanged: (value) {
                    print(value);
                  }),
              TextInputBorderBottom(
                  labelText: "Nomor Rumah",
                  hintText: "Masukkan Nomor rumah",
                  onChanged: (value) {
                    print(value);
                  }),
              TextInputBorderBottom(
                  labelText: "Blok Rumah",
                  hintText: "Masukkan blok rumah warga",
                  onChanged: (value) {
                    print(value);
                  }),
              TextInputBorderBottom(
                  labelText: "Nomor RT",
                  hintText: "Masukkan Nomor RT",
                  onChanged: (value) {
                    print(value);
                  }),
              TextInputBorderBottom(
                  labelText: "Nomor RW",
                  hintText: "Masukkan Nomor RW",
                  onChanged: (value) {
                    print(value);
                  }),
              checkboxRounded(
                  checkValue: checkValue,
                  title: "Apakah Warga Menjadi Ketua RW",
                  toggleCheckboxState: (value) {
                    setState(() {
                      checkValue = value!;
                    });
                  }),
            ],
          )),
    );
  }
}
