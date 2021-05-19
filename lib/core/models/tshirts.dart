import 'package:flutter/material.dart';

class Tshirt {
  final int id;
  final String description;
  List image = [];
  final String name;
  double oldPrice;
  double price;
  List size = [];
  int stock;
  List color = [];

  Tshirt(this.description, this.id, this.image, this.name, this.oldPrice,
      this.price, this.size, this.stock, this.color);

  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: id,
        child: Material(
          child: InkWell(
            onTap: () {},
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  title: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        "$price€",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      "$oldPrice€",
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ]),
                ),
              ),
              child: Image.asset(
                image[0],
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
