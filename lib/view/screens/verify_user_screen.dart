import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/view/shared/navigation_app_bar.dart';

// ignore: must_be_immutable
class VerifyUserScreen extends StatefulWidget {
  @override
  _VerifyUserScreenState createState() => _VerifyUserScreenState();
}

class _VerifyUserScreenState extends State<VerifyUserScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => NavigationAppBar(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 250),
          child: Container(
            child: Column(
              children: [
                Icon(
                  Icons.mail,
                  color: Colors.black,
                  size: 100,
                ),
                Text('Verify your email'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
