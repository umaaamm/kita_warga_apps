class Karyawan {
  final String id_karyawan;
  final String nama_karyawan;
  final String posisi;

  Karyawan(
    this.id_karyawan,
    this.nama_karyawan,
    this.posisi,
  );

  Karyawan.fromJson(Map<String, dynamic> json)
      : id_karyawan = json["id_karyawan"],
        nama_karyawan = json["nama_karyawan"],
        posisi = json["posisi"];
}
