import 'package:flutter/material.dart';
import 'package:ventasclothing/view/widgets/categories.dart';
import 'package:ventasclothing/view/widgets/grid_products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Text('Hola'),
        ),
      ],
    );
  }
}
