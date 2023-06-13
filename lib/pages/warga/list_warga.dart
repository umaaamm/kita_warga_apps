import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kita_warga_apps/bloc/dashboard/get_dashboard_last_trx.dart';
import 'package:kita_warga_apps/bloc/warga/get_list_warga.dart';
import 'package:kita_warga_apps/bloc/warga/warga_bloc_delete.dart';
import 'package:kita_warga_apps/components/alert_logout.dart';
import 'package:kita_warga_apps/model/dashboard/dashboard_last_trx.dart';
import 'package:kita_warga_apps/model/dashboard/dashboard_last_trx_response.dart';
import 'package:kita_warga_apps/model/warga/list_warga.dart';
import 'package:kita_warga_apps/model/warga/list_warga_response.dart';
import 'package:kita_warga_apps/repository/warga_repository.dart';
import 'package:kita_warga_apps/theme.dart';
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
                      onDismissed: (direction) {
                        print(direction);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("dismissed")));
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
