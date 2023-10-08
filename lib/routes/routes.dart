import 'package:flutter/material.dart';
import 'package:dressupexchange_mobile/pages/home_page.dart';
import 'package:dressupexchange_mobile/pages/product_pages/product_detail_page.dart';
import 'package:dressupexchange_mobile/pages/welcome_page.dart';
import 'package:dressupexchange_mobile/pages/login_page.dart';
import 'package:dressupexchange_mobile/pages/signup_page.dart';
import 'package:dressupexchange_mobile/pages/introduction_screen.dart';
import 'package:dressupexchange_mobile/models/product_model.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (context) => WelcomePage());
    case "/login":
      return MaterialPageRoute(builder: (context) => LoginPage());
    case "/signup":
      return MaterialPageRoute(builder: (context) => SignupPage());
    case "/home":
      return MaterialPageRoute(builder: (context) => HomePage());
    case "/productDetail":
      if (settings.arguments != null &&
          settings.arguments is Map<String, dynamic>) {
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        final product = arguments['product'] as Product;
        return MaterialPageRoute(
          builder: (context) => ProductDetailPage(product: product),
        );
      }
      return _errorRoute();

    case "/introduction":
      return MaterialPageRoute(builder: (context) => IntroductionScreens());
    default:
      return _errorRoute();
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(title: Text('Error')),
      body: Center(child: Text('Page not found')),
    ),
  );
}
