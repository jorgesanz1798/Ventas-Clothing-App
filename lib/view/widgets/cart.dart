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
}
