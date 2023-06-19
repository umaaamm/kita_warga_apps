class Kategori {
  final String id_kategori;
  final String nama_kategori_transaksi;
  final String keterangan_kategori_transaksi;

  Kategori(this.id_kategori,
      this.nama_kategori_transaksi,
      this.keterangan_kategori_transaksi);

  Kategori.fromJson(Map<String, dynamic> json)
      : id_kategori = json["id_kategori"],
        nama_kategori_transaksi = json["nama_kategori_transaksi"],
        keterangan_kategori_transaksi = json["keterangan_kategori_transaksi"];
}