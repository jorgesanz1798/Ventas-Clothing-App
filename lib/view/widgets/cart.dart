import 'package:flutter/material.dart';
import 'package:ventasclothing/view/widgets/grid_cart_products.dart';

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
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: new Text('Total:'),
                  subtitle: new Text('\$230'),
                ),
              ),
              Expanded(
                child: new MaterialButton(
                  onPressed: () {},
                  color: Colors.blue,
                  child: new Text(
                    'Check out',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
              ),
            ],
          ),
        ),
        Expanded(
          child: listCartProducts,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
        ),
      ],
    );
  }
}
