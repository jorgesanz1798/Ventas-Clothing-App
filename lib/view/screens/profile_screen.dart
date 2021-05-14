import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(padding: const EdgeInsets.only(top: 25)),
      Row(
        children: [
          Expanded(
            child: MaterialButton(
              child: new Text(
                'Sign in / Sign up',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (context) => new Login(),
                ),
              ),
            ),
          ),
        ],
      ),
      /*
      Row(
        children: [
          Expanded(
            child: Container(
              height: 160,
              child: UserAccountsDrawerHeader(
                accountName: Text('Jorge'),
                accountEmail: Text('jorge.ventas@clothing.com'),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),*/
    ]);
  }
}
