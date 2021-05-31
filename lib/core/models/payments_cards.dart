import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/add_paycard_screen.dart';

class PaymentsCards extends StatefulWidget {
  @override
  _PaymentsCardsState createState() => _PaymentsCardsState();
}

class _PaymentsCardsState extends State<PaymentsCards> {
  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    print(_user!.uid);
    // ignore: unnecessary_null_comparison
    if (_user != null) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('payments_cards')
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
            padding: EdgeInsets.only(top: 25),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: MediaQuery.of(context).size.width / (150),
              ),
              children: snapshot.data!.docs.map(
                (document) {
                  return new Container();
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
