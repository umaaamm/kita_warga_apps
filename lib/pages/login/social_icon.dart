import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kita_warga_apps/utils/constant.dart';

class SocalIcon extends StatelessWidget {
  final String iconSrc;
  final void Function()? onPressed;
  const SocalIcon({
    Key? key,
    required this.iconSrc,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
