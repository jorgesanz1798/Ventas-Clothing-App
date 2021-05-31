import 'package:flutter/material.dart';
import 'package:ventasclothing/core/models/payments_cards.dart';

class PaymentsCardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 1,
        toolbarHeight: 80,
        actions: <Widget>[],
      ),
      body: PaymentsCards(),
    );
  }
}
