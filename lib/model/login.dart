class Login {
  final int id;
  final String username;
  final String email;
  final String role;
  final String accessToken;

  Login(this.id,
      this.username,
      this.email,
      this.role,
      this.accessToken);

  Login.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        username = json["username"],
        email = json["email"],
        role = json["role"],
        accessToken = json["accessToken"];
}