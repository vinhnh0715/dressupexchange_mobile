import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dressupexchange_mobile/models/user_model.dart';
import 'package:dressupexchange_mobile/models/product_model.dart';
import 'package:dressupexchange_mobile/models/order_model.dart';

class ApiService {
  static const String baseUrl = 'https://dressupexchange.somee.com/api';
  final _secureStorage = FlutterSecureStorage();
  //====================Login/Register====================
  Future<String> fetchAccessToken(String phone, String password) async {
    final url = Uri.parse('$baseUrl/user/login');
    final Map<String, dynamic> requestBody = {
      'phone': phone,
      'password': password,
    };

    final response = await http.post(
      url,
      headers: <String, String>{
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final String accessToken = response.body;
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final String name = jsonResponse['name'];
      final String phoneNumber = jsonResponse['phoneNumber'];
      if (name != null && phoneNumber != null) {
        await _secureStorage.write(key: 'name', value: name.toString());
        await _secureStorage.write(
            key: 'phone_number', value: phoneNumber.toString());
      }
      return accessToken;
    } else {
      throw Exception('Failed to fetch access token');
    }
  }

  Future<void> registerUser(
      String phoneNumber, String password, String name, String address) async {
    final url = Uri.parse('$baseUrl/user/register');
    final Map<String, dynamic> requestBody = {
      'phoneNumber': phoneNumber,
      'password': password,
      'name': name,
      'address': address,
    };

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // User registration was successful.
      // You can handle the response accordingly, e.g., navigate to the login screen.
    } else {
      throw Exception('Failed to register user');
    }
  }

  //====================Get Access Token====================
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  //====================Product===============================
  Future<List<Product>> fetchProducts() async {
    final accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception('Access token not found. Please log in first.');
    }

    final url = Uri.parse('$baseUrl/product');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> productItems = data['items'];
      return productItems.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  Future<Order> placeOrder(Order order) async {
    final accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception('Access token not found. Please log in first.');
    }

    final url = Uri.parse('$baseUrl/order/place');
    final Map<String, dynamic> requestBody = {
      'totalAmount': order.totalAmount,
      'orderItemsRequest': order.orderItems.map((item) {
        return {
          'productID': item.productID,
          'productName': item.productName,
          'quantityBuy': item.quantityBuy,
          'status': item.status,
          'price': item.price,
          'laundry': item.laundry.map((laundry) {
            return {
              'laundryName': laundry.laundryName,
              'laundryPrice': laundry.laundryPrice,
            };
          }).toList(),
        };
      }).toList(),
    };

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Order placement was successful.
      // You can handle the response accordingly, e.g., show a success message.
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to place the order');
    }
  }
  //====================User====================
}
