import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/bloc/kategori_bloc/get_list_kategori_bloc.dart';
import 'package:kita_warga_apps/bloc/warga/get_list_warga.dart';
import 'package:kita_warga_apps/bloc/warga/warga_bloc.dart';
import 'package:kita_warga_apps/components/alert_logout.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/components/text_input_border_bottom.dart';
import 'package:kita_warga_apps/model/kategori/kategori_response.dart';
import 'package:kita_warga_apps/model/warga/get_list_warga_request.dart';
import 'package:kita_warga_apps/pages/warga/title_warga.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:uuid/uuid.dart';

import '../../../model/kategori/kategori.dart';
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
    getListKategoriBloc..getListKategori();
    super.initState();
    setState(() {
      isRefresh = false;
    });
  }

  bool isRefresh = false;

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
      id_kategori = "",
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
                TextInputBorderBottom(
                  controllerText: _controllerNamaKategori,
                  onPressed: () {
                    showBottomKategori(context, _controllerNamaKategori);
                  },
                  readOnly: true,
                  labelText: 'Pilih Kategori Transaksi',
                  hintText: "Pilih Kategori Transaksi",
                  onChanged: (value) {
                    nilai_transaksi = value;
                  },
                ),
                TextInputBorderBottom(
                  controllerText: _controllerNamaKategori,
                  onPressed: () {
                    showBottomKategori(context, _controllerNamaKategori);
                  },
                  readOnly: true,
                  labelText: 'Pilih Kasbon',
                  hintText: "Pilih Kasbon",
                  onChanged: (value) {
                    nilai_transaksi = value;
                  },
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

  Future<void> showBottomKategori(BuildContext context, TextEditingController controller) {
    return showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder<KategoriResponse>(
          stream: getListKategoriBloc.subject.stream,
          builder: (context, AsyncSnapshot<KategoriResponse> snapshot) {
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

            return ContentBottomSheetKategori(controllerNamaKategori: controller,kategoriResponse: list);
          },
        );
      },
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
                  Icons.account_balance_wallet,
                ),
                iconSize: 50,
                color: blueColor,
                splashColor: blueColor,
                onPressed: () {},
              ),
            ),
            Flexible(
              child: Text(
                "Data Pengeluaran yang anda cari tidak ditemukan.",
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

class ContentBottomSheetKategori extends StatelessWidget {
  final KategoriResponse kategoriResponse;
  const ContentBottomSheetKategori({
    super.key,
    required this.kategoriResponse,
    required TextEditingController controllerNamaKategori,
  }) : _controllerNamaKategori = controllerNamaKategori;

  final TextEditingController _controllerNamaKategori;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              "Pilih Salah Satu Kategori",
              style:
                  regularTextStyle.copyWith(fontSize: 19, color: blueColor),
            ),
          ),
        ),
        Container(
          // margin: EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: kategoriResponse.kategori.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                _controllerNamaKategori.text = kategoriResponse.kategori[index].nama_kategori_transaksi;
                Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 20.h, right: 20.h, top: 5.h, bottom: 5.h),
                  child: Container(
                    decoration: BoxDecoration(
                        color: greyColorLight,
                        borderRadius: BorderRadius.circular(12.r)),
                    height: 50.h,
                    child: Center(
                      child: Text(
                        kategoriResponse.kategori[index].nama_kategori_transaksi,
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
