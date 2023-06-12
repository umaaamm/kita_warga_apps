import 'package:bloc/bloc.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/model/login_request.dart';
import 'package:kita_warga_apps/model/login_response.dart';
import 'package:kita_warga_apps/repository/login_repository.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBlocServices extends Bloc<LoginRequest, AppServicesState> {
  final LoginRepository loginRepository;
  String? _token;
  late final SharedPreferences _preferences;
  LoginBlocServices({required this.loginRepository}) : super(InitialState()) {
    on<LoginRequest>((event, emit) async {
      emit(loadingServices());
      // await Future.delayed(const Duration(seconds: 1));
      try {
       LoginResponse response = await loginRepository
            .getLogin(LoginRequest(event.email_admin, event.password_admin));

       if(response.login.accessToken.isNotEmpty){
         saveSession(response);
         emit(successServices());
         return;
       }
       emit(errorServices("error bro"));
      } catch (e) {
        emit(errorServices(e.toString()));
      }
    });
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _token = _preferences.getString(AppConstant.accessToken);
  }

  void saveSession(LoginResponse loginResponse) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(AppConstant.accessToken, loginResponse.login.accessToken);
    await pref.setString(AppConstant.idPengurus, loginResponse.login.id_pengurus);
    await pref.setString(AppConstant.idPerumahan, loginResponse.login.id_perumahan);
    await pref.setString(AppConstant.idWarga, loginResponse.login.id_warga);
    await pref.setBool("is_login", true);
  }
}
