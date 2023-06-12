class Login {
  final String username;
  final String email;
  final int role;
  final String accessToken;

  Login(
      this.username,
      this.email,
      this.role,
      this.accessToken);

  Login.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        email = json["email"],
        role = json["role"],
        accessToken = json["accessToken"];
}