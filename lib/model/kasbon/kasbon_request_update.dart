import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:kita_warga_apps/model/kasbon/kasbon_request.dart';

@immutable
abstract class StateKasbon extends Equatable {
  const StateKasbon();
}

class KasbonRequestUpdate extends StateKasbon {
  final KasbonRequest kasbonRequest;

  KasbonRequestUpdate(this.kasbonRequest);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
