class CartItem {
  String productId;
  int voucherId;
  int laundryId;
  double price;
  int quantity;

  CartItem({
    required this.productId,
    required this.voucherId,
    required this.laundryId,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'voucherId': voucherId,
      'laundryId': laundryId,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['productId'],
      voucherId: map['voucherId'],
      laundryId: map['laundryId'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
  CartItem copyWith({
    String? productId,
    int? voucherId,
    int? laundryId,
    double? price,
    int? quantity,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      voucherId: voucherId ?? this.voucherId,
      laundryId: laundryId ?? this.laundryId,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
