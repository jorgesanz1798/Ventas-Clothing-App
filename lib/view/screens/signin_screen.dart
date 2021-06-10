import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ventasclothing/utils/core/google_auth.dart';
import 'package:ventasclothing/core/providers/auth_service.dart';
import 'package:ventasclothing/view/screens/reset_password_screen.dart';
import 'package:ventasclothing/view/screens/signup_screen.dart';
import 'package:ventasclothing/view/shared/navigation_app_bar.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final auth = FirebaseAuth.instance;
  late User user;
  var signInSuccessful = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool validateForm() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  iniciarSesion() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
      User? user = auth.currentUser;
      signInSuccessful = true;
      if (user != null && !user.emailVerified) {
        signInSuccessful = false;
        Fluttertoast.showToast(
          msg: "Complete email verification",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: "Wrong password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      if (e.code == 'invalid-email') {
        Fluttertoast.showToast(
          msg: "Invalid email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: "User not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.withOpacity(0.3),
                  elevation: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: _password,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        icon: Icon(Icons.lock_outline),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "The password field cannot be empty";
                        }
                        return null;
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
                        iniciarSesion();
                        if (signInSuccessful == true) {
                          Navigator.of(context).pushReplacement(
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NavigationAppBar()));
                        }
                      }
                    },
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      "Sign in",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ResetPasswordScreen())),
                      child: Text(
                        "Forgot password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () => Navigator.of(context).push(
                              new MaterialPageRoute(
                                  builder: (BuildContext context) => Signup())),
                          child: Text(
                            "Create an account",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                child: SignInButton(
                  Buttons.Google,
                  onPressed: () async {
                    User? user = await GoogleAuthService.signInWithGoogle(
                        context: context);
                    if (user != null) {
                      AuthService _authentication = AuthService();
                      _authentication.addUser(user.uid);
                      Fluttertoast.showToast(
                        msg: "Welcome",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      Navigator.of(context).pushReplacement(
                        new MaterialPageRoute(
                            builder: (context) => NavigationAppBar()),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
