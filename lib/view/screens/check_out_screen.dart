import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:ventasclothing/core/models/buy_now_payments_cards.dart';
import 'package:ventasclothing/core/models/buy_now_product.dart';
import 'package:ventasclothing/view/screens/add_paycard_screen.dart';
import 'package:ventasclothing/view/shared/navigation_app_bar.dart';
import 'package:ventasclothing/view/widgets/add_payment_card_buttton.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  TextEditingController _street = TextEditingController();
  TextEditingController _doorway = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _postalcode = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var hayTarjeta = false;
  late bool validado;
  var uuid = Uuid();
  late String uuidCode;
  var selected;
  double totalPrice = 0.0;
  void selectPaymentCard(String cardNumberSelected) {
    if (selected == cardNumberSelected) {
      setState(() {
        selected = null;
      });
    } else {
      setState(() {
        selected = cardNumberSelected;
      });
    }
  }

  void obtenerTarjetas() async {
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
  void initState() {
    super.initState();
    setState(() {
      this.validado = true;
      uuidCode = uuid.v1();
    });
  }

  void validateForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        this.validado = true;
      });
    } else {
      setState(() {
        this.validado = false;
      });
    }
  }

  void obtenerPrecioTotal2() async {
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

  Future<void> guardarDatos() {
    CollectionReference _usersorders =
        FirebaseFirestore.instance.collection('usersorders');
    User? _user = FirebaseAuth.instance.currentUser;
    return _usersorders.add({
      'address': [
        _street.text,
        _doorway.text,
        _city.text,
        _postalcode.text,
      ],
      'paymentCard': selected,
      'code': uuidCode,
      'user': _user!.uid,
      'state': 'Proccesing'
    }).then(
      (value) => Fluttertoast.showToast(
        msg: "Purchase correct",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      ),
    );
  }

  Future<void> realizarCompra() async {
    CollectionReference _cart = FirebaseFirestore.instance.collection('cart');
    CollectionReference _orders =
        FirebaseFirestore.instance.collection('orders');
    User? _user = FirebaseAuth.instance.currentUser;
    await _cart.where("user", isEqualTo: "${_user!.uid}").get().then(
      (querySnapshot) {
        querySnapshot.docs.forEach(
          (doc) => {
            _orders.add({
              'product': doc['product'],
              'size': doc['size'],
              'color': doc['color'],
              'image': doc['image'],
              'price': doc['price'],
              'quantity': doc['quantity'],
              'code': uuidCode,
            }),
            Fluttertoast.showToast(
              msg: "Purchase correct",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            ),
            this.borrarCarrito()
          },
        );
      },
    );
  }

  Future<void> borrarCarrito() async {
    CollectionReference _cart = FirebaseFirestore.instance.collection('cart');
    User? _user = FirebaseAuth.instance.currentUser;
    await _cart
        .where("user", isEqualTo: "${_user!.uid}")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) => {doc.reference.delete()});
    });
  }

  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    obtenerTarjetas();
    obtenerPrecioTotal2();
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
            child: Row(
              children: [
                Text(
                  'RESUME',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 150),
                  child: Text(
                    totalPrice.toStringAsFixed(2) + "€",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('cart')
                  .where("user", isEqualTo: "${_user!.uid}")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      childAspectRatio:
                          MediaQuery.of(context).size.width / (150),
                    ),
                    children: snapshot.data!.docs.map(
                      (document) {
                        var nameProduct = document['product'];
                        var size = document['size'];
                        var color = document['color'];
                        var imagenProduct = document['image'];
                        var priceProduct = document['price'];
                        var quantity = document['quantity'];
                        return new SingleBuyNowProduct(
                          nameProduct,
                          imagenProduct,
                          priceProduct,
                          color,
                          size,
                          quantity,
                        );
                      },
                    ).toList(),
                  ),
                );
              },
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
            height: 254,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('payments_cards')
                  .where("user", isEqualTo: "${_user.uid}")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.credit_card,
                            color: Colors.black,
                            size: 100,
                          ),
                          Text(
                            'You dont have a payment card yet',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
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
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    child: Column(
                      children: List.generate(
                        1,
                        (index) => Container(
                          height: 225,
                          child: ListView(
                            children: snapshot.data!.docs.map(
                              (document) {
                                var cardNumber = document['cardNumber'];
                                var cardHolderName = document['cardHolderName'];
                                var cvvNumber = document['cvvNumber'];
                                var expiryDate = document['expiryDate'];
                                return Row(
                                  children: [
                                    new Column(
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 0),
                                            child: new IconButton(
                                              icon: Icon(
                                                selected == cardNumber
                                                    ? Icons.circle
                                                    : Icons.circle_outlined,
                                                color: selected == cardNumber
                                                    ? Colors.blue
                                                    : Colors.black,
                                              ),
                                              onPressed: () {
                                                selectPaymentCard(cardNumber);
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Container(
                                        height: 150,
                                        child: new BuyNowSinglePaymentCard(
                                            cardNumber,
                                            cardHolderName,
                                            cvvNumber,
                                            expiryDate),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
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
            height: validado == true ? 400 : 453,
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "The street field cannot be empty";
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
                            controller: _doorway,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Doorway",
                              icon: Icon(Icons.door_back),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "The doorway field cannot be empty";
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
                            controller: _city,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "City",
                              icon: Icon(Icons.location_city),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "The city field cannot be empty";
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
                            controller: _postalcode,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Postal code",
                              icon: Icon(Icons.chrome_reader_mode_outlined),
                            ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Postal code field cannot be empty";
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
                          onPressed: () {
                            validateForm();
                            if (validado == true && selected != null) {
                              guardarDatos();
                              realizarCompra();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NavigationAppBar(),
                                ),
                              );
                            }
                            if (selected == null) {
                              Fluttertoast.showToast(
                                msg: "Select a payment card",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          },
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
