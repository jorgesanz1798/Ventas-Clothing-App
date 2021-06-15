import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/core/models/orders_products.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    try {
      build(context);
    } catch (error) {
      ErrorWidget.builder = (FlutterErrorDetails details) =>
          Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 1,
        toolbarHeight: 80,
        actions: <Widget>[],
      ),
      body: _user != null && _user.emailVerified
          ? Column(
              children: <Widget>[
                Expanded(
                  child: OrdersProducts(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                ),
              ],
            )
          : Container(
              child: Center(
                child: Text(
                  "Sign in to view the orders",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
    );
  }
}
