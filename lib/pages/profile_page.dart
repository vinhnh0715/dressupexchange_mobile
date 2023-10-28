import 'package:dressupexchange_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _secureStorage = FlutterSecureStorage();
  final _apiService = ApiService();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load the stored user information when the page is initialized
    loadUserInformation();
  }

  Future<void> loadUserInformation() async {
    phoneNumberController.text = await _secureStorage.read(key: 'phoneNumber') ?? '';
    passwordController.text = await _secureStorage.read(key: 'password') ?? '';
    nameController.text = await _secureStorage.read(key: 'name') ?? '';
    addressController.text = await _secureStorage.read(key: 'address') ?? '';
    setState(() {});
  }

  Future<void> saveUserInformation() async {
    _apiService.updateUserProfile(phoneNumberController.text, passwordController.text, nameController.text, addressController.text);
    //show popup here after validation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Phone Number:'),
            TextField(
              controller: phoneNumberController,
            ),
            Text('Password:'),
            TextField(
              controller: passwordController,
            ),
            Text('Name:'),
            TextField(
              controller: nameController,
            ),
            Text('Address:'),
            TextField(
              controller: addressController,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: saveUserInformation,
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
