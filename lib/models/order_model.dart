class Order {
  final int totalAmount;
  final List<OrderItem> orderItems;

  Order({
    required this.totalAmount,
    required this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final List<dynamic> orderItemsJson = json['orderItems'];
    final List<OrderItem> orderItems =
        orderItemsJson.map((item) => OrderItem.fromJson(item)).toList();

    return Order(
      totalAmount: json['totalAmount'],
      orderItems: orderItems,
    );
  }
}

class OrderItem {
  final int productID;
  final String productName;
  final int quantityBuy;
  final String status;
  final String price;
  final List<Laundry> laundry;

  OrderItem({
    required this.productID,
    required this.productName,
    required this.quantityBuy,
    required this.status,
    required this.price,
    required this.laundry,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    final List<dynamic> laundryJson = json['laundry'];
    final List<Laundry> laundry =
        laundryJson.map((item) => Laundry.fromJson(item)).toList();

    return OrderItem(
      productID: json['productID'],
      productName: json['productName'],
      quantityBuy: json['quantityBuy'],
      status: json['status'],
      price: json['price'],
      laundry: laundry,
    );
  }
}

class Laundry {
  final String laundryName;
  final String laundryPrice;

  Laundry({
    required this.laundryName,
    required this.laundryPrice,
  });

  factory Laundry.fromJson(Map<String, dynamic> json) {
    return Laundry(
      laundryName: json['laundryName'],
      laundryPrice: json['laundryPrice'],
    );
  }
}
