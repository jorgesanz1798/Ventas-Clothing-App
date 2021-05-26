// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:ventasclothing/view/screens/cart_screen_wab.dart';

// ignore: must_be_immutable
class SweatshirtsDetails extends StatefulWidget {
  final String name;
  final int oldPrice;
  final double price;
  List image = [];
  List color = [];
  List size = [];
  List stock = [];
  final String description;

  SweatshirtsDetails(this.name, this.oldPrice, this.price, this.image,
      this.stock, this.description, this.size, this.color);

  @override
  _SweatshirtsDetailsState createState() => _SweatshirtsDetailsState();
}

class _SweatshirtsDetailsState extends State<SweatshirtsDetails> {
  var colorTshirt;
  bool favourite = false;

  void favouriteTshirt() {
    setState(() {
      favourite = true;
    });
  }

  Future<void> saveFavourite() {
    CollectionReference _favourite =
        FirebaseFirestore.instance.collection('favourite');
    User? _user = FirebaseAuth.instance.currentUser;
    return _favourite
        .add({
          'product': [widget.name],
          'user': _user!.uid,
        })
        .then((value) => print('Add to favourite'))
        .catchError((error) => print('Failed to add product'));
  }

  Future<void> addToCart() {
    CollectionReference _favourite =
        FirebaseFirestore.instance.collection('cart');
    User? _user = FirebaseAuth.instance.currentUser;
    return _favourite
        .add({
          'product': [widget.name],
          'user': _user!.uid,
        })
        .then((value) => print('Add to favourite'))
        .catchError((error) => print('Failed to add product'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 1,
        toolbarHeight: 80,
        actions: <Widget>[
          new IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          new IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreenWab()));
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: new Text('Buy now'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    addToCart();
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: new Text('Add to cart'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
              ),
            ],
          ),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                color: Colors.white,
                child: Container(
                  height: 400,
                  child: new Carousel(
                    boxFit: BoxFit.cover,
                    images: [
                      PhotoView(
                        imageProvider: NetworkImage("${widget.image[0]}"),
                        /*AssetImage("assets/images/originalWhite.png")*/
                        backgroundDecoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        minScale: 0.07,
                        maxScale: 0.35,
                      ),
                      PhotoView(
                        imageProvider: NetworkImage("${widget.image[1]}"),
                        /*AssetImage("assets/images/originalWhite.png")*/
                        backgroundDecoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        minScale: 0.07,
                        maxScale: 0.35,
                      ),
                    ],
                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.white,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.transparent,
                    borderRadius: true,
                    autoplay: false,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 3500),
                    dotIncreasedColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: new Container(
              color: Colors.white,
              child: ListTile(
                title: Row(
                  children: [
                    Text(
                      "${widget.name}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 75, right: 75),
                    ),
                    new FavoriteButton(
                      isFavorite: false,
                      valueChanged: (_isFavorite) {
                        saveFavourite();
                        print('Is Favorite : $_isFavorite');
                      },
                    ),
                  ],
                ),
                subtitle: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: new Text(
                      "${widget.price}",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                  new Text(
                    "${widget.oldPrice}",
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.red,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8),
            ),
          ),
          Container(
            height: 30,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                ),
                Row(children: [
                  new Text("Size:"),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1.0),
                    ),
                    child: Text('S'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1.0),
                    ),
                    child: Text('M'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1.0),
                    ),
                    child: Text('L'),
                  ),
                ]),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 260),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 260),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 260),
            ),
          ),
        ],
      ),
    );
  }
}
