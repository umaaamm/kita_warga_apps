import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/bloc/bloc_shared_preference.dart';
import 'package:kita_warga_apps/bloc/kasbon/get_list_kasbon.dart';
import 'package:kita_warga_apps/bloc/kategori_bloc/get_list_kategori_bloc.dart';
import 'package:kita_warga_apps/bloc/pengeluaran/get_list_pengeluaran.dart';
import 'package:kita_warga_apps/bloc/pengeluaran/pengeluaran_bloc.dart';
import 'package:kita_warga_apps/components/alert_logout.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/components/text_input_border_bottom.dart';
import 'package:kita_warga_apps/model/kasbon/get_list_kasbon_request.dart';
import 'package:kita_warga_apps/model/kasbon/list_kasbon_response.dart';
import 'package:kita_warga_apps/model/kategori/kategori_response.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_request.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_request_add.dart';
import 'package:kita_warga_apps/pages/pengeluaran/ContentBottomSheetKasbon.dart';
import 'package:kita_warga_apps/pages/pengeluaran/ContentBottomSheetKategori.dart';
import 'package:kita_warga_apps/pages/warga/title_warga.dart';
import 'package:kita_warga_apps/repository/pengeluaran_repository.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:uuid/uuid.dart';

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
    getListKasbonBloc..getListKasbon(GetListKasbonRequest(1, ""));
    super.initState();
    setState(() {
      isRefresh = false;
    });
  }

  bool isRefresh = false;
  final TextEditingController _controllerNamaKategori = TextEditingController();
  final TextEditingController _controllerKasbon = TextEditingController();

  var uuid = Uuid();
  String nama_transaksi = "",
      id_kategori = "",
      tanggal_transaksi = "",
      nilai_transaksi = "",
      keterangan = "",
      bukti_foto = "bukti_foto",
      id_kasbon = "",
      kategori_transaksi = "";

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    return RepositoryProvider(
      create: (context) => PengeluaranRepository(),
      child: BlocProvider(
        create: (context) => PengeluaranBloc(
            pengeluaranRepository:
                RepositoryProvider.of<PengeluaranRepository>(context)),
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
                  controllerText: _controllerKasbon,
                  onPressed: () {
                    showBottomKasbon(context, _controllerKasbon);
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
                    child: BlocListener<PengeluaranBloc, AppServicesState>(
                      listener: (context, state) {
                        if (state is successServices) {
                          _reloadData(context);
                        }
                      },
                      child: BlocBuilder<PengeluaranBloc, AppServicesState>(
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

  Future<void> showBottomKategori(
      BuildContext context, TextEditingController controller) {
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

            return ContentBottomSheetKategori(
              controllerNamaKategori: controller,
              kategoriResponse: list,
              onPressed: (val) {
                _controllerNamaKategori.text = val.nama_kategori_transaksi;
                setState(() {
                  id_kategori = val.id_kategori;
                  kategori_transaksi = val.nama_kategori_transaksi;
                });
                Future.delayed(Duration.zero, () {
                  Navigator.pop(context);
                });
              },
            );
          },
        );
      },
    );
  }

  Future<void> showBottomKasbon(
      BuildContext context, TextEditingController controllerKasbon) {
    return showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder<ListKasbonResponse>(
          stream: getListKasbonBloc.subject.stream,
          builder: (context, AsyncSnapshot<ListKasbonResponse> snapshot) {
            if (!snapshot.hasData) {
              return _buildLoadingWidget();
            }

            if (snapshot.hasError) {
              if (snapshot.data!.isExpired.isExpired) {
                return AlertLogout();
              }
              return _buildErrorWidget(snapshot.error.toString());
            }

            final list = snapshot.data!;
            if (list.error != null && list.error!.isNotEmpty) {
              if (list.isExpired.isExpired) {
                return AlertLogout();
              }
              return _buildErrorWidget(list.error.toString());
            }
            ;

            if (list.listKasbon.isEmpty) {
              return _buildNoDataWidget();
            }

            return ContentBottomSheetKasbon(
              controllerNamaKategori: controllerKasbon,
              listKasbonResponse: list,
              onPressed: (val) {
                _controllerKasbon.text = val.detail_transaksi;
                setState(() {
                  id_kasbon = val.id_kasbon;
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  _reloadData(BuildContext context) {
    Navigator.pop(context);
    getListPengeluaranBloc
      ..getListPengeluaran(GetListPengeluaranRequest(1, ""));
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
                textAlign: TextAlign.center,
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
    BlockPreference blockPreference = BlockPreference();
    await blockPreference.getDataAccount();

    if (nama_transaksi.isEmpty) {
      return Snack("Nama Transaksi tidak boleh kosong.");
    }
    if (kategori_transaksi.isEmpty) {
      return Snack("Kategori Transaksi tidak boleh kosong.");
    }
    if (id_kasbon.isEmpty) {
      return Snack("Kasbon tidak boleh kosong.");
    }
    if (nilai_transaksi.isEmpty) {
      return Snack("Nilai Transaksi tidak boleh kosong.");
    }
    if (keterangan.isEmpty) {
      return Snack("Keterangan Pernikahan tidak boleh kosong.");
    }

    BlocProvider.of<PengeluaranBloc>(context).add(PengeluaranRequestAdd(
        uuid.v1(),
        nama_transaksi,
        id_kategori,
        id_kasbon,
        kategori_transaksi,
        DateTime.now().millisecondsSinceEpoch.toString(),
        nilai_transaksi,
        keterangan,
        bukti_foto));
  }
}
