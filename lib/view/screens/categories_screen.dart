import 'package:flutter/material.dart';
import 'package:ventasclothing/view/widgets/categories.dart';
import 'package:ventasclothing/view/widgets/grid_products.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 25, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                height: 80.0,
                child: categories,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 25, left: 20, right: 20),
          child: listProducts,
        ),
      ],
    );
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;

  Category({required this.imageLocation, required this.imageCaption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.network(
              imageLocation,
              width: 100.0,
              height: 60.0,
              color: Colors.blue.withOpacity(1.0),
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(
                imageCaption,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
