import 'package:kita_warga_apps/model/warga/warga_request_update.dart';

class WargaDeleteRequest extends StateWarga {
  final String id_warga;

  WargaDeleteRequest(
    this.id_warga,
  );

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
