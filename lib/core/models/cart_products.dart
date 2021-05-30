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
          print('aaaaa $snapshot');
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                      size: 100,
                    ),
                    Text(
                      'Cart empty',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
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
                  var nameProduct = document['product'];
                  var size = document['size'];
                  var color = document['color'];
                  var imagenProduct = document['image'];
                  var priceProduct = document['price'];
                  var quantity = document['quantity'];
                  return new SingleCartProduct(
                    cartProductName: nameProduct,
                    cartProductImage: imagenProduct,
                    cartProductPrice: priceProduct,
                    cartProductColor: color,
                    cartProductSize: size,
                    cartProductQuantity: quantity,
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

// ignore: must_be_immutable
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

  void removeToCart() {
    CollectionReference _cart = FirebaseFirestore.instance.collection('cart');
    User? _user = FirebaseAuth.instance.currentUser;
    _cart
        .where("product", isEqualTo: "$cartProductName")
        .where("color", isEqualTo: "$cartProductColor")
        .where("size", isEqualTo: "$cartProductSize")
        .where("user", isEqualTo: "${_user!.uid}")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) => {doc.reference.delete()});
    });
  }

  void addToCount() {
    CollectionReference _cart = FirebaseFirestore.instance.collection('cart');
    User? _user = FirebaseAuth.instance.currentUser;
    _cart
        .where("product", isEqualTo: "$cartProductName")
        .where("color", isEqualTo: "$cartProductColor")
        .where("size", isEqualTo: "$cartProductSize")
        .where("user", isEqualTo: "${_user!.uid}")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) => {
            doc.reference.update({'quantity': doc['quantity'] + 1})
          });
    });
  }

  void substractToCount() {
    CollectionReference _cart = FirebaseFirestore.instance.collection('cart');
    User? _user = FirebaseAuth.instance.currentUser;
    _cart
        .where("product", isEqualTo: "$cartProductName")
        .where("color", isEqualTo: "$cartProductColor")
        .where("size", isEqualTo: "$cartProductSize")
        .where("user", isEqualTo: "${_user!.uid}")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) => {
            doc.reference.update({'quantity': doc['quantity'] - 1})
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartProductQuantity * cartProductPrice;
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
                      Text(totalPrice.toStringAsFixed(2)),
                      new IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          if (cartProductQuantity > 1) {
                            substractToCount();
                          }
                        },
                      ),
                      new Text("$cartProductQuantity"),
                      new IconButton(
                          icon: Icon(Icons.add_circle),
                          onPressed: () => addToCount()),
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
                      onPressed: () {
                        removeToCart();
                      },
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
