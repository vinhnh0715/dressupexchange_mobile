import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
                child: Text(
              "Username",
              style: TextStyle(fontSize: 26),
            )),
          ),
          Center(
              child: Text(
            "098765431",
            style: TextStyle(
                fontSize: 16, color: const Color.fromARGB(255, 128, 128, 128)),
          )),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Account Detail'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text('Followed Shop'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Wallet'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.local_offer),
            title: Text('Sale'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('FAQ'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log Out'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
