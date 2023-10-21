import 'package:flutter/material.dart';
import 'package:dressupexchange_mobile/services/api_service.dart';

class SignupPage extends StatelessWidget {
  final ApiService _apiService = ApiService();

  // Define TextEditingController objects for the text fields
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 30.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: phoneController, // Use the phoneController
                decoration: InputDecoration(
                  hintText: "Phone",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController, // Use the passwordController
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: fullnameController, // Use the fullnameController
                decoration: InputDecoration(
                  hintText: "Fullname",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: addressController, // Use the addressController
                decoration: InputDecoration(
                  hintText: "Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      // Add your logic here
                    },
                  ),
                  Text("I agree to the Policies and Terms"),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _apiService.registerUser(
                      phoneController.text,
                      passwordController.text,
                      fullnameController.text,
                      addressController.text,
                    );
                    Navigator.pushNamed(context, "/login");
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Registration Failed"),
                          content: Text(
                              "Failed to register. Please try again later."),
                          actions: <Widget>[
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                ),
                child: Text("Sign Up"),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
