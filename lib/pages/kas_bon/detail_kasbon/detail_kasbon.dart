import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/bloc/kasbon/get_list_kasbon.dart';
import 'package:kita_warga_apps/bloc/kasbon/kasbon_bloc.dart';
import 'package:kita_warga_apps/components/list/list_detail.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/model/kasbon/get_list_kasbon_request.dart';
import 'package:kita_warga_apps/model/kasbon/kasbon_delete_request.dart';
import 'package:kita_warga_apps/model/kasbon/list_kasbon.dart';
import 'package:kita_warga_apps/repository/kasbon_repository.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:kita_warga_apps/utils/currency_format.dart';
import 'package:kita_warga_apps/utils/text_format.dart';

class DetailKasbon extends StatefulWidget {
  final ListKasbon listKasbon;
  const DetailKasbon({Key? key, required this.listKasbon});

  @override
  State<DetailKasbon> createState() => _DetailKasbonState();
}

class _DetailKasbonState extends State<DetailKasbon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(color: yellowColor),
            child: Container(
                height: ScreenUtil().setHeight(200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      TextFormat.getInitials(widget.listKasbon.nama_karyawan),
                      style: whiteTextStyle.copyWith(
                          fontSize: 60.sp, color: blueColor),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(0.h),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: ScreenUtil().setWidth(5.h),
                        ),
                        GestureDetector(
                          onTap: () {
                            showBottom(context, widget.listKasbon);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: blueColor,
                                borderRadius: BorderRadius.circular(15.r)),
                            child: Text(
                              'Delete',
                              style: whiteTextStyle,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 30.r),
              child: Column(
                children: [
                  ListDetailComponent(
                    title: 'Nama Karyawan',
                    desc: widget.listKasbon.nama_karyawan,
                  ),
                  ListDetailComponent(
                    title: 'Jabatan',
                    desc: widget.listKasbon.posisi,
                  ),
                  ListDetailComponent(
                    title: 'Angsuran',
                    desc: CurrencyFormat.convertToIdr(
                        int.parse(widget.listKasbon.angsuran_per_bulan), 0),
                  ),
                  ListDetailComponent(
                    title: 'Total Tenor',
                    desc: widget.listKasbon.tenor,
                  ),
                  ListDetailComponent(
                    title: 'Sisa Kasbon',
                    desc: CurrencyFormat.convertToIdr(
                        int.parse(widget.listKasbon.sisa_kasbon), 0),
                  ),
                  ListDetailComponent(
                    title: 'Detail Transaksi',
                    desc: widget.listKasbon.detail_transaksi,
                  ),
                  ListDetailComponent(
                    title: 'Keterangan',
                    desc: widget.listKasbon.keterangan,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> showBottom(BuildContext context, ListKasbon listKasbon) {
    return showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return RepositoryProvider(
          create: (context) => KasbonRepository(),
          child: BlocProvider(
            create: (context) => KasbonBloc(
                kasbonRepository:
                    RepositoryProvider.of<KasbonRepository>(context)),
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
                              listKasbon.nama_karyawan +
                              "?",
                          style: regularTextStyle.copyWith(
                              fontSize: 19, color: blueColor),
                        ),
                      ),
                    ),
                    Container(
                      child: BlocListener<KasbonBloc, AppServicesState>(
                        listener: (context, state) {
                          if (state is successServices) {
                            _reloadData(context);
                          }
                        },
                        child: BlocBuilder<KasbonBloc, AppServicesState>(
                          builder: (context, state) {
                            print(state);
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
                                    BlocProvider.of<KasbonBloc>(context).add(
                                      KasbonDeleteRequest(listKasbon.id_kasbon),
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
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
    getListKasbonBloc..getListKasbon(GetListKasbonRequest(1, ""));
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
      ),
    );
  }
}
