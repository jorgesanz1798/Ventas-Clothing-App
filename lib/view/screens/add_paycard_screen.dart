import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:credit_card/credit_card_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:credit_card/flutter_credit_card.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddCreditCardScreen extends StatefulWidget {
  @override
  _AddCreditCardScreenState createState() => _AddCreditCardScreenState();
}

class _AddCreditCardScreenState extends State<AddCreditCardScreen> {
  String cardNumber = "";
  String cardHolderName = "";
  String cvvNumber = "";
  String expiryDate = "";
  bool showBackView = false;

  void onCreditCardModel(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      cardHolderName = creditCardModel.cardHolderName;
      expiryDate = creditCardModel.expiryDate;
      cvvNumber = creditCardModel.cvvCode;
      showBackView = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              height: 210,
              cardHolderName: cardHolderName,
              cvvCode: cvvNumber,
              showBackView: showBackView,
              cardBgColor: Colors.greenAccent,
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              animationDuration: Duration(milliseconds: 1200),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CreditCardForm(
                  onCreditCardModelChange: onCreditCardModel,
                  cursorColor: Colors.blue,
                  themeColor: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 5, right: 5),
              child: MaterialButton(
                onPressed: () {
                  if (cardNumber.isNotEmpty &&
                      expiryDate.isNotEmpty &&
                      cardHolderName.isNotEmpty &&
                      cvvNumber.isNotEmpty) {
                    savePaymentCard();
                    Navigator.of(context).pop();
                  }
                  if (cardNumber.length < 16) {
                    Fluttertoast.showToast(
                      msg: "Error card number not valid",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: "Error to add payment card",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 0.2,
                child: new Text('Add payment card'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> savePaymentCard() async {
    CollectionReference _paycard =
        FirebaseFirestore.instance.collection('payments_cards');
    User? _user = FirebaseAuth.instance.currentUser;
    await _paycard
        .add({
          'cardNumber': cardNumber,
          'cardHolderName': cardHolderName,
          'expiryDate': expiryDate,
          'cvvNumber': cvvNumber,
          'user': _user!.uid,
        })
        .then((value) => Fluttertoast.showToast(
              msg: "Payment card added",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            ))
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => print('Failed to add product'));
  }
}
