import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:kita_warga_apps/model/warga/warga_request.dart';

@immutable
abstract class StateWarga extends Equatable {
  const StateWarga();
}

class WargaRequestUpdate extends StateWarga {
  final WargaRequest wargaRequest;

  WargaRequestUpdate(this.wargaRequest);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
