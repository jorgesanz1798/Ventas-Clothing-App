import 'package:flutter/material.dart';

class CardProduct extends StatelessWidget {
  final imagenProd;
  final nameProd;
  final priceProd;
  final oldPriceProd;

  const CardProduct(
      this.imagenProd, this.nameProd, this.priceProd, this.oldPriceProd);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            new Image.network(
              imagenProd,
              fit: BoxFit.fitHeight,
              height: 100,
            ),
            Container(
              color: Colors.white70,
              child: ListTile(
                title: Text(
                  nameProd,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                subtitle: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      "$priceProd" + "€",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    oldPriceProd == 0 ? "" : "$oldPriceProd" + "€",
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.red,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
