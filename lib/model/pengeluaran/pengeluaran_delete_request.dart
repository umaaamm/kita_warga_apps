import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_request_add.dart';

class PengeluaranDeleteRequest extends StatePengeluaran {
  final String id_transaksi;

  PengeluaranDeleteRequest(
      this.id_transaksi,
      );

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
