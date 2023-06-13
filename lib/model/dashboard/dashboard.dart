class Dashboard {
  final String total_saldo;
  final String total_pemasukan_bulan_ini;
  final String total_pengeluaran_bulan_ini;
  final String selisih;

  Dashboard(this.total_saldo,
      this.total_pemasukan_bulan_ini,
      this.total_pengeluaran_bulan_ini,
      this.selisih);

  Dashboard.fromJson(Map<String, dynamic> json)
      : total_saldo = json["data"]["total_saldo"],
        total_pemasukan_bulan_ini = json["data"]["total_pemasukan_bulan_ini"],
        total_pengeluaran_bulan_ini = json["data"]["total_pengeluaran_bulan_ini"],
        selisih = json["data"]["selisih"];
}