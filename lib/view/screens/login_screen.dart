import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/ventas-clothing-app.appspot.com/o/banner.png?alt=media&token=239ae3d4-f01a-4e71-b211-cc7251caf40b',
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
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.3),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                controller: _password,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  icon: Icon(Icons.lock_outline),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
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
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.black,
                              elevation: 0.0,
                              child: MaterialButton(
                                onPressed: () {},
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Forgot password",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      "Create an account",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black),
                                    ))),
                          ],
                        ),

//                        Padding(
//                          padding: const EdgeInsets.all(16.0),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Text("or sign in with", style: TextStyle(fontSize: 18,color: Colors.grey),),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: MaterialButton(
//                                    onPressed: () {},
//                                    child: Image.asset("images/ggg.png", width: 30,)
//                                ),
//                              ),
//
//                            ],
//                          ),
//                        ),
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
