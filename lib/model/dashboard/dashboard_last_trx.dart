class DashboardLastTrx {
  final String nama;
  final String tanggal;
  final String balance;
  final String keterangan;

  DashboardLastTrx(this.nama,
      this.tanggal,
      this.balance,
      this.keterangan);

  DashboardLastTrx.fromJson(Map<String, dynamic> json)
      : nama = json["nama"],
        tanggal = json["tanggal"],
        balance = json["balance"],
        keterangan = json["keterangan"];
}