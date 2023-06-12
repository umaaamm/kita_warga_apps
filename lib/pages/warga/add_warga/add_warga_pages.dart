import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/bloc/warga_bloc.dart';
import 'package:kita_warga_apps/components/checkbox_component.dart';
import 'package:kita_warga_apps/components/dropdown_component.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/components/switch_button.dart';
import 'package:kita_warga_apps/components/text_input_border_bottom.dart';
import 'package:kita_warga_apps/model/warga_request.dart';
import 'package:kita_warga_apps/pages/warga/title_warga.dart';
import 'package:kita_warga_apps/pages/warga/warga_pages.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/constant.dart';

import '../../../repository/warga_repository.dart';

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
  bool checkValueRT = false;
  bool checkValueRW = false;
  String id_warga = "1",
      nama_warga = "umam",
      blok_rumah = "V",
      nomor_rumah = "23",
      email = "umam.tekno@gmail.com",
      nomor_hp = "081290766692",
      is_rw = "false",
      is_rt = "true",
      id_rt = "1",
      id_rw = "1",
      id_perumahan = "1",
      status_pernikahan = "kawin",
      jenis_kelamin = "laki-laki";

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

    return RepositoryProvider(
      create: (context) => WargaRepository(),
      child: BlocProvider(
        create: (context) => WargaBloc(
            wargaRepository: RepositoryProvider.of<WargaRepository>(context)),
        child: Scaffold(
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
                SizedBox(
                  height: 20,
                ),
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
                SwitchButton(
                  title: "Apakah Warga Menjadi Ketua RT",
                  toggleSwitchState: (value) {
                    setState(() {
                      checkValueRT = value!;
                    });
                  },
                  checkValue: checkValueRT,
                ),
                SwitchButton(
                  title: "Apakah Warga Menjadi Ketua RW",
                  toggleSwitchState: (value) {
                    setState(() {
                      checkValueRW = value!;
                    });
                  },
                  checkValue: checkValueRW,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    key: scaffoldKey,
                    child: BlocListener<WargaBloc, AppServicesState>(
                      listener: (context, state) {
                        if (state is successServices) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return WargaPages();
                              },
                            ),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                      child: BlocBuilder<WargaBloc, AppServicesState>(
                        builder: (context, state) {
                          print(state);
                          if (state is loadingServices) {
                            return _buildLoadingWidget();
                          } else if (state is errorServices) {
                            return const Center(child: Text("Error"));
                          }
                          return RoundedButton(
                            text: "Simpan",
                            onPressed: () {
                              _postData(context);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

  void _postData(context) {
    BlocProvider.of<WargaBloc>(context).add(
      WargaRequest(
          id_warga,
          nama_warga,
          blok_rumah,
          nomor_rumah,
          email,
          nomor_hp,
          is_rw,
          is_rt,
          id_rw,
          id_rt,
          id_perumahan,
          status_pernikahan,
          jenis_kelamin),
    );
  }
}
