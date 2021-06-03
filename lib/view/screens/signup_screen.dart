import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/utils/core/email_auth.dart';
import 'package:ventasclothing/view/screens/verify_user_screen.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool validateForm() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
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
      body: Stack(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius:
                          20.0, // has the effect of softening the shadow
                    )
                  ],
                ),
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 80, bottom: 25),
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              'assets/images/banner.png',
                              scale: 8.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.3),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                controller: _name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Name",
                                  icon: Icon(Icons.person_outline),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "The user's name field cannot be empty";
                                  } else if (value.length < 6) {
                                    return "the user's name has to be at least 6 characters long";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
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
                                  final bool isValid =
                                      EmailValidator.validate(_email.text);

                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (value.isNotEmpty &&
                                      isValid == false) {
                                    return 'Please enter a valid email';
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
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
                                  // ignore: unnecessary_null_comparison
                                  if (value!.isEmpty || value == null) {
                                    return "The password field cannot be empty";
                                  } else if (value.length < 6) {
                                    return "the password has to be at least 6 characters long";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.3),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                obscureText: true,
                                controller: _confirmpassword,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Confirm password",
                                  icon: Icon(Icons.lock_outline),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "The confirm password field cannot be empty";
                                  } else if (value != _password.text) {
                                    return "The confirm password field not peer with password field";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                          child: Material(
                              child: MaterialButton(
                            color: Colors.blue,
                            onPressed: () async {
                              if (validateForm() == true) {
                                await EmailAuthService
                                    .registerWithEmailAndPassword(
                                        _email.text, _password.text);
                                Navigator.of(context).pushReplacement(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            VerifyUserScreen(_name.text)));
                              }
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              "Sign up",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          )),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
