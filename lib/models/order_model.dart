class Order {
  final double totalAmount;
  final String shippingAddress;
  final List<OrderItem> orderItems;

  Order({
    required this.totalAmount,
    required this.shippingAddress,
    required this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final List<OrderItem> orderItems = (json['orderItemsRequest'] as List<dynamic>?)?.map((item) => OrderItem.fromJson(item)).toList() ?? [];

    return Order(
      totalAmount: json['totalAmount']?.toDouble() ?? 0.0,
      shippingAddress: json['shippingAddress'] ?? '',
      orderItems: orderItems,
    );
  }
}

class OrderItem {
  final int productId;
  final int voucherId;
  final int laundryId;
  final double price;
  final int buyingQuantity;

  OrderItem({
    required this.productId,
    required this.voucherId,
    required this.laundryId,
    required this.price,
    required this.buyingQuantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      voucherId: json['voucherId'],
      laundryId: json['laundryId'],
      price: json['price'].toDouble(),
      buyingQuantity: json['buyingQuantity'],
    );
  }
}
