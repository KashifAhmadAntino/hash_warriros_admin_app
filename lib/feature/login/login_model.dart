class LogIn {
  String email;
  String password;
  LogIn({required this.email, required this.password});

  factory LogIn.fromJson(Map<String, dynamic> json) => LogIn(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
