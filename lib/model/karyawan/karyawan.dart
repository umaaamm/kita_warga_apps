class Karyawan {
  final String id_karyawan;
  final String nama_karyawan;
  final String posisi;
  final String sisa_kasbon;
  final String id_perumahan;

  Karyawan(this.id_karyawan, this.nama_karyawan, this.posisi, this.sisa_kasbon,
      this.id_perumahan);

  Karyawan.fromJson(Map<String, dynamic> json)
      : id_karyawan = json["id_karyawan"],
        nama_karyawan = json["nama_karyawan"],
        posisi = json["posisi"],
        sisa_kasbon = json["sisa_kasbon"],
        id_perumahan = json["id_perumahan"];
}
