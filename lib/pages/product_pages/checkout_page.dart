import 'package:flutter/material.dart';
import 'package:dressupexchange_mobile/utils/cart_database.dart';
import 'package:dressupexchange_mobile/models/cartItem_model.dart';
import 'package:dressupexchange_mobile/models/order_model.dart'; // Import the Order model
import 'package:dressupexchange_mobile/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import the ApiService
import 'package:fluttertoast/fluttertoast.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CartDatabaseHelper cartDatabaseHelper = CartDatabaseHelper();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  List<CartItem> cartItems = [];
  ApiService apiService = ApiService(); // Create an instance of ApiService

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  void fetchCartItems() async {
    final items = await cartDatabaseHelper.getCartItems();
    setState(() {
      cartItems = items;
    });
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }

  void handleCheckout() async {
    // Create an order with cart items
    final order = Order(
      totalAmount: calculateTotalPrice(),
      shippingAddress: await _secureStorage.read(key: 'address').toString(),
      orderItems: cartItems.map((cartItem) {
        return OrderItem(
          productId: int.parse(cartItem.productId),
          voucherId: cartItem.voucherId,
          laundryId: cartItem.laundryId,
          price: cartItem.price,
          buyingQuantity: cartItem.quantity,
        );
      }).toList(),
    );

    try {
      // Place the order using the ApiService
      final placedOrder = await apiService.placeOrder(order);

      // Handle the response or navigate to the order confirmation screen
      // You can use placedOrder to display order details or navigate to the confirmation screen.

      // Show a success toast message
      Fluttertoast.showToast(
        msg: 'Place order complete',
        toastLength: Toast.LENGTH_SHORT, // You can adjust the length
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green, // You can change the background color
        textColor: Colors.white, // You can change the text color
        fontSize: 16.0, // You can change the font size
      );
    } catch (e) {
      // Handle errors, e.g., show an error message to the user
      print('Error placing the order: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Your Cart Items:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return ListTile(
                  title: Text(cartItem.productId),
                  subtitle: Text('Price: ${cartItem.price} VND, Quantity: ${cartItem.quantity}'),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Total Price: ${calculateTotalPrice().toStringAsFixed(2)} VND',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: handleCheckout, // Call the handleCheckout method
            child: Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
