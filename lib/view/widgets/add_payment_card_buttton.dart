import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/add_paycard_screen.dart';

class PaymentCardAddButton extends StatelessWidget {
  const PaymentCardAddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: MaterialButton(
        onPressed: () => Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (context) => AddCreditCardScreen(),
          ),
        ),
        color: Colors.blue,
        textColor: Colors.white,
        elevation: 0.2,
        child: new Text('Add a payment card'),
      ),
    );
  }
}
