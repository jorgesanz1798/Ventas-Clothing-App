import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/utils/core/google_auth.dart';
import 'package:ventasclothing/view/screens/signin_screen.dart';
import 'package:ventasclothing/view/shared/navigation_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 160,
                  child: UserAccountsDrawerHeader(
                    accountName: Text("${_user.displayName}"),
                    accountEmail: Text("${_user.email}"),
                    currentAccountPicture: GestureDetector(
                      child: new CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(
                          "${_user.photoURL}",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
            child: Material(
              color: Colors.transparent,
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () async {
                  await GoogleAuthService.signOutWithGoogle(context: context);
                  Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (context) => NavigationAppBar(),
                    ),
                  );
                },
                minWidth: MediaQuery.of(context).size.width,
                child: Text(
                  "Sign out",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
        child: Column(
          children: [
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
                        builder: (context) => new Signin(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
