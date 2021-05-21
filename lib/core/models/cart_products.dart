import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var productsOnTheCart = [
    {
      "name": "Ventas original Tshirt",
      "image": "assets/images/originalWhite.png",
      "price": 10.99,
      "size": "M",
      "color": "red",
      "quantity": 1,
    },
    {
      "name": "Ventas roman Tshirt",
      "image": "assets/images/romanWhite.png",
      "price": 10.99,
      "size": "L",
      "color": "blue",
      "quantity": 1,
    },
    {
      "name": "Ventas vc Tshirt",
      "image": "assets/images/vcWhite.png",
      "price": 10.99,
      "size": "S",
      "color": "black",
      "quantity": 1,
    },
    {
      "name": "Ventas original Tshirt",
      "image": "assets/images/originalWhite.png",
      "price": 10.99,
      "size": "M",
      "color": "red",
      "quantity": 1,
    },
    {
      "name": "Ventas roman Tshirt",
      "image": "assets/images/romanWhite.png",
      "price": 10.99,
      "size": "L",
      "color": "blue",
      "quantity": 1,
    },
    {
      "name": "Ventas vc Tshirt",
      "image": "assets/images/vcWhite.png",
      "price": 10.99,
      "size": "S",
      "color": "black",
      "quantity": 1,
    },
    {
      "name": "Ventas original Tshirt",
      "image": "assets/images/originalWhite.png",
      "price": 10.99,
      "size": "M",
      "color": "red",
      "quantity": 1,
    },
    {
      "name": "Ventas roman Tshirt",
      "image": "assets/images/romanWhite.png",
      "price": 10.99,
      "size": "L",
      "color": "blue",
      "quantity": 1,
    },
    {
      "name": "Ventas vc Tshirt",
      "image": "assets/images/vcWhite.png",
      "price": 10.99,
      "size": "S",
      "color": "black",
      "quantity": 1,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 25, left: 20, right: 20),
              height: 125,
              child: new SingleCartProduct(
                cartProductName: productsOnTheCart[index]['name'],
                cartProductImage: productsOnTheCart[index]['image'],
                cartProductPrice: productsOnTheCart[index]['price'],
                cartProductColor: productsOnTheCart[index]['size'],
                cartProductSize: productsOnTheCart[index]['color'],
                cartProductQuantity: productsOnTheCart[index]['quantity'],
              ),
            ),
          ],
        );
      },
      itemCount: productsOnTheCart.length,
    );
  }
}

class SingleCartProduct extends StatelessWidget {
  final cartProductName;
  final cartProductImage;
  final cartProductPrice;
  final cartProductSize;
  final cartProductColor;
  final cartProductQuantity;

  SingleCartProduct(
      {this.cartProductName,
      this.cartProductImage,
      this.cartProductPrice,
      this.cartProductSize,
      this.cartProductColor,
      this.cartProductQuantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      child: Row(
        children: [
          new Image.asset(
            cartProductImage,
          ),
          Padding(padding: const EdgeInsets.only(right: 25)),
          Column(
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
                  Text("$cartProductPrice"),
                  new IconButton(
                      icon: Icon(Icons.remove_circle), onPressed: () {}),
                  new Text("$cartProductQuantity"),
                  new IconButton(
                      icon: Icon(Icons.add_circle), onPressed: () {}),
                ],
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.only(right: 25)),
          new Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: new IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
