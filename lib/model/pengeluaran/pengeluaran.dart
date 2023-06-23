

class Pengeluaran {
  final String id_transaksi;
  final String nama_transaksi;
  final String id_kategori;
  final String id_kasbon;
  final String kategori_transaksi;
  final String tanggal_transaksi;
  final String nilai_transaksi;
  final String keterangan;
  final String bukti_foto;

  Pengeluaran(this.id_transaksi,
      this.nama_transaksi,
      this.id_kategori,
      this.id_kasbon,
      this.kategori_transaksi,
      this.tanggal_transaksi,
      this.nilai_transaksi,
      this.keterangan,
      this.bukti_foto);

  Pengeluaran.fromJson(Map<String, dynamic> json)
      : id_transaksi = json["id_transaksi"],
        nama_transaksi = json["nama_transaksi"],
        id_kategori = json["id_kategori"],
        id_kasbon = json["id_kasbon"] ?? '',
        kategori_transaksi = json["kategori_transaksi"],
        tanggal_transaksi = json["tanggal_transaksi"] ?? '0',
        nilai_transaksi = json["nilai_transaksi"],
        keterangan = json["keterangan"] ?? '',
        bukti_foto = json["bukti_foto"];

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}