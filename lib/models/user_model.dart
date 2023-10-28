class UserResponse {
  final int userId;
  String phoneNumber;
  String address;
  String name;
  final String role;
  final String accessToken;
  final String refreshToken;

  UserResponse({
    required this.userId,
    required this.phoneNumber,
    required this.address,
    required this.name,
    required this.role,
    required this.accessToken,
    required this.refreshToken,
  });
  //Getters and setters
  String get getPhoneNumber => phoneNumber;
  String get getAddress => address;
  String get getName => name;
  set setPhoneNumber(String newPhoneNumber) {
    phoneNumber = newPhoneNumber;
  }

  set setAddress(String newAddress) {
    address = newAddress;
  }

  set setName(String newName) {
    name = newName;
  }

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      userId: json['userId'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      name: json['name'],
      role: json['role'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
