import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/bloc/dashboard/get_dashboard_last_trx.dart';
import 'package:kita_warga_apps/bloc/warga/get_list_warga.dart';
import 'package:kita_warga_apps/bloc/warga/warga_bloc_delete.dart';
import 'package:kita_warga_apps/components/alert_logout.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/model/dashboard/dashboard_last_trx.dart';
import 'package:kita_warga_apps/model/dashboard/dashboard_last_trx_response.dart';
import 'package:kita_warga_apps/model/warga/list_warga.dart';
import 'package:kita_warga_apps/model/warga/list_warga_response.dart';
import 'package:kita_warga_apps/model/warga/warga_delete_request.dart';
import 'package:kita_warga_apps/pages/warga/warga_pages.dart';
import 'package:kita_warga_apps/repository/warga_repository.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:kita_warga_apps/utils/currency_format.dart';
import 'package:kita_warga_apps/utils/text_format.dart';

class ListWargaWidget extends StatefulWidget {
  @override
  _ListWargaWidgetState createState() => _ListWargaWidgetState();
}

class _ListWargaWidgetState extends State<ListWargaWidget> {
  @override
  void initState() {
    super.initState();
    getListWargaBloc..getListWarga();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ListWargaResponse>(
      stream: getListWargaBloc.subject.stream,
      builder: (context, AsyncSnapshot<ListWargaResponse> snapshot) {
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

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackAndHit(
      BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A SnackBar has been shown.'),
      ),
    );
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
            create: (context) => WargaBlocDelete(
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
                      child: BlocListener<WargaBlocDelete, AppServicesState>(
                        listener: (context, state) {
                          if (state is successServices) {
                            return WidgetsBinding.instance.addPostFrameCallback(
                                (_) => _reloadData(context));
                          }
                        },
                        child: BlocBuilder<WargaBlocDelete, AppServicesState>(
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
                                    BlocProvider.of<WargaBlocDelete>(context)
                                        .add(
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
    getListWargaBloc..getListWarga();
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

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
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
                    create: (context) => WargaBlocDelete(
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
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        margin: EdgeInsets.only(
                            left: 10.w,
                            right: 10.w,
                            bottom: index == listWarga.length - 1 ? 75.h : 8.h),
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
                                              listWarga[index].nama_warga
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listWarga[index].nama_warga,
                                      style: regularTextStyle.copyWith(
                                          fontSize: 21,
                                          color: blueColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      listWarga[index].nomor_hp,
                                      style: regularTextStyle.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: blueColor),
                                    ),
                                    Text(
                                      listWarga[index].email,
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
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
