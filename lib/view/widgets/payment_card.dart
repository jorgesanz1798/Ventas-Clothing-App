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
  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      return Column(
        children: <Widget>[
          Expanded(
            child: PaymentsCards(),
          ),
          Container(
            child: PaymentCardAddButton(),
          ),
        ],
      );
    }
    return Container(
      child: Center(child: Text("Sign in to add products to cart.")),
    );
  }
}
