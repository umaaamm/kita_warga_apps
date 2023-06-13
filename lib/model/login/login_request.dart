
import 'package:equatable/equatable.dart';

abstract class LoginRequestEvent extends Equatable {}

class LoginRequest {
  final String email_admin;
  final String password_admin;

  LoginRequest(
    this.email_admin,
    this.password_admin,
  );
}
