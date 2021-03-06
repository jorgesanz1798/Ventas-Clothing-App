import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/search_screen.dart';
import 'package:ventasclothing/view/widgets/cart.dart';

class CartScreenWab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 1,
        toolbarHeight: 80,
        actions: <Widget>[
          new IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => new SearchScreen(),
                ),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Cart(),
    );
  }
}
