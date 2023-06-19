import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/bloc/bloc_shared_preference.dart';
import 'package:kita_warga_apps/bloc/kasbon/get_list_kasbon.dart';
import 'package:kita_warga_apps/bloc/kasbon/kasbon_bloc.dart';
import 'package:kita_warga_apps/components/dropdown_component.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/components/text_input_border_bottom.dart';
import 'package:kita_warga_apps/model/kasbon/get_list_kasbon_request.dart';
import 'package:kita_warga_apps/model/kasbon/kasbon_request.dart';
import 'package:kita_warga_apps/pages/warga/title_warga.dart';
import 'package:kita_warga_apps/repository/kasbon_repository.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:kita_warga_apps/utils/currency_format.dart';
import 'package:uuid/uuid.dart';

class AddKasbonPages extends StatefulWidget {
  const AddKasbonPages({Key? key}) : super(key: key);

  @override
  State<AddKasbonPages> createState() => _AddKasbonPagesState();
}

class _AddKasbonPagesState extends State<AddKasbonPages> {
  final TextEditingController _controllerAngsuranPerBulan =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      tenor = 1;
    });
  }

  static const List<String> listTenor = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];

  var uuid = Uuid();
  String dropdownValueTenor = listTenor.first;
  int tenor = 0;
  int pinjaman = 0;
  String id_kasbon = "";
  String tanggal_transaksi = "";
  String nama_karyawan = "";
  String id_karyawan = "";
  String detail_transaksi = "";
  String angsuran_per_bulan = "";
  String keterangan = "";

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    return RepositoryProvider(
      create: (context) => KasbonRepository(),
      child: BlocProvider(
        create: (context) => KasbonBloc(
            kasbonRepository: RepositoryProvider.of<KasbonRepository>(context)),
        child: Scaffold(
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
            child: ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                title_warga(
                  Title: "Tambah Kasbon",
                  SubTitle: "Silahkan tambah warga baru anda",
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                TextInputBorderBottom(
                  labelText: "Nama Karyawan",
                  hintText: "Masukkan nama karyawan",
                  onChanged: (value) {
                    setState(
                      () {
                        nama_karyawan = value;
                      },
                    );
                  },
                ),
                TextInputBorderBottom(
                  labelText: "Detail Transaksi",
                  hintText: "Masukkan Detail Transaksi",
                  onChanged: (value) {
                    setState(
                      () {
                        detail_transaksi = value;
                      },
                    );
                  },
                ),
                TextInputBorderBottom(
                  labelText: "Total Pinjaman",
                  hintText: "Masukkan nama karyawan",
                  onChanged: (value) {
                    setState(
                      () {
                        // print(CurrencyFormat.convertToIdr(value, 0));
                        pinjaman = int.parse(value);
                        double angsuranPerbulan = pinjaman / tenor;
                        _controllerAngsuranPerBulan.text = angsuranPerbulan
                                .isNaN
                            ? '0'
                            : CurrencyFormat.convertToIdr(angsuranPerbulan, 0)
                                .toString();
                      },
                    );
                  },
                ),
                dropdownCustom(
                    textHint: "Tenor",
                    title: "Pilih salah Tenor",
                    onChanged: (value) {
                      setState(() {
                        dropdownValueTenor = value!;
                        tenor = int.parse(value);
                        double angsuranPerbulan = pinjaman / tenor;
                        _controllerAngsuranPerBulan.text = angsuranPerbulan
                                .isNaN
                            ? '0'
                            : CurrencyFormat.convertToIdr(angsuranPerbulan, 0)
                                .toString();
                      });
                    },
                    dropdownValue: dropdownValueTenor,
                    list: listTenor),
                TextInputBorderBottom(
                  controllerText: _controllerAngsuranPerBulan,
                  enabled: false,
                  labelText: "Angsuran Per Bulan",
                  hintText: "Masukkan Angsuran perbulan",
                  onChanged: (value) {
                    setState(
                      () {
                        angsuran_per_bulan = value;
                      },
                    );
                  },
                ),
                TextInputBorderBottom(
                  labelText: "Keterangan",
                  hintText: "Masukkan Keterangan",
                  onChanged: (value) {
                    setState(
                      () {
                        keterangan = value;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(50),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.r),
                    child: BlocListener<KasbonBloc, AppServicesState>(
                      listener: (context, state) {
                        if (state is successServices) {
                          _reloadData(context);
                        }
                      },
                      child: BlocBuilder<KasbonBloc, AppServicesState>(
                        builder: (context, state) {
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
                    )),
                SizedBox(
                  height: ScreenUtil().setHeight(50),
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
    getListKasbonBloc..getListKasbon(GetListKasbonRequest(1, ""));
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
    BlockPreference blockPreference = BlockPreference();
    await blockPreference.getDataAccount();
    DateTime currentDate = DateTime.now();
    int epochSeconds = (currentDate.millisecondsSinceEpoch / 1000).round();
    if (nama_karyawan.isEmpty) {
      return Snack("Nama Warga tidak boleh kosong.");
    }
    if (detail_transaksi.isEmpty) {
      return Snack("Blok Rumah tidak boleh kosong.");
    }
    if (pinjaman.isNaN) {
      return Snack("Nomor Rumah tidak boleh kosong.");
    }
    if (tenor.isNaN) {
      return Snack("Nomor HP tidak boleh kosong.");
    }
    if (_controllerAngsuranPerBulan.text.isEmpty) {
      return Snack("Status Pernikahan tidak boleh kosong.");
    }
    if (keterangan.isEmpty) {
      return Snack("Jenis Kelamin tidak boleh kosong.");
    }

    BlocProvider.of<KasbonBloc>(context).add(
      KasbonRequest(
          uuid.v1(),
          epochSeconds.toString(),
          'arif',
          '0a08c662-0c0f-11ee-be56-0242ac120002',
          detail_transaksi,
          pinjaman.toString(),
          tenor.toString(),
          angsuran_per_bulan,
          keterangan),
    );
  }
}
