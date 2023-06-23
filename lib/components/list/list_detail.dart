import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/theme.dart';

class ListDetailComponent extends StatelessWidget {
  final String? title;
  final String? desc;
  const ListDetailComponent({Key? key, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              this.title.toString(),
              style: blackTextStyle.copyWith(fontSize: 18),
            ),
          ),
          Text(
            " : ",
            style: blackTextStyle.copyWith(fontSize: 18),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  this.desc.toString(),
                  style: blackTextStyle.copyWith(fontSize: 20),
                ),
              )),
        ],
      ),
      SizedBox(
        height: ScreenUtil().setHeight(5.h),
      ),
      Container(
        height: 0.5,
        color: Colors.black,
      ),
      SizedBox(
        height: ScreenUtil().setHeight(20),
      )
    ]);
  }
}
