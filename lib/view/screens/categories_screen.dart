import 'package:flutter/material.dart';
import 'package:ventasclothing/core/models/products.dart';
import 'package:ventasclothing/view/widgets/categories.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Expanded(
          child: Products(),
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
