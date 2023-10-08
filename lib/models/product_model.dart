class Product {
  final int userId;
  final int productId;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String size;
  final String thumbnail;
  final List<String> images;
  final User user;

  Product({
    required this.userId,
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.size,
    required this.thumbnail,
    required this.images,
    required this.user,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'] as Map<String, dynamic>;

    return Product(
      userId: json['userId'],
      productId: json['productId'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      size: json['size'],
      thumbnail: json['thumbnail'],
      images: (json['images'] as List).cast<String>(),
      user: User.fromJson(userJson),
    );
  }
}

class User {
  final String phone;
  final String name;
  final String role;
  final String address;

  User({
    required this.phone,
    required this.name,
    required this.role,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      phone: json['phone'],
      name: json['name'],
      role: json['role'],
      address: json['address'],
    );
  }
}
