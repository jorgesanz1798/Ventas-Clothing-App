import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/core/models/cart_products.dart';
import 'package:ventasclothing/view/widgets/final_price.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      return Column(
        children: <Widget>[
          Container(
            child: TotalPrice(),
          ),
          Expanded(
            child: CartProducts(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
          ),
        ],
      );
    }
    return Container(
      child: Center(child: Text("Sign in to add products to cart.")),
    );
  }
}
