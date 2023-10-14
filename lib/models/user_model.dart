class User {
  final int userId;
  final String name;
  final String role;
  final String address;
  final String accessToken;
  final String refreshToken;

  User({
    required this.userId,
    required this.name,
    required this.role,
    required this.address,
    required this.accessToken,
    required this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      role: json['role'],
      address: json['address'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
