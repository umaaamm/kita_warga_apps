import 'package:flutter/material.dart';
import 'package:kita_warga_apps/theme.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final void Function()? onPressed;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Belum mempunyai Akun ? ",
          style: TextStyle(color: blueColor),
        ),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            "Registrasi",
            style: TextStyle(
              color: blueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
