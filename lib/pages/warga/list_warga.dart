import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/bloc/warga/get_list_warga.dart';
import 'package:kita_warga_apps/bloc/warga/warga_bloc.dart';
import 'package:kita_warga_apps/components/alert_logout.dart';
import 'package:kita_warga_apps/components/list/list_dashboard_initials.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/model/warga/get_list_warga_request.dart';
import 'package:kita_warga_apps/model/warga/list_warga.dart';
import 'package:kita_warga_apps/model/warga/list_warga_response.dart';
import 'package:kita_warga_apps/model/warga/warga_delete_request.dart';
import 'package:kita_warga_apps/pages/warga/detail_warga/detail_warga.dart';
import 'package:kita_warga_apps/repository/warga_repository.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/constant.dart';

class ListWargaWidget extends StatefulWidget {
  @override
  _ListWargaWidgetState createState() => _ListWargaWidgetState();
}

class _ListWargaWidgetState extends State<ListWargaWidget> {
  bool isRefresh = false;
  @override
  void initState() {
    super.initState();
    getListWargaBloc..getListWarga(GetListWargaRequest(1, ""));
    setState(() {
      isRefresh = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ListWargaResponse>(
      stream: getListWargaBloc.subject.stream,
      builder: (context, AsyncSnapshot<ListWargaResponse> snapshot) {
        print(snapshot);
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

        if (list.listWarga.isEmpty) {
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

  Future<void> showBottom(BuildContext context, ListWarga listWarga) {
    return showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return RepositoryProvider(
          create: (context) => WargaRepository(),
          child: BlocProvider(
            create: (context) => WargaBloc(
                wargaRepository:
                    RepositoryProvider.of<WargaRepository>(context)),
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
                              listWarga.nama_warga +
                              "?",
                          style: regularTextStyle.copyWith(
                              fontSize: 19, color: blueColor),
                        ),
                      ),
                    ),
                    Container(
                      child: BlocListener<WargaBloc, AppServicesState>(
                        listener: (context, state) {
                          if (state is successServices) {
                            return WidgetsBinding.instance.addPostFrameCallback(
                                (_) => _reloadData(context));
                          }
                        },
                        child: BlocBuilder<WargaBloc, AppServicesState>(
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
                                    BlocProvider.of<WargaBloc>(context).add(
                                      WargaDeleteRequest(listWarga.id_warga),
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
    getListWargaBloc..getListWarga(GetListWargaRequest(1, ""));
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
                        getListWargaBloc
                          ..getListWarga(GetListWargaRequest(1, ""));
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

  Widget _resultWidget(ListWargaResponse data) {
    List<ListWarga> listWarga = data.listWarga;
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
              itemCount: data.listWarga.length,
              itemBuilder: (context, index) {
                final item = data.listWarga[index];
                return RepositoryProvider(
                  create: (context) => WargaRepository(),
                  child: BlocProvider(
                    create: (context) => WargaBloc(
                        wargaRepository:
                            RepositoryProvider.of<WargaRepository>(context)),
                    child: Dismissible(
                      direction: DismissDirection.endToStart,
                      key: Key(item.id_warga),
                      confirmDismiss: (direction) async {
                        showBottom(context, listWarga[index]);
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
                                  return DetailWarga(
                                      listWarga: listWarga[index]);
                                },
                              ),
                            );
                          },
                          child: ListDashboardInitials(
                            date: listWarga[index].email,
                            name: listWarga[index].nama_warga,
                            value: listWarga[index].nomor_hp,
                            isDate: false,
                            gambarIcon: Icon(
                              Icons.supervised_user_circle,
                              size: 30.sp,
                            ),
                          )),
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
