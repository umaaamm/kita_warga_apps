class Login {
  final String username;
  final String email;
  final String role;
  final String accessToken;
  final String id_pengurus;
  final String id_perumahan;
  final String id_warga;

  Login(
      this.username,
      this.email,
      this.role,
      this.accessToken,
      this.id_perumahan,
      this.id_warga,
      this.id_pengurus);

  Login.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        email = json["email"],
        role = json["role"],
        id_warga = json["id_warga"],
        id_pengurus = json["id_pengurus"],
        id_perumahan = json["id_perumahan"],
        accessToken = json["accessToken"];
}