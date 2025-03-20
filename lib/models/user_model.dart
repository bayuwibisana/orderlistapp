class User {
  final String token;
  final String name;
  final String email;

  User({required this.token, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
      return User(
      token: json['token'],
      name: json['user']['name'],
      email: json['user']['email'],
    );
  }
  
}