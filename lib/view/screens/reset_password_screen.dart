import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/view/shared/navigation_app_bar.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  var resetPasswordSuccessful = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();

  bool validateForm() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  resetPassword() async {
    try {
      auth.sendPasswordResetEmail(email: _email.text);
      resetPasswordSuccessful = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('User not found.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 1,
        toolbarHeight: 80,
        actions: <Widget>[],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/banner.png',
                      scale: 8.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(0.3),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          icon: Icon(Icons.alternate_email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(value))
                              return 'Please make sure your email address is valid';
                            else
                              return null;
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                  child: Material(
                    color: Colors.transparent,
                    child: MaterialButton(
                      color: Colors.blue,
                      onPressed: () async {
                        if (validateForm() == true) {
                          if (resetPasswordSuccessful == true) {
                            Navigator.of(context).pushReplacement(
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        NavigationAppBar()));
                          }
                        }
                      },
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        "Reset your password",
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
            ),
          ),
        ),
      ),
    );
  }
}
