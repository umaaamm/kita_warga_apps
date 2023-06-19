import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/bloc/pengeluaran/get_list_pengeluaran.dart';
import 'package:kita_warga_apps/bloc/pengeluaran/pengeluaran_bloc.dart';
import 'package:kita_warga_apps/bloc/warga/get_list_warga.dart';
import 'package:kita_warga_apps/bloc/warga/warga_bloc.dart';
import 'package:kita_warga_apps/components/alert_logout.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_delete_request.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_request.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_response.dart';
import 'package:kita_warga_apps/model/warga/get_list_warga_request.dart';
import 'package:kita_warga_apps/repository/pengeluaran_repository.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:kita_warga_apps/utils/currency_format.dart';
import 'package:kita_warga_apps/utils/text_format.dart';

class ListPengeluaranWidget extends StatefulWidget {
  @override
  _ListPengeluaranWidgetState createState() => _ListPengeluaranWidgetState();
}

class _ListPengeluaranWidgetState extends State<ListPengeluaranWidget> {
  bool isRefresh = false;
  @override
  void initState() {
    super.initState();
    getListPengeluaranBloc..getListPengeluaran(GetListPengeluaranRequest(1, ""));
    setState(() {
      isRefresh = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PengeluaranResponse>(
      stream: getListPengeluaranBloc.subject.stream,
      builder: (context, AsyncSnapshot<PengeluaranResponse> snapshot) {
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
        };

        if (list.pengeluaran.isEmpty) {
          return _buildNoDataWidget();
        }

        return _resultWidget(list);
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

  Future<void> showBottom(BuildContext context, Pengeluaran pengeluaran) {
    return showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return RepositoryProvider(
          create: (context) => PengeluaranRepository(),
          child: BlocProvider(
            create: (context) => PengeluaranBloc(
                pengeluaranRepository:
                RepositoryProvider.of<PengeluaranRepository>(context)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 30),
                        child: Text(
                          "Apakah anda yakin ingin menghapus data " +
                              pengeluaran.nama_transaksi +
                              "?",
                          style: regularTextStyle.copyWith(
                              fontSize: 19, color: blueColor),
                        ),
                      ),
                    ),
                    Container(
                      child: BlocListener<PengeluaranBloc, AppServicesState>(
                        listener: (context, state) {
                          if (state is successServices) {
                            return WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => _reloadData(context));
                          }
                        },
                        child: BlocBuilder<PengeluaranBloc, AppServicesState>(
                          builder: (context, state) {
                            if (state is loadingServices) {
                              return _buildLoadingWidget();
                            } else if (state is errorServices) {
                              return const Center(
                                  child: Text("Gagal Menghapus Data"));
                            }
                            return Column(
                              children: [
                                RoundedButton(
                                  text: "Hapus",
                                  color: Colors.red,
                                  onPressed: () {
                                    BlocProvider.of<PengeluaranBloc>(context)
                                        .add(
                                      PengeluaranDeleteRequest(pengeluaran.id_transaksi),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 30),
                                  child: RoundedButton(
                                    text: "Batal",
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _reloadData(BuildContext context) {
    Navigator.pop(context);
    getListPengeluaranBloc..getListPengeluaran(GetListPengeluaranRequest(1, ""));
    const snackBar = SnackBar(
      backgroundColor: blueColorConstant,
      behavior: SnackBarBehavior.floating,
      content: Text(
        'Data berhasil dihapus.',
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
                  getListPengeluaranBloc
                    ..getListPengeluaran(GetListPengeluaranRequest(1, ""));
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

  Widget _resultWidget(PengeluaranResponse data) {
    List<Pengeluaran> listPengeluaran = data.pengeluaran;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin:
          EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w, bottom: 12.h),
          child: Text(
            'Daftar Warga',
            style: blackTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.pengeluaran.length,
              itemBuilder: (context, index) {
                final item = data.pengeluaran[index];
                return RepositoryProvider(
                  create: (context) => PengeluaranRepository(),
                  child: BlocProvider(
                    create: (context) => PengeluaranBloc(
                        pengeluaranRepository:
                        RepositoryProvider.of<PengeluaranRepository>(context)),
                    child: Dismissible(
                      direction: DismissDirection.endToStart,
                      key: Key(item.id_transaksi),
                      confirmDismiss: (direction) async {
                        showBottom(context, listPengeluaran[index]);
                      },
                      background: Padding(
                        padding: EdgeInsets.only(right: 10.h, left: 10.h),
                        child: Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    "Delete",
                                    style: regularTextStyle.copyWith(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                )
                              ]),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.red,
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return DetailWarga(listWarga: listPengeluaran[index]);
                          //     },
                          //   ),
                          // );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          margin: EdgeInsets.only(
                              left: 10.w,
                              right: 10.w,
                              bottom:
                              index == listPengeluaran.length - 1 ? 75.h : 8.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r)),
                          child: Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Center(
                                    child: Container(
                                        width: ScreenUtil().setWidth(70),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10.r),
                                          color: blueColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            TextFormat.getInitials(
                                                listPengeluaran[index].kategori_transaksi
                                                as String),
                                            style: blackTextStyle.copyWith(
                                                color: whiteColor,
                                                fontSize: 45.sp),
                                          ),
                                        )),
                                  )),
                              Center(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listPengeluaran[index].nama_transaksi,
                                        style: regularTextStyle.copyWith(
                                            fontSize: 21,
                                            color: blueColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        CurrencyFormat.convertToIdr(int.parse(listPengeluaran[index].nilai_transaksi), 0),
                                        style: regularTextStyle.copyWith(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: blueColor),
                                      ),
                                      Text(
                                        CurrencyFormat.convertDateEpoch(int.parse(listPengeluaran[index].tanggal_transaksi)),
                                        style: regularTextStyle.copyWith(
                                            fontSize: 12, color: blueColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.only(right: 20.w),
                                child: Icon(
                                  Icons.supervised_user_circle,
                                  size: 30.sp,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
