import 'package:flutter/material.dart';
import 'package:dressupexchange_mobile/utils/cart_database.dart';
import 'package:dressupexchange_mobile/models/cartItem_model.dart';

class CartItemsWidget extends StatefulWidget {
  @override
  _CartItemsWidgetState createState() => _CartItemsWidgetState();
}

class _CartItemsWidgetState extends State<CartItemsWidget> {
  final CartDatabaseHelper cartDatabaseHelper = CartDatabaseHelper();

  List<CartItem> cartItems = [];

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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final cartItem = cartItems[index];
        return ListTile(
          title:
              Text(cartItem.productId), // Display product information as needed
          subtitle: Text(
              "Price: \$${cartItem.price}, Quantity: ${cartItem.quantity}"),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Handle item removal from cart when this button is pressed
            },
          ),
        );
      },
    );
  }
}
