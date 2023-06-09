import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kita_warga_apps/components/already_have_an_account_acheck.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/components/rounded_input_field.dart';
import 'package:kita_warga_apps/components/rounded_password_field.dart';
import 'package:kita_warga_apps/model/login_request.dart';
import 'package:kita_warga_apps/model/login_response.dart';
import 'package:kita_warga_apps/pages/home_page.dart';
import 'package:kita_warga_apps/pages/login/background.dart';
import 'package:kita_warga_apps/pages/login/or_divider.dart';
import 'package:kita_warga_apps/pages/login/social_icon.dart';
import 'package:kita_warga_apps/provider/login_provider.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyPagesState createState() => _BodyPagesState();
}

class _BodyPagesState extends State<Body> {
  bool isLogin = false;
  bool isLoading = false;
  bool _onSend = false;
  String email = "";
  String password = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Masukkan e-mail anda",
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            Container(
              child: _onSend
                  ? _buildLoadingWidget()
                  : RoundedButton(
                      text: "Masuk",
                      onPressed: () {
                        _login();
                      },
                    ),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return HomePages();
                //     },
                //   ),
                // );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  onPressed: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  onPressed: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
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

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Future<void> _login() async {
    setState(() => _onSend = true);
    LoginProvider provider = context.read<LoginProvider>();
    LoginResponse response =
        await provider.login(LoginRequest(email, password));
    if (response.login.accessToken.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Oops! Ada yang salah, pastikan email atau password anda benar.',
          ),
        ),
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return HomePages();
          },
        ),
        (Route<dynamic> route) => false,
      );
    }
    setState(() => _onSend = false);
  }
}
