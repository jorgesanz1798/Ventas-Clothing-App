import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/check_out_screen.dart';

class TotalPrice extends StatefulWidget {
  @override
  _TotalPriceState createState() => _TotalPriceState();
}

class _TotalPriceState extends State<TotalPrice> {
  double totalPrice = 0.0;

  void obtenerPrecioTotal() async {
    CollectionReference _cart = FirebaseFirestore.instance.collection('cart');
    User? _user = FirebaseAuth.instance.currentUser;
    await _cart
        .where("user", isEqualTo: "${_user!.uid}")
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        setState(() {
          this.totalPrice = 0;
        });
      }
      totalPrice = 0;
      var auxTotalPrice = 0.0;
      querySnapshot.docs.forEach(
        (doc) => {
          auxTotalPrice = auxTotalPrice + ((doc['price'] * doc['quantity'])),
          setState(() {
            this.totalPrice = auxTotalPrice;
          })
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    obtenerPrecioTotal();
    if (totalPrice == 0.0) {
      return Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Container(
          color: Colors.white,
          height: 10,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: new Text('Total:'),
                subtitle: new Text(totalPrice.toStringAsFixed(2) + "€"),
              ),
            ),
            Expanded(
              child: new MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckOutScreen(),
                    ),
                  );
                },
                color: Colors.blue,
                child: new Text(
                  'Check out',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
            ),
          ],
        ),
      ),
    );
  }
}
