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

  // Function to delete a product from the cart
  void deleteCartItem(String productId) async {
    await cartDatabaseHelper.removeFromCart(productId);
    fetchCartItems();
  }

  // Function to update the quantity of a product in the cart
  void updateCartItemQuantity(String productId, int newQuantity) async {
    final cartItem = cartItems.firstWhere((item) => item.productId == productId);
    final updatedCartItem = cartItem.copyWith(quantity: newQuantity);
    await cartDatabaseHelper.updateCartItem(updatedCartItem);
    fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final cartItem = cartItems[index];
        return ListTile(
          title: Text(cartItem.productId), // Display product information as needed
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Price: ${cartItem.price} VND"),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (cartItem.quantity > 1) {
                        updateCartItemQuantity(cartItem.productId, cartItem.quantity - 1);
                      }
                    },
                  ),
                  Text("Quantity: ${cartItem.quantity}"),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      updateCartItemQuantity(cartItem.productId, cartItem.quantity + 1);
                    },
                  ),
                ],
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteCartItem(cartItem.productId);
            },
          ),
        );
      },
    );
  }
}
