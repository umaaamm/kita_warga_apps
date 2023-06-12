import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/bloc/bloc_shared_preference.dart';
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
import 'package:uuid/uuid.dart';

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
  static const List<String> listKawin = <String>[
    'Pilih Salah Satu',
    'Nikah',
    'Lajang',
    'Duda',
    'Janda'
  ];
  String dropdownValue = list.first;
  String dropdownValueKawin = listKawin.first;

  bool checkValueRT = false;
  bool checkValueRW = false;
  bool is_rw = false, is_rt = false;
  var uuid = Uuid();
  String id_warga = "",
      nama_warga = "",
      blok_rumah = "",
      nomor_rumah = "",
      email = "",
      nomor_hp = "",
      id_rt = "",
      id_rw = "",
      id_perumahan = "",
      status_pernikahan = "",
      jenis_kelamin = "";

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
                      setState(() {
                        nama_warga = value;
                      });
                    }),
                dropdownCustom(
                    textHint: "Status Perkawinan",
                    title: "Pilih salah status perkawinan",
                    onChanged: (value) {
                      setState(() {
                        dropdownValueKawin = value!;
                        status_pernikahan = value;
                      });
                    },
                    dropdownValue: dropdownValueKawin,
                    list: listKawin),
                dropdownCustom(
                    textHint: "Jenis Kelamin",
                    title: "Pilih Jenis Kelamin",
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value!;
                        jenis_kelamin = value;
                      });
                    },
                    dropdownValue: dropdownValue,
                    list: list),
                TextInputBorderBottom(
                    labelText: "Email",
                    hintText: "Masukkan email warga",
                    onChanged: (value) {
                      email = value;
                    }),
                TextInputBorderBottom(
                    labelText: "No Handphone",
                    hintText: "Masukkan nomor handphone",
                    onChanged: (value) {
                      nomor_hp = value;
                    }),
                TextInputBorderBottom(
                    labelText: "Nomor Rumah",
                    hintText: "Masukkan Nomor rumah",
                    onChanged: (value) {
                      nomor_rumah = value;
                    }),
                TextInputBorderBottom(
                    labelText: "Blok Rumah",
                    hintText: "Masukkan blok rumah warga",
                    onChanged: (value) {
                      blok_rumah = value;
                    }),
                TextInputBorderBottom(
                    labelText: "Nomor RT",
                    hintText: "Masukkan Nomor RT",
                    onChanged: (value) {
                      id_rt = value;
                    }),
                TextInputBorderBottom(
                    labelText: "Nomor RW",
                    hintText: "Masukkan Nomor RW",
                    onChanged: (value) {
                      id_rw = value;
                    }),
                SwitchButton(
                  title: "Apakah Warga Menjadi Ketua RT",
                  toggleSwitchState: (value) {
                    setState(() {
                      checkValueRT = value!;
                      is_rt = value!;
                    });
                  },
                  checkValue: checkValueRT,
                ),
                SwitchButton(
                  title: "Apakah Warga Menjadi Ketua RW",
                  toggleSwitchState: (value) {
                    setState(() {
                      checkValueRW = value!;
                      is_rw = value!;
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


  void Snack(String text){
    final snackBar = SnackBar(
      content: Text(text, style: regularTextStyle.copyWith(fontSize: 16.sp,color: Colors.white)),
      backgroundColor: Colors.red,
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return;
  }

  void _postData(context) async {
    BlockPreference blockPreference = BlockPreference();
    await blockPreference.getDataAccount();

    if(nama_warga.isEmpty){
      return Snack("Nama Warga tidak boleh kosong.");
    }
    if(blok_rumah.isEmpty){
      return Snack("Blok Rumah tidak boleh kosong.");
    }
    if(nomor_rumah.isEmpty){
      return Snack("Nomor Rumah tidak boleh kosong.");
    }
    if(!EmailValidator.validate(email)){
      return Snack("Email tidak sesuai.");
    }
    if(nomor_hp.isEmpty){
      return Snack("Nomor HP tidak boleh kosong.");
    }
    if(status_pernikahan.isEmpty){
      return Snack("Status Pernikahan tidak boleh kosong.");
    }
    if(jenis_kelamin.isEmpty){
      return Snack("Jenis Kelamin tidak boleh kosong.");
    }
    if(id_rw.isEmpty){
      return Snack("RT tidak boleh kosong.");
    }
    if(id_rt.isEmpty){
      return Snack("RT tidak boleh kosong.");
    }


    BlocProvider.of<WargaBloc>(context).add(
      WargaRequest(
          uuid.v1(),
          nama_warga,
          blok_rumah,
          nomor_rumah,
          email,
          nomor_hp,
          is_rw,
          is_rt,
          id_rw,
          id_rt,
          blockPreference.idPerumahan ?? "",
          status_pernikahan,
          jenis_kelamin),
    );
  }
}
