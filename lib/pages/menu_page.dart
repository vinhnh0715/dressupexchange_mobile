import 'package:flutter/material.dart';
import 'package:dressupexchange_mobile/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  late Future<String?> phoneNumber;
  late Future<String?> fullname;

  @override
  void initState() {
    super.initState();
    phoneNumber = _secureStorage.read(key: 'phoneNumber');
    fullname = _secureStorage.read(key: 'name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: FutureBuilder(
        future: Future.wait([phoneNumber, fullname]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            String phoneNumberData = snapshot.data?[0] ?? "";
            String fullnameData = snapshot.data?[1] ?? "";

            return ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Center(
                      child: Text(
                    fullnameData,
                    style: TextStyle(fontSize: 26),
                  )),
                ),
                Center(
                    child: Text(
                  phoneNumberData,
                  style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 128, 128, 128)),
                )),
                Divider(),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Account Detail'),
                  onTap: () {
                    Navigator.pushNamed(context, "/profile");
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.store),
                //   title: Text('Followed Shop'),
                //   onTap: () {},
                // ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notification'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text('Order History'),
                  onTap: () {},
                ),
                // ListTile(
                //   leading: Icon(Icons.account_balance_wallet),
                //   title: Text('Wallet'),
                //   onTap: () {},
                // ),
                // ListTile(
                //   leading: Icon(Icons.local_offer),
                //   title: Text('Sale'),
                //   onTap: () {},
                // ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('FAQ'),
                  onTap: () {
                    Navigator.pushNamed(context, "/faq");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Log Out'),
                  onTap: () async {
                    await _apiService.logout();
                    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
