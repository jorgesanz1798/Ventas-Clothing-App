import 'package:flutter/material.dart';
import 'package:ventasclothing/core/models/favourites.dart';
import 'package:ventasclothing/view/screens/search_screen.dart';

class FavouriteScreen extends StatelessWidget {
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
      body: Favourites(),
    );
  }
}
