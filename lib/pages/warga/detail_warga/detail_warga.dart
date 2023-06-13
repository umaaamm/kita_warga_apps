import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/model/warga/list_warga.dart';
import 'package:kita_warga_apps/pages/warga/add_warga/add_warga_pages.dart';
import 'package:kita_warga_apps/theme.dart';
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
                                  style:
                                      blackTextStyle.copyWith(fontSize: 16.sp),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(5),
                                ),
                                Text(
                                  "${widget.listWarga.alamat_perumahan} ${widget.listWarga.blok_rumah} ${widget.listWarga.nomor_rumah} ${widget.listWarga.nama_perumahan} djskajdksjkadn jdksjakjdksa jdksajdkjskajd kdjskajdkjsa jdskajkdjs",
                                  style:
                                      regularTextStyle.copyWith(fontSize: 9.sp),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: ScreenUtil().setWidth(200),
                                      decoration: BoxDecoration(
                                          color: yellowColor,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14),
                                      child: Text(
                                        'Edit',
                                        style: regularTextStyle.copyWith(
                                            fontSize: 12.sp),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(5),
                                    ),
                                    Container(
                                      // width: ScreenUtil().setWidth(20),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      padding: EdgeInsets.all(14),
                                      child: Icon(
                                        Icons.delete,
                                        size: 16.sp,
                                        // Other properties
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
                                  style: regularTextStyle.copyWith(
                                      fontSize: 12.sp),
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
                                  style: regularTextStyle.copyWith(
                                      fontSize: 12.sp),
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
                                  style: regularTextStyle.copyWith(
                                      fontSize: 12.sp),
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
                                  style: regularTextStyle.copyWith(
                                      fontSize: 12.sp),
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
                                  style: regularTextStyle.copyWith(
                                      fontSize: 12.sp),
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
                                  style: regularTextStyle.copyWith(
                                      fontSize: 12.sp),
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
        ));
  }
}
