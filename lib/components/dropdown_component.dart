import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/pages/warga/title_warga.dart';

import '../theme.dart';
import '../utils/constant.dart';

class dropdownCustom extends StatelessWidget {
  final String title;
  final Function(String?) onChanged;
  final String textHint;
  const dropdownCustom({
    super.key,
    required this.textHint,
    required this.title,
    required this.onChanged,
    required this.dropdownValue,
    required this.list,
  });

  final String dropdownValue;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: title,
          labelStyle: regularTextStyle.copyWith(
              fontSize: 16.sp, color: blueColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: blueColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: greyColorLight),
          ),
        ),
        child: Container(
          height: 30,
          child: DropdownButton<String>(
            isExpanded: true,
            iconSize: 28,
            hint: Text(
              textHint,
              style: regularTextStyle.copyWith(
                  fontSize: 16.sp, color: greyColorLight),
            ),
            value: dropdownValue,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: blueColorConstant,
            ),
            elevation: 16,
            style: regularTextStyle.copyWith(
                fontSize: 16.sp, color: blueColor),
            underline: SizedBox(),
            onChanged: onChanged,
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}