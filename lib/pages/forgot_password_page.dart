import 'package:dressupexchange_mobile/services/api_service.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final ApiService _apiService = ApiService();
  String errorMessage = ''; // Initialize error message as empty string

  void _sendOTP(BuildContext context) {
    final String phoneNumber = _phoneNumberController.text;
    _apiService.sendOTP(phoneNumber).then((_) {
      Navigator.pushNamed(context, "/otp_verification");
    }).catchError((error) {
      // Handle the error and set the error message to be displayed
      setState(() {
        errorMessage = 'Failed to send OTP: $error';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _sendOTP(context); // Call the send OTP function
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Text("Send OTP"),
            ),
            if (errorMessage.isNotEmpty) // Display error message if not empty
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
