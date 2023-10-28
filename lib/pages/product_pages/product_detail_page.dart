import 'package:dressupexchange_mobile/services/api_service.dart';
import 'package:dressupexchange_mobile/utils/cart_database.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dressupexchange_mobile/models/product_model.dart';
import 'package:dressupexchange_mobile/models/cartItem_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  CartDatabaseHelper _cartDatabaseHelper = new CartDatabaseHelper();
  ProductDetailPage({required this.product});

  // final String itemId;
  // ProductDetailPage(this.itemId);
  Future<List<Product>> loadAdditionalItems() async {
    try {
      final apiService = ApiService();
      final products = await apiService.fetchProducts();

      return products;
    } catch (e) {
      // Handle errors, e.g., show an error message or retry logic
      print('Error loading additional items: $e');
      return [];
    }
  }

  String truncateTitle(String title, int maxLength) {
    if (title.length <= maxLength) {
      return title;
    } else {
      return title.substring(0, maxLength) + "...";
    }
  }

  void showToast(BuildContext context, String message, bool isSuccess) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Detail'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, "/cart");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Carousel
            CarouselSlider(
              items: [
                Image.network(
                  product.images.isNotEmpty ? product.images[0] : "", // Use the first image URL if available
                  width: 150.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                )
                // Image.asset("lib/assets/images/carousel_image1.jpeg"),
                // Image.asset("lib/assets/images/carousel_image2.jpeg"),
                // Image.asset("lib/assets/images/carousel_image3.jpeg"),
                // Image.asset("lib/assets/images/carousel_image4.jpeg"),
                // Image.asset("lib/assets/images/carousel_image5.jpeg"),
              ],
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
            // Title
            Text(
              product.name,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            // Price
            Text(
              "Price: ${product.price} VND",
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),

            // Rating and item sold counter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Text('4.5 (1000 sold)'),
              ],
            ),
            //Add to cart
            ElevatedButton(
              onPressed: () async {
                final cartDatabaseHelper = CartDatabaseHelper();
                final cartItem = CartItem(
                  productId: product.productId.toString(),
                  voucherId: 1,
                  laundryId: 1,
                  price: product.price,
                  quantity: 1,
                );

                // Check if the product is already in the cart
                final existingCartItem = await cartDatabaseHelper.getCartItemByProductId(product.productId.toString());

                if (existingCartItem != null) {
                  // If the product is already in the cart, increment its quantity
                  final updatedQuantity = existingCartItem.quantity + 1;
                  final updatedCartItem = existingCartItem.copyWith(quantity: updatedQuantity);
                  final updated = await cartDatabaseHelper.updateCartItem(updatedCartItem);

                  if (updated != null) {
                    // Quantity updated successfully
                    showToast(context, "Product quantity updated in the cart", true);
                  } else {
                    // Failed to update quantity
                    showToast(context, "Failed to update product quantity in the cart", false);
                  }
                } else {
                  // If the product is not in the cart, add it
                  final addedId = await cartDatabaseHelper.addToCart(cartItem);

                  if (addedId != null) {
                    // Add success case
                    showToast(context, "Product added to the cart", true);
                  } else {
                    // Failed to add case
                    showToast(context, "Failed to add the product to the cart", false);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Customize the button color
              ),
              child: Text("Add to Cart"),
            ),

            // Shop
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage("lib/assets/icons/shop.png"), //NetworkImage('shop_image_url'),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Protagonist',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Text('@Protag'),
                  Text('Shop at HoChiMinh City'),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Total Items: 500'),
                  //     Text('Shop Rating: 4.8'),
                  //     Text('Respond Rate: 98%'),
                  //   ],
                  // ),
                ],
              ),
            ),
            //Coupon
            Padding(
              padding: EdgeInsets.all(15), //apply padding to all four sides
              child: Text(
                "Coupons",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            // Container(
            //   height: 120.0,
            //   child: ListView.builder(
            //     padding: EdgeInsets.all(8),
            //     scrollDirection: Axis.horizontal,
            //     itemCount: 2,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         width: 90.0,
            //         margin: EdgeInsets.all(8.0),
            //         color: Color.fromRGBO(254, 154, 154, 1),
            //         child: Center(
            //             child: Column(
            //           children: [
            //             Text(
            //               "50%",
            //               style: TextStyle(fontSize: 20),
            //             ),
            //             Text("Grand Opening", style: TextStyle(fontSize: 20))
            //           ],
            //         )),
            //       );
            //     },
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text('No coupon available at the moment'),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Other items",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            FutureBuilder<List<Product>>(
              future: loadAdditionalItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loading indicator
                } else if (snapshot.hasError) {
                  return Text('Error loading items: ${snapshot.error}');
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return Text('No additional items available');
                } else {
                  final additionalItems = snapshot.data;
                  return Container(
                    height: 400.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: additionalItems!.length,
                      itemBuilder: (context, index) {
                        String title = truncateTitle(additionalItems[index].name, 30); //;
                        String price = "\$${additionalItems[index].price}";

                        return Container(
                          width: 150.0,
                          margin: EdgeInsets.all(8.0),
                          child: Card(
                            margin: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  additionalItems[index].images.isNotEmpty ? additionalItems[index].images[0] : "", // Use the first image URL if available
                                  width: 150.0,
                                  height: 150.0,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 4.0,
                                  ),
                                  child: Text(
                                    price,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Description",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                product.description,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
