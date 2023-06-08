import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kita_warga_apps/theme.dart';

class LastTransaction extends StatelessWidget {
  const LastTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 15),
          child: Text(
            'Fitur Aplikasi',
            style: blackTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 96,
              width: 120,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wallet,
                    color: Colors.green,
                    size: 30.0,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text('Pengeluaran', style: blackTextStyle,)
                ],
              ),
            ),
            Container(
              height: 96,
              width: 120,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_add,
                    color: yellowColor,
                    size: 30.0,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text('Warga', style: blackTextStyle,)
                ],
              ),
            ),
            Container(
              height: 96,
              width: 120,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wallet,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text('Kas Bon', style: blackTextStyle,)
                ],
              ),
            )
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 15),
          child: Text(
            'Transaksi Terakhir',
            style: blackTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Container(
              color: whiteColor30,
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    margin: EdgeInsets.only(left: 25, right: 25, bottom: 10),
                    decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "assets/dummy/profile_picture.png",
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Admin / Dhimas Hertianto', style: regularTextStyle.copyWith(fontSize: 12, color: yellowColor),),
                                Text('Rp 2.345.678', style: regularTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700, color: yellowColor),),
                                Text('notes', style: regularTextStyle.copyWith(fontSize: 12, color: yellowColor),),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.arrow_circle_down,
                            color: Colors.red,
                            size: 30.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    margin: EdgeInsets.only(left: 25, right: 25, bottom: 10),
                    decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "assets/dummy/profile_picture.png",
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Admin / Dhimas Hertianto', style: regularTextStyle.copyWith(fontSize: 12, color: yellowColor),),
                                Text('Rp 2.345.678', style: regularTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700, color: yellowColor),),
                                Text('notes', style: regularTextStyle.copyWith(fontSize: 12, color: yellowColor),),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.arrow_circle_up,
                            color: Colors.green,
                            size: 30.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    margin: EdgeInsets.only(left: 25, right: 25, bottom: 10),
                    decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "assets/dummy/profile_picture.png",
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Admin / Dhimas Hertianto', style: regularTextStyle.copyWith(fontSize: 12, color: yellowColor),),
                                Text('Rp 2.345.678', style: regularTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700, color: yellowColor),),
                                Text('notes', style: regularTextStyle.copyWith(fontSize: 12, color: yellowColor),),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.arrow_circle_down,
                            color: Colors.green,
                            size: 30.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    margin: EdgeInsets.only(left: 25, right: 25, bottom: 10),
                    decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "assets/dummy/profile_picture.png",
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Admin / Dhimas Hertianto', style: regularTextStyle.copyWith(fontSize: 12, color: yellowColor),),
                                Text('Rp 2.345.678', style: regularTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700, color: yellowColor),),
                                Text('notes', style: regularTextStyle.copyWith(fontSize: 12, color: yellowColor),),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.arrow_circle_down,
                            color: Colors.green,
                            size: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70 + 24,
                  )
                ],
              )
          ),
        ),
      ],
    );
  }
}
