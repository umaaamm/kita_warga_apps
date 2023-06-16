import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/bloc/warga/get_list_warga.dart';
import 'package:kita_warga_apps/bloc/warga/warga_bloc_delete.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/model/warga/get_list_warga_request.dart';
import 'package:kita_warga_apps/model/warga/list_warga.dart';
import 'package:kita_warga_apps/model/warga/warga_delete_request.dart';
import 'package:kita_warga_apps/pages/warga/add_warga/add_warga_pages.dart';
import 'package:kita_warga_apps/pages/warga/edit_warga/edit_warga_pages.dart';
import 'package:kita_warga_apps/pages/warga/warga_pages.dart';
import 'package:kita_warga_apps/repository/warga_repository.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:kita_warga_apps/utils/text_format.dart';

class DetailWarga extends StatefulWidget {
  final ListWarga listWarga;
  DetailWarga({Key? key, required this.listWarga});

  @override
  State<DetailWarga> createState() => _DetailWargaState();
}

class _DetailWargaState extends State<DetailWarga> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: lightBackground,
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: lightBackground,
        ),
        child: Padding(
          padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 20.w),
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        // height: ScreenUtil().setHeight(200),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r)),
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(45)),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(55),
                              bottom: ScreenUtil().setHeight(20)),
                          child: Column(
                            children: [
                              Text(
                                widget.listWarga.nama_warga,
                                style: blackTextStyle.copyWith(fontSize: 16.sp),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(5),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Text(
                                  "${widget.listWarga.alamat_perumahan} ${widget.listWarga.blok_rumah} ${widget.listWarga.nomor_rumah} ${widget.listWarga.nama_perumahan}",
                                  style:
                                      regularTextStyle.copyWith(fontSize: 9.sp),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return EditWargaPages(
                                              listWarga: widget.listWarga,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: ScreenUtil().setWidth(200),
                                      decoration: BoxDecoration(
                                          color: yellowColor,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14),
                                      child: Text(
                                        'Rubah',
                                        style: regularTextStyle.copyWith(
                                            fontSize: 12.sp),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(5),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showBottom(context, widget.listWarga);
                                    },
                                    child: Container(
                                      // width: ScreenUtil().setWidth(20),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      padding: EdgeInsets.all(14),
                                      child: Icon(
                                        Icons.delete,
                                        size: 16.sp,
                                        color: whiteColor,
                                        // Other properties
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                    Center(
                      child: Container(
                        height: ScreenUtil().setHeight(90),
                        width: ScreenUtil().setHeight(90),
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Center(
                            child: Text(
                          TextFormat.getInitials(widget.listWarga.nama_warga),
                          style: whiteTextStyle.copyWith(fontSize: 40.sp),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.r),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.23,
                              padding: EdgeInsets.only(left: 20.r),
                              child: Text(
                                "Nama",
                                style:
                                    regularTextStyle.copyWith(fontSize: 12.sp),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(right: 20.r),
                                child: Text(
                                  widget.listWarga.nama_warga,
                                  style: regularTextStyle.copyWith(
                                      fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 0.5, // Set the height of the line
                          color: greyColor,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.r,
                              vertical: 10.r), // Set the color of the line
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.23,
                              padding: EdgeInsets.only(left: 20.r),
                              child: Text(
                                "Alamat",
                                style:
                                    regularTextStyle.copyWith(fontSize: 12.sp),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(right: 20.r),
                                child: Text(
                                  "${widget.listWarga.alamat_perumahan} ${widget.listWarga.blok_rumah} ${widget.listWarga.nomor_rumah} ${widget.listWarga.blok_rumah}",
                                  style: regularTextStyle.copyWith(
                                      fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 0.5, // Set the height of the line
                          color: greyColor,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.r,
                              vertical: 10.r), // Set the color of the line
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.23,
                              padding: EdgeInsets.only(left: 20.r),
                              child: Text(
                                "Email",
                                style:
                                    regularTextStyle.copyWith(fontSize: 12.sp),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(right: 20.r),
                                child: Text(
                                  widget.listWarga.email,
                                  style: regularTextStyle.copyWith(
                                      fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 0.5, // Set the height of the line
                          color: greyColor,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.r,
                              vertical: 10.r), // Set the color of the line
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.23,
                              padding: EdgeInsets.only(left: 20.r),
                              child: Text(
                                "Kelamin",
                                style:
                                    regularTextStyle.copyWith(fontSize: 12.sp),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(right: 20.r),
                                child: Text(
                                  widget.listWarga.jenis_kelamin,
                                  style: regularTextStyle.copyWith(
                                      fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 0.5, // Set the height of the line
                          color: greyColor,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.r,
                              vertical: 10.r), // Set the color of the line
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.23,
                              padding: EdgeInsets.only(left: 20.r),
                              child: Text(
                                "Status",
                                style:
                                    regularTextStyle.copyWith(fontSize: 12.sp),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(right: 20.r),
                                child: Text(
                                  widget.listWarga.status_pernikahan,
                                  style: regularTextStyle.copyWith(
                                      fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 0.5, // Set the height of the line
                          color: greyColor,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.r,
                              vertical: 10.r), // Set the color of the line
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.23,
                              padding: EdgeInsets.only(left: 20.r),
                              child: Text(
                                "No Tlp",
                                style:
                                    regularTextStyle.copyWith(fontSize: 12.sp),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(right: 20.r),
                                child: Text(
                                  widget.listWarga.nomor_hp,
                                  style: regularTextStyle.copyWith(
                                      fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 0.5, // Set the height of the line
                          color: greyColor,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.r,
                              vertical: 10.r), // Set the color of the line
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return WargaPages();
                                },
                              ),
                            );
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
}
