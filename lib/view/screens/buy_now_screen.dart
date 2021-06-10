import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/core/models/bouy_now_payments_cards.dart';
import 'package:ventasclothing/view/widgets/add_payment_card_buttton.dart';

class BuyNowScreen extends StatefulWidget {
  final cartProductName;
  final cartProductImage;
  final cartProductPrice;
  final cartProductSize;
  final cartProductColor;
  final cartProductQuantity;

  const BuyNowScreen(
    this.cartProductName,
    this.cartProductImage,
    this.cartProductPrice,
    this.cartProductSize,
    this.cartProductColor,
    this.cartProductQuantity,
  );

  @override
  _BuyNowScreenState createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen> {
  TextEditingController _street = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 1,
        toolbarHeight: 80,
        actions: <Widget>[],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'RESUME',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Container(
            height: 125,
            child: SingleBuyNowProduct(
              widget.cartProductName,
              widget.cartProductImage,
              widget.cartProductPrice,
              widget.cartProductSize,
              widget.cartProductColor,
              widget.cartProductQuantity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'CHOOSE A PAYMENT CARD',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Container(
            height: 250,
            child: BuyNowPaymentsCards(),
          ),
          Container(
            child: hayTarjeta ? PaymentCardAddButton() : Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'DELIVERY ADDRESS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Container(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.withOpacity(0.3),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            controller: _street,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Street",
                              icon: Icon(Icons.gite),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.withOpacity(0.3),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            obscureText: true,
                            controller: _street,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Doorway",
                              icon: Icon(Icons.door_back),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "The password field cannot be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.withOpacity(0.3),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            obscureText: true,
                            controller: _street,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "City",
                              icon: Icon(Icons.location_city),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "The password field cannot be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.withOpacity(0.3),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            obscureText: true,
                            controller: _street,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Postal code",
                              icon: Icon(Icons.chrome_reader_mode_outlined),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "The password field cannot be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 8.0),
                      child: Material(
                        color: Colors.transparent,
                        child: MaterialButton(
                          color: Colors.blue,
                          onPressed: () {},
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text(
                            "Buy now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SingleBuyNowProduct extends StatelessWidget {
  final cartProductName;
  final cartProductImage;
  final cartProductPrice;
  final cartProductSize;
  final cartProductColor;
  final cartProductQuantity;

  SingleBuyNowProduct(
      this.cartProductName,
      this.cartProductImage,
      this.cartProductPrice,
      this.cartProductSize,
      this.cartProductColor,
      this.cartProductQuantity);

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartProductQuantity * cartProductPrice;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
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
                      Text("Total price:"),
                      Text(totalPrice.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
