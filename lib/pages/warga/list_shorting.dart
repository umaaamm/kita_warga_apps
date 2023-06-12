import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/theme.dart';

class ListShorting extends StatefulWidget {
  final List<String> dataTest;
  final bool isTapped;
  int isActive;
  final Function onPressed;

  ListShorting({
    Key? key,
    required this.dataTest,
    required this.isTapped,
    required this.onPressed,
    required this.isActive,
  });

  @override
  State<ListShorting> createState() => _ListShortingState();
}

class _ListShortingState extends State<ListShorting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.dataTest.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: ()  {
              widget.onPressed();
              setState(() {
                widget.isActive = index;
              });
            },
            child: Center(
              child: Container(
              padding: EdgeInsets.only(left: 20),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: widget.isActive == index ? blueColor: greyColorLight,
                ),
                child: Text(
                  widget.dataTest[index],
                  style: regularTextStyle.copyWith(
                      fontSize: 17.sp, color: widget.isActive == index ? Colors.white : blueColor),
                ),
              ),
          ),
            ),
          );
        },
      ),
    );
  }
}