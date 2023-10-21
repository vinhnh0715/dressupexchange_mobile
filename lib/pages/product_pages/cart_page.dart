import 'package:flutter/material.dart';
import 'package:dressupexchange_mobile/pages/product_pages/cart_items_page.dart';
import 'package:dressupexchange_mobile/pages/product_pages/checkout_page.dart'; // Import the CheckoutPage

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: CartItemsWidget(), // Use the CartItemsWidget to display cart items
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the CheckoutPage when the checkout button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CheckoutPage()),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
