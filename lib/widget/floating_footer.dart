import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/bloc_shared_preference.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/pages/login/login.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:share_plus/share_plus.dart';

class FloatingFooter extends StatelessWidget {
  const FloatingFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width - (2 * 24),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home,
                color: blueColor,
                size: 30.sp,
              ),
              Text(
                'Beranda',
                style:
                    blackTextStyle.copyWith(color: blueColor, fontSize: 12.sp),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              showQR(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_scanner,
                  color: blueColor,
                  size: 30.sp,
                ),
                Text(
                  'Show QR',
                  style: blackTextStyle.copyWith(
                      color: blueColor, fontSize: 12.sp),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                color: blueColor,
                size: 30.sp,
              ),
              Text(
                'Profil',
                style:
                    blackTextStyle.copyWith(color: blueColor, fontSize: 12.sp),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> showQR(BuildContext context) {
    return showModalBottomSheet<void>(
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Scan Me",
                    style: regularTextStyle.copyWith(
                        fontSize: 19,
                        color: blueColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "assets/images/frame.png",
                    width: 250,
                    height: 250,
                  ),
                ),
                Text(
                  "Bank CIMB",
                  style: regularTextStyle.copyWith(
                      fontSize: 19,
                      color: blueColor,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "7404875",
                  style:
                      regularTextStyle.copyWith(fontSize: 16, color: blueColor),
                ),
                RoundedButton(
                  text: "Share",
                  onPressed: () async {
                    _onShareXFileFromAssets(context);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _onShareXFileFromAssets(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final data = await rootBundle.load('assets/images/frame.png');
    final buffer = data.buffer;
    await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: 'frame.png',
          mimeType: 'image/png',
        ),
      ],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
