import 'package:flutter/material.dart';

class OTPVerificationPage extends StatelessWidget {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  void _saveNewPassword(BuildContext context) {
    final String enteredOTP = _otpController.text;
    final String newPassword = _newPasswordController.text;

    // Implement OTP verification and password reset logic here.
    // Verify the entered OTP and update the password.

    // After resetting the password, you can navigate to a login page or home page.
    Navigator.pushNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'Enter OTP'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: 'Enter New Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _saveNewPassword(context); // Call the save password function
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
