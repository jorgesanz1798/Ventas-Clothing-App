import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ventasclothing/utils/core/google_auth.dart';
import 'package:ventasclothing/view/screens/favourite_products_screen.dart';
import 'package:ventasclothing/view/screens/orders_screen.dart';
import 'package:ventasclothing/view/screens/payments_cards_screen.dart';
import 'package:ventasclothing/view/screens/signin_screen.dart';
import 'package:ventasclothing/view/shared/navigation_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    if (_user != null && _user.emailVerified) {
      return Column(
        children: [
          Container(
            height: 125,
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          new CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                              _user.photoURL == null
                                  ? "https://firebasestorage.googleapis.com/v0/b/ventas-clothing-app.appspot.com/o/user3.png?alt=media&token=3cb0a2e7-1f67-470f-bc81-cb3758efb055"
                                  : "${_user.photoURL}",
                            ),
                          ),
                          new Text(
                            _user.displayName == null
                                ? ""
                                : "${_user.displayName}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 225),
                        child: Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.exit_to_app_outlined),
                              color: Colors.white,
                              iconSize: 45.0,
                              onPressed: () async {
                                await GoogleAuthService.signOutWithGoogle(
                                    context: context);
                                Fluttertoast.showToast(
                                  msg: "Session closed",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                Navigator.of(context).push(
                                  new MaterialPageRoute(
                                    builder: (context) => NavigationAppBar(),
                                  ),
                                );
                              },
                            ),
                            new Text(
                              "Sign out",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 125,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite_outlined),
                        color: Colors.blue,
                        iconSize: 45.0,
                        onPressed: () {
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (context) => FavouriteScreen(),
                            ),
                          );
                        },
                      ),
                      new Text(
                        "Favourites",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.credit_card),
                        color: Colors.blue,
                        iconSize: 45.0,
                        onPressed: () {
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (context) => PaymentsCardsScreen(),
                            ),
                          );
                        },
                      ),
                      new Text(
                        "Payment Cards",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.card_giftcard),
                        color: Colors.blue,
                        iconSize: 45.0,
                        onPressed: () {
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (context) => OrdersScreen(),
                            ),
                          );
                        },
                      ),
                      new Text(
                        "Orders",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Signin();
    }
  }
}
