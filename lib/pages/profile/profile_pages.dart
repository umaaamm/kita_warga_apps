import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/pages/warga/title_warga.dart';
import 'package:kita_warga_apps/theme.dart';

class ProfilePages extends StatefulWidget {
  const ProfilePages({super.key});

  @override
  State<ProfilePages> createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            color: Colors.black,
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.maybePop(context);
            }),
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [

            Center(
              child: CircleAvatar(
                radius: 70, // Image radius
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80'),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Center(
              child: Flexible(
                child: Text(
                  'Kurniawan Gigih Lutfi Umam',
                  style: regularTextStyle.copyWith(
                      fontSize: 19,
                      color: blueColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Flexible(
                child: Center(
                  child: Text(
                    ' Jl. Cendrawasih Raya No.2a, Sawah Baru, Kec. Ciputat, Kota Tangerang Selatan, Banten 15413',
                    textAlign: TextAlign.center,
                    style: regularTextStyle.copyWith(
                        fontSize: 16, color: blueColor),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Flexible(
                child: Center(
                  child: Text(
                    'Pengurus',
                    textAlign: TextAlign.center,
                    style: regularTextStyle.copyWith(
                        fontSize: 16,
                        color: blueColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Text(
                'Atur Profil Anda',
                style: regularTextStyle.copyWith(
                    fontSize: 21,
                    color: blueColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
              margin: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
              ),
              decoration: BoxDecoration(
                  color: greyColorLight,
                  borderRadius: BorderRadius.circular(12.r)),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: blueColor,
                    size: 30.sp,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Ubah Password',
                    style: regularTextStyle.copyWith(
                        fontSize: 17, color: blueColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: RoundedButton(
                text: "Keluar",
                color: Colors.red,
                onPressed: () {
                  print("object");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
