import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    print(_user!.uid);
    // ignore: unnecessary_null_comparison
    if (_user != null) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .where("user", isEqualTo: "${_user.uid}")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: EdgeInsets.only(top: 25),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: MediaQuery.of(context).size.width / (150),
              ),
              children: snapshot.data!.docs.map(
                (document) {
                  var nameProduct = document['product'][0];
                  var size = document['product'][1];
                  var color = document['product'][2];
                  var imagenProduct = document['product'][3];
                  var priceProduct = document['product'][4];
                  return new SingleCartProduct(
                    cartProductName: nameProduct,
                    cartProductImage: imagenProduct,
                    cartProductPrice: priceProduct,
                    cartProductColor: color,
                    cartProductSize: size,
                    cartProductQuantity: 1,
                  );
                },
              ).toList(),
            ),
          );
        },
      );
    }
    return Text('No has iniciado sesion');
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[100],
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
              constraints: BoxConstraints(minWidth: 180, maxWidth: 180),
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
      ),
    );
  }
}
