import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/bloc/bloc_shared_preference.dart';
import 'package:kita_warga_apps/bloc/warga/get_list_warga.dart';
import 'package:kita_warga_apps/bloc/warga/warga_bloc.dart';
import 'package:kita_warga_apps/components/dropdown_component.dart';
import 'package:kita_warga_apps/components/dropdown_kategori.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/components/switch_button.dart';
import 'package:kita_warga_apps/components/text_input_border_bottom.dart';
import 'package:kita_warga_apps/model/warga/get_list_warga_request.dart';
import 'package:kita_warga_apps/model/warga/warga_request.dart';
import 'package:kita_warga_apps/pages/warga/title_warga.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:uuid/uuid.dart';

import '../../../model/kategori/kategori.dart';
import '../../../model/kategori/kategori_response.dart';
import '../../../repository/warga_repository.dart';

class AddPengeluaranPages extends StatefulWidget {
  const AddPengeluaranPages({super.key});

  @override
  State<AddPengeluaranPages> createState() => _AddPengeluaranPagesState();
}

class _AddPengeluaranPagesState extends State<AddPengeluaranPages> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _selectedValue = Kategori("d4609ef0-0d8e-11ee-be56-0242ac120002", "pilih salah satu", "pilih salah satu");
  }
  final TextEditingController _controllerNamaKategori = TextEditingController();

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
  // String dropdownValue = list.first;
  // String dropdownValueKawin = listKawin.first;


  Kategori? _selectedValue;

  bool checkValueRT = false;
  bool checkValueRW = false;
  bool is_rw = false, is_rt = false;
  var uuid = Uuid();
  String id_warga = "",
      nama_transaksi = "",
      blok_rumah = "",
      keterangan = "",
      nama_kategori_transaksi = "",
      nilai_transaksi = "",
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
                  Title: "Tambah Pengeluaran",
                  SubTitle: "Silahkan tambah pengeluran baru anda",
                ),
                SizedBox(
                  height: 20,
                ),
                TextInputBorderBottom(
                    labelText: "Nama Transaksi",
                    hintText: "Masukkan nama Transaksi",
                    onChanged: (value) {
                      setState(() {
                        nama_transaksi = value;
                      });
                    }),
                dropdownKategori(
                    onChanged: (Kategori? newValue) {
                      setState(() {
                        // _selectedValue = newValue!;
                        _selectedValue = newValue!;
                        setState(() {
                          nama_kategori_transaksi = _controllerNamaKategori.text = newValue.nama_kategori_transaksi!;
                        });
                      });
                    },
                    dropdownValueParent: _selectedValue
                ),
                dropdownKategori(
                    onChanged: (Kategori? newValue) {
                      setState(() {
                        // _selectedValue = newValue!;
                        _selectedValue = newValue!;
                      });
                    },
                    dropdownValueParent: _selectedValue
                ),
                TextInputBorderBottom(
                    labelText: "Nilai Transaksi",
                    hintText: "Masukkan Nilai Transaksi",
                    onChanged: (value) {
                      nilai_transaksi = value;
                    }),
                TextInputBorderBottom(
                    labelText: "Keterangan",
                    hintText: "Masukkan Keterangan",
                    onChanged: (value) {
                      keterangan = value;
                    }),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Container(
                    key: scaffoldKey,
                    child: BlocListener<WargaBloc, AppServicesState>(
                      listener: (context, state) {
                        if (state is successServices) {
                          _reloadData(context);
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

  _reloadData(BuildContext context) {
    Navigator.pop(context);
    getListWargaBloc..getListWarga(GetListWargaRequest(1, ""));
    const snackBar = SnackBar(
      backgroundColor: blueColorConstant,
      behavior: SnackBarBehavior.floating,
      content: Text(
        'Data berhasil ditambah.',
        style: TextStyle(color: Colors.white, fontSize: 17),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  void Snack(String text) {
    final snackBar = SnackBar(
      content: Text(text,
          style:
          regularTextStyle.copyWith(fontSize: 16.sp, color: Colors.white)),
      backgroundColor: Colors.red,
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return;
  }

  void _postData(context) async {
    print(_selectedValue?.nama_kategori_transaksi);
    // BlockPreference blockPreference = BlockPreference();
    // await blockPreference.getDataAccount();
    //
    // if (nama_transaksi.isEmpty) {
    //   return Snack("Nama Warga tidak boleh kosong.");
    // }
    // if (blok_rumah.isEmpty) {
    //   return Snack("Blok Rumah tidak boleh kosong.");
    // }
    // if (nomor_rumah.isEmpty) {
    //   return Snack("Nomor Rumah tidak boleh kosong.");
    // }
    // if (!EmailValidator.validate(email)) {
    //   return Snack("Email tidak sesuai.");
    // }
    // if (nomor_hp.isEmpty) {
    //   return Snack("Nomor HP tidak boleh kosong.");
    // }
    // if (status_pernikahan.isEmpty) {
    //   return Snack("Status Pernikahan tidak boleh kosong.");
    // }
    // if (jenis_kelamin.isEmpty) {
    //   return Snack("Jenis Kelamin tidak boleh kosong.");
    // }
    // if (id_rw.isEmpty) {
    //   return Snack("RT tidak boleh kosong.");
    // }
    // if (id_rt.isEmpty) {
    //   return Snack("RT tidak boleh kosong.");
    // }
    //
    // BlocProvider.of<WargaBloc>(context).add(
    //   WargaRequest(
    //       uuid.v1(),
    //       nama_transaksi,
    //       blok_rumah,
    //       nomor_rumah,
    //       email,
    //       nomor_hp,
    //       is_rw,
    //       is_rt,
    //       id_rw,
    //       id_rt,
    //       blockPreference.idPerumahan ?? "",
    //       status_pernikahan,
    //       jenis_kelamin),
    // );
  }
}
