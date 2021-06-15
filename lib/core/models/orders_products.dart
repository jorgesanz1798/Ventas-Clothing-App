import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrdersProducts extends StatefulWidget {
  @override
  _OrdersProductsState createState() => _OrdersProductsState();
}

class _OrdersProductsState extends State<OrdersProducts> {
  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    // ignore: unnecessary_null_comparison
    if (_user != null) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('usersorders')
            .where("user", isEqualTo: "${_user.uid}")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      Icons.card_giftcard,
                      color: Colors.black,
                      size: 100,
                    ),
                    Text(
                      'You have not save any order',
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
                childAspectRatio: MediaQuery.of(context).size.width / 300,
              ),
              children: snapshot.data!.docs.map(
                (document) {
                  var code = document['code'];
                  var state = document['state'];
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.insert_drive_file_rounded,
                              color: Colors.black,
                            ),
                            Text(
                              code,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleOrderProduct(
                          code,
                          state,
                        ),
                      ),
                    ],
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
class SingleOrderProduct extends StatefulWidget {
  String code;
  String state;

  SingleOrderProduct(this.code, this.state);

  @override
  _SingleOrderProductState createState() => _SingleOrderProductState();
}

class _SingleOrderProductState extends State<SingleOrderProduct> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where("code", isEqualTo: "${widget.code}")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Padding(
          padding: EdgeInsets.only(top: 25),
          child: GridView.count(
            crossAxisCount: 1,
            childAspectRatio: MediaQuery.of(context).size.width / (150),
            children: snapshot.data!.docs.map(
              (document) {
                var nameProduct = document['product'];
                var size = document['size'];
                var color = document['color'];
                var imagenProduct = document['image'];
                var priceProduct = document['price'];
                var quantity = document['quantity'];
                double totalPrice = quantity * priceProduct;
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.blue)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                height: 100,
                                width: 80,
                                child: new Image.network(
                                  imagenProduct,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Padding(padding: const EdgeInsets.only(right: 25)),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nameProduct,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text("Size:"),
                                      Text(size),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 25)),
                                      Text("Color:"),
                                      Text(color),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(totalPrice.toStringAsFixed(2) + "€"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('State: '),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(widget.state),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
