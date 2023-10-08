import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dressupexchange_mobile/models/user_model.dart';
import 'package:dressupexchange_mobile/models/product_model.dart';

class ApiService {
  static const String baseUrl = 'https://dressupexchange.somee.com/api';
  final _secureStorage = FlutterSecureStorage();

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
      return accessToken;
    } else {
      throw Exception('Failed to fetch access token');
    }
  }

  //Get Access Token
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  //Product
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
}
