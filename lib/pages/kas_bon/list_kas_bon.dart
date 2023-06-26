import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/bloc/kasbon/get_list_kasbon.dart';
import 'package:kita_warga_apps/bloc/kasbon/kasbon_bloc.dart';
import 'package:kita_warga_apps/components/alert_logout.dart';
import 'package:kita_warga_apps/components/list/list_dashboard_initials.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/model/kasbon/get_list_kasbon_request.dart';
import 'package:kita_warga_apps/model/kasbon/kasbon_delete_request.dart';
import 'package:kita_warga_apps/model/kasbon/list_kasbon.dart';
import 'package:kita_warga_apps/model/kasbon/list_kasbon_response.dart';
import 'package:kita_warga_apps/pages/kas_bon/detail_kasbon/detail_kasbon.dart';
import 'package:kita_warga_apps/repository/kasbon_repository.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/constant.dart';

class ListKasBon extends StatefulWidget {
  const ListKasBon({super.key});

  @override
  State<ListKasBon> createState() => _ListKasBonState();
}

class _ListKasBonState extends State<ListKasBon> {
  bool isRefresh = false;
  @override
  void initState() {
    super.initState();
    getListKasbonBloc..getListKasbon(GetListKasbonRequest(1, ""));
    setState(() {
      isRefresh = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ListKasbonResponse>(
      stream: getListKasbonBloc.subject.stream,
      builder: (context, AsyncSnapshot<ListKasbonResponse> snapshot) {
        if (!snapshot.hasData) {
          return _buildLoadingWidget();
        }

        if (snapshot.hasError) {
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
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
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

  Widget _resultWidget(ListKasbonResponse data) {
    List<ListKasbon>? list = data.listKasbon;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin:
              EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w, bottom: 12.h),
          child: Text(
            'Daftar Kasbon',
            style: blackTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.listKasbon.length,
              itemBuilder: (context, index) {
                final item = data.listKasbon[index];
                return RepositoryProvider(
                    create: (context) => KasbonRepository(),
                    child: BlocProvider(
                      create: (context) => KasbonBloc(
                        kasbonRepository:
                            RepositoryProvider.of<KasbonRepository>(context),
                      ),
                      child: Dismissible(
                        direction: DismissDirection.endToStart,
                        key: Key(item.id_kasbon),
                        confirmDismiss: (direction) async {
                          showBottom(context, list[index]);
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailKasbon(
                                        listKasbon: list[index]);
                                  },
                                ),
                              );
                            },
                            child: ListDashboardInitials(
                              date: list[index].tanggal_transaksi,
                              name: list[index].nama_karyawan,
                              value: list[index].angsuran_per_bulan,
                              isDate: true,
                              isCurrency: true,
                            )),
                      ),
                    ));
              },
            ),
          ),
        ),
      ],
    );
  }

  _reloadData(BuildContext context) {
    Navigator.pop(context);
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
                            return WidgetsBinding.instance.addPostFrameCallback(
                                (_) => _reloadData(context));
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
}
