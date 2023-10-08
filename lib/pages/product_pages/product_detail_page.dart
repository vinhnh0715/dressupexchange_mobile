import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dressupexchange_mobile/models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  ProductDetailPage({required this.product});
  // final String itemId;
  // ProductDetailPage(this.itemId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Carousel
            CarouselSlider(
              items: [
                Image.asset("lib/assets/images/carousel_image1.jpeg"),
                Image.asset("lib/assets/images/carousel_image2.jpeg"),
                Image.asset("lib/assets/images/carousel_image3.jpeg"),
                Image.asset("lib/assets/images/carousel_image4.jpeg"),
                Image.asset("lib/assets/images/carousel_image5.jpeg"),
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

            // Shop
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(
                        "lib/assets/icons/shop.png"), //NetworkImage('shop_image_url'),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Protagonist',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Text('@Protag'),
                  Text('Shop at HoChiMinh City'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Items: 500'),
                      Text('Shop Rating: 4.8'),
                      Text('Respond Rate: 98%'),
                    ],
                  ),
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
            Container(
              height: 120.0,
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    width: 90.0,
                    margin: EdgeInsets.all(8.0),
                    color: Color.fromRGBO(254, 154, 154, 1),
                    child: Center(
                        child: Column(
                      children: [
                        Text(
                          "50%",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text("Grand Opening", style: TextStyle(fontSize: 20))
                      ],
                    )),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15), //apply padding to all four sides
              child: Text(
                "Other items",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              height: 260.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10, // Replace with your actual item count
                itemBuilder: (context, index) {
                  String title = "Item $index";
                  String price = "\$${(index + 1) * 10}";
                  return Container(
                    width: 150.0,
                    margin: EdgeInsets.all(8.0),
                    child: Card(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "lib/assets/images/hatsune_miku.jpeg",
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
            ),
            Padding(
              padding: EdgeInsets.all(15), //apply padding to all four sides
              child: Text(
                "Description",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              child: Text(
                '''
                Main fabric composition: polyester fiber
                Theme elements: Japanese animation
                Set includes: top, skirt, belt, tie, sleeves
                Size: XS-XXL
                ''',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
