import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/bloc/login/login_bloc.dart';
import 'package:kita_warga_apps/components/already_have_an_account_acheck.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/components/rounded_input_field.dart';
import 'package:kita_warga_apps/components/rounded_password_field.dart';
import 'package:kita_warga_apps/model/login/login_request.dart';
import 'package:kita_warga_apps/pages/home_page.dart';
import 'package:kita_warga_apps/pages/login/background.dart';
import 'package:kita_warga_apps/pages/login/or_divider.dart';
import 'package:kita_warga_apps/pages/login/social_icon.dart';
import 'package:kita_warga_apps/repository/login_repository.dart';
import 'package:kita_warga_apps/theme.dart';

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
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (context) => LoginBlocServices(
          loginRepository: RepositoryProvider.of<LoginRepository>(context)),
      child: Background(
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
                  key: scaffoldKey,
                  child: BlocListener<LoginBlocServices, AppServicesState>(
                    listener: (context, state) {
                      if (state is successServices) {
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
                    },
                    child: BlocBuilder<LoginBlocServices, AppServicesState>(
                      builder: (context, state) {
                        print(state);
                        if (state is loadingServices) {
                          return _buildLoadingWidget();
                        } else if (state is errorServices) {
                          return const Center(child: Text("Error"));
                        }
                        return RoundedButton(
                          text: "Masuk",
                          onPressed: () {
                            _postData(context);
                          },
                        );
                      },
                    ),
                  )),
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

  void _postData(context) {
    BlocProvider.of<LoginBlocServices>(context).add(
      LoginRequest(email, password),
    );
  }
}
