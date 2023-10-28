import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView(
        children: <Widget>[
          FaqItem(
            question: 'How can I place an order?',
            answer: 'To place an order, browse our cosplay collection, select the items you want, add them to your cart, and proceed to checkout.',
          ),
          FaqItem(
            question: 'What are the payment options?',
            answer: 'We accept VNPAY and cash-on-delivery option. You can choose the payment option that suits you best during checkout.',
          ),
          FaqItem(
            question: 'Do you offer international shipping?',
            answer: 'No, our service currently available for HoChiMinh City, VietNam users only',
          ),
          FaqItem(
            question: 'How long does shipping take?',
            answer: 'Shipping times may vary based on your location (the nearer your location to the center of HCM city, the faster the delivery time). We provide estimated delivery times during the checkout process.',
          ),
          FaqItem(
            question: 'What is your return policy?',
            answer: 'Our return policy allows you to return items within 30 days of purchase if they are in unused and original condition.',
          ),
        ],
      ),
    );
  }
}

class FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  FaqItem({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(answer),
        ),
      ],
    );
  }
}
