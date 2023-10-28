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
  Future<Map<String, dynamic>> fetchUserResponse(String phone, String password) async {
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
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['accessToken'] != null) {
        await storeUserFieldsToSecureStorage(jsonResponse);
        await _secureStorage.write(key: 'password', value: password);
        return jsonResponse;
      } else {
        throw Exception('Access token is missing in the response');
      }
    } else {
      throw Exception('Failed to fetch user response');
    }
  }

  Future<void> storeUserFieldsToSecureStorage(Map<String, dynamic> jsonResponse) async {
    final userId = jsonResponse['userId'];
    final phoneNumber = jsonResponse['phoneNumber'];
    final address = jsonResponse['address'];
    final name = jsonResponse['name'];
    final role = jsonResponse['role'];
    final accessToken = jsonResponse['accessToken'];
    final refreshToken = jsonResponse['refreshToken'];
    if (userId != null && phoneNumber != null && address != null && name != null && role != null && accessToken != null && refreshToken != null) {
      await _secureStorage.write(key: 'userId', value: userId.toString());
      await _secureStorage.write(key: 'phoneNumber', value: phoneNumber.toString());
      await _secureStorage.write(key: 'address', value: address.toString());
      await _secureStorage.write(key: 'name', value: name.toString());
      await _secureStorage.write(key: 'role', value: role.toString());
      await _secureStorage.write(key: 'accessToken', value: accessToken.toString());
      await _secureStorage.write(key: 'refreshToken', value: refreshToken.toString());
    } else {
      throw Exception('One or more user fields are missing in the response');
    }
  }

  Future<void> registerUser(String phoneNumber, String password, String name, String address) async {
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
    } else {
      throw Exception('Failed to register user');
    }
  }

  //====================Logout====================
  Future<void> logout() async {
    await _secureStorage.delete(key: 'userId');
    await _secureStorage.delete(key: 'phoneNumber');
    await _secureStorage.delete(key: 'address');
    await _secureStorage.delete(key: 'name');
    await _secureStorage.delete(key: 'role');
    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'refreshToken');
  }

  //====================Getters====================
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'accessToken');
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

    final url = Uri.parse('$baseUrl/order');
    final Map<String, dynamic> requestBody = {
      'totalAmount': order.totalAmount,
      'shippingAddress': order.shippingAddress,
      'orderItemsRequest': order.orderItems.map((item) {
        return {
          'productId': item.productId,
          'voucherId': item.voucherId,
          'laundryId': item.laundryId,
          'price': item.price,
          'buyingQuantity': item.buyingQuantity,
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
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to place the order');
    }
  }

  //====================User====================
  Future<void> updateUserProfile(String phoneNumber, String password, String name, String address) async {
    final accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception('Access token not found. Please log in first.');
    }

    final userId = await _secureStorage.read(key: 'userId');
    if (userId == null) {
      throw Exception('User ID not found in secure storage.');
    }

    final url = Uri.parse('$baseUrl/user/$userId');
    final Map<String, dynamic> requestBody = {
      'phoneNumber': phoneNumber,
      'password': password,
      'name': name,
      'address': address,
    };

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Update user fields in secure storage if needed
      await _secureStorage.write(key: 'phoneNumber', value: phoneNumber);
      await _secureStorage.write(key: 'password', value: password);
      await _secureStorage.write(key: 'name', value: name);
      await _secureStorage.write(key: 'address', value: address);
    } else {
      throw Exception('Failed to update user profile');
    }
  }

  Future<void> sendOTP(String phoneNumber) async {
    final url = Uri.parse('$baseUrl/send-sms/SendOTP?telephoneNumber=$phoneNumber');

    final response = await http.post(
      url,
      headers: <String, String>{
        'accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      // OTP sent successfully
      print('OTP sent successfully');
    } else {
      // Handle the error case when OTP sending fails
      throw Exception('Failed to send OTP. Status code: ${response.statusCode}');
    }
  }
}
