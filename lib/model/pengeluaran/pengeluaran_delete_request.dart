import 'package:kita_warga_apps/model/pengeluaran/pengeluaran.dart';
import 'package:kita_warga_apps/model/warga/warga_request_update.dart';

class PengeluaranDeleteRequest extends StatePengeluaran {
  final String id_transaksi;

  PengeluaranDeleteRequest(
      this.id_transaksi,
      );

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
