import 'package:dressupexchange_mobile/pages/home_page.dart';
import 'package:dressupexchange_mobile/pages/product_pages/product_detail_page.dart';
import 'package:dressupexchange_mobile/pages/welcome_page.dart';
import 'package:dressupexchange_mobile/pages/login_page.dart';
import 'package:dressupexchange_mobile/pages/signup_page.dart';

var appRoutes = {
  "/": (context) => WelcomePage(),
  "/login": (context) => LoginPage(),
  "/signup": (context) => SignupPage(),
  "/home": (context) => HomePage(),
  "/productDetail": (context) => ProductDetailPage(),
};
