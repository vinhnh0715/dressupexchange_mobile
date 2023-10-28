import 'package:dressupexchange_mobile/pages/faq_page.dart';
import 'package:dressupexchange_mobile/pages/forgot_password_page.dart';
import 'package:dressupexchange_mobile/pages/otp_verification_page.dart';
import 'package:dressupexchange_mobile/pages/product_pages/cart_page.dart';
import 'package:dressupexchange_mobile/pages/profile_page.dart';
import 'package:flutter/material.dart';
//Pages
import 'package:dressupexchange_mobile/pages/home_page.dart';
import 'package:dressupexchange_mobile/pages/product_pages/product_detail_page.dart';
import 'package:dressupexchange_mobile/pages/welcome_page.dart';
import 'package:dressupexchange_mobile/pages/login_page.dart';
import 'package:dressupexchange_mobile/pages/signup_page.dart';
import 'package:dressupexchange_mobile/pages/introduction_screen.dart';
import 'package:dressupexchange_mobile/pages/menu_page.dart';
//Models
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
    case "/menu":
      return MaterialPageRoute(builder: (context) => MenuPage());
    case "/profile":
      return MaterialPageRoute(builder: (context) => ProfilePage());
    case "/faq":
      return MaterialPageRoute(builder: (context) => FaqPage());
    case "/forgot_password":
      return MaterialPageRoute(builder: (context) => ForgotPasswordPage());
    case "/otp_verification":
      return MaterialPageRoute(builder: (context) => OTPVerificationPage());
    case "/productDetail":
      if (settings.arguments != null && settings.arguments is Map<String, dynamic>) {
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        final product = arguments['product'] as Product;
        return MaterialPageRoute(
          builder: (context) => ProductDetailPage(product: product),
        );
      }
      return _errorRoute();
    case "/cart":
      return MaterialPageRoute(builder: (context) => CartPage());
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
