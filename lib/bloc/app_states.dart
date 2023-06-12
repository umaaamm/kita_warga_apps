import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class AppServicesState extends Equatable {}

class InitialState extends AppServicesState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class loadingServices extends AppServicesState {
  @override
  List<Object?> get props => [];
}

class successServices extends AppServicesState{
  @override
  List<Object?> get props =>[];
}

class errorServices extends AppServicesState {
  final String error;
  errorServices(this.error);
  @override
  List<Object?> get props => [error];
}