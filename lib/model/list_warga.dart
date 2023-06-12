class ListWarga {
  final String id_warga;
  final String nama_warga;
  final String blok_rumah;
  final String nomor_rumah;
  final String email;
  final String nomor_hp;
  final bool is_rw;
  final bool is_rt;
  final String id_rw;
  final String id_rt;
  final String id_perumahan;
  final String status_pernikahan;
  final String jenis_kelamin;
  final String createdAt;
  final String updatedAt;
  final String nama_perumahan;
  final String alamat_perumahan;

  ListWarga(this.id_warga,
      this.nama_warga,
      this.blok_rumah,
      this.nomor_rumah,
      this.email,
      this.nomor_hp,
      this.is_rw,
      this.is_rt,
      this.id_rw,
      this.id_rt,
      this.id_perumahan,
      this.status_pernikahan,
      this.jenis_kelamin,
      this.createdAt,
      this.updatedAt,
      this.nama_perumahan,
      this.alamat_perumahan);

  ListWarga.fromJson(Map<String, dynamic> json)
      : id_warga = json["id_warga"],
        nama_warga = json["nama_warga"],
        blok_rumah = json["blok_rumah"],
        nomor_hp = json["nomor_hp"],
        is_rw = json["is_rw"],
        is_rt = json["is_rt"],
        id_rw = json["id_rw"],
        id_rt = json["id_rt"],
        id_perumahan = json["id_perumahan"],
        status_pernikahan = json["status_pernikahan"],
        jenis_kelamin = json["jenis_kelamin"],
        createdAt = json["createdAt"],
        updatedAt = json["updatedAt"],
        alamat_perumahan = json["alamat_perumahan"],
        email = json["email"],
        nomor_rumah = json["nomor_rumah"],
        nama_perumahan = json["nama_perumahan"];

}