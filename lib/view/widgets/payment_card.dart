import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/core/models/payments_cards.dart';
import 'package:ventasclothing/view/widgets/add_payment_card_buttton.dart';

class PaymentsCardBuildScreen extends StatefulWidget {
  @override
  _PaymentsCardBuildScreenState createState() =>
      _PaymentsCardBuildScreenState();
}

class _PaymentsCardBuildScreenState extends State<PaymentsCardBuildScreen> {
  var hayTarjeta = false;
  void obtenerPrecioTotal() async {
    CollectionReference _card =
        FirebaseFirestore.instance.collection('payments_cards');
    User? _user = FirebaseAuth.instance.currentUser;
    await _card
        .where("user", isEqualTo: "${_user!.uid}")
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        setState(() {
          this.hayTarjeta = false;
        });
      }
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          this.hayTarjeta = true;
        });
      }
      querySnapshot.docs.forEach(
        (doc) => {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    obtenerPrecioTotal();
    User? _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      return Column(
        children: <Widget>[
          Expanded(
            child: PaymentsCards(),
          ),
          Container(
            child: hayTarjeta ? PaymentCardAddButton() : Container(),
          ),
        ],
      );
    }
    return Container(
      child: Center(child: Text("Sign in to add products to cart.")),
    );
  }
}
