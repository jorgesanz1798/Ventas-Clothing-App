import 'package:flutter/material.dart';

class SingleBuyNowProduct extends StatelessWidget {
  final cartProductName;
  final cartProductImage;
  final cartProductPrice;
  final cartProductSize;
  final cartProductColor;
  final cartProductQuantity;

  SingleBuyNowProduct(
      this.cartProductName,
      this.cartProductImage,
      this.cartProductPrice,
      this.cartProductSize,
      this.cartProductColor,
      this.cartProductQuantity);

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartProductQuantity * cartProductPrice;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
        height: 10,
        child: Row(
          children: [
            Container(
              width: 80,
              constraints: BoxConstraints(minWidth: 80, maxWidth: 80),
              child: new Image.network(
                cartProductImage,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(padding: const EdgeInsets.only(right: 25)),
            Container(
              width: 180,
              constraints: BoxConstraints(minWidth: 225, maxWidth: 225),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.only(top: 25)),
                  Text(
                    cartProductName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text("Size:"),
                      Text(cartProductSize),
                      Padding(padding: const EdgeInsets.only(right: 25)),
                      Text("Color:"),
                      Text(cartProductColor),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Quantity: '),
                      Text("$cartProductQuantity"),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Total price: "),
                      ),
                      Text(
                        totalPrice.toString() + "€",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
