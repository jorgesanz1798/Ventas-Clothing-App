// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:ventasclothing/view/screens/buy_now_screen.dart';
import 'package:ventasclothing/view/screens/cart_screen_wab.dart';
import 'package:ventasclothing/view/screens/search_screen.dart';

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
  final String categoria;
  final int ventas;

  SweatshirtsDetails(
    this.name,
    this.oldPrice,
    this.price,
    this.image,
    this.stock,
    this.description,
    this.size,
    this.color,
    this.categoria,
    this.ventas,
  );

  @override
  _SweatshirtsDetailsState createState() => _SweatshirtsDetailsState();
}

class _SweatshirtsDetailsState extends State<SweatshirtsDetails> {
  var _colorSweatshirt;
  var _sizeSelected;
  late bool favourite;
  var _quantity = 1;

  void favouriteTshirt() {
    setState(() {
      favourite = true;
    });
  }

  @override
  void initState() {
    super.initState();
    try {
      esFavorito();
      build(context);
    } catch (error) {
      ErrorWidget.builder = (FlutterErrorDetails details) =>
          Center(child: CircularProgressIndicator());
    }
  }

  void onSizeSelected(String size) {
    setState(() {
      if (_sizeSelected == size) {
        _sizeSelected = null;
      } else {
        _sizeSelected = size;
      }
    });
  }

  Future<void> saveFavourite() {
    CollectionReference _favourite =
        FirebaseFirestore.instance.collection('favourite');
    User? _user = FirebaseAuth.instance.currentUser;
    return _favourite.add({
      'productName': widget.name,
      'image': widget.image,
      'size': widget.size,
      'categoria': widget.categoria,
      'ventas': widget.ventas,
      'stock': widget.stock,
      'color': widget.color,
      'price': widget.price,
      'old_price': widget.oldPrice,
      'description': widget.description,
      'user': _user!.uid,
    }).then((value) => Fluttertoast.showToast(
          msg: "Product added to favourites",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        ));
  }

  Future<void> removeFavourite() async {
    CollectionReference _favourite =
        FirebaseFirestore.instance.collection('favourite');
    User? _user = FirebaseAuth.instance.currentUser;
    await _favourite
        .where("productName", isEqualTo: "${widget.name}")
        .where("user", isEqualTo: "${_user!.uid}")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) => {doc.reference.delete()});
    });
  }

  Future<void> addToCart() {
    _colorSweatshirt = widget.color[0];
    CollectionReference _cart = FirebaseFirestore.instance.collection('cart');
    User? _user = FirebaseAuth.instance.currentUser;
    return _cart
        .add({
          'product': widget.name,
          'size': _sizeSelected,
          'color': _colorSweatshirt,
          'image': widget.image[0],
          'price': widget.price,
          'user': _user!.uid,
          'quantity': _quantity,
        })
        .then((value) => Fluttertoast.showToast(
              msg: "Product added to cart",
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

  Future<void> esFavorito() async {
    CollectionReference _favourite =
        FirebaseFirestore.instance.collection('favourite');
    User? _user = FirebaseAuth.instance.currentUser;
    await _favourite
        .where("user", isEqualTo: "${_user!.uid}")
        .where("productName", isEqualTo: "${widget.name}")
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        setState(() {
          this.favourite = false;
        });
      }
      querySnapshot.docs.forEach(
        (doc) => {
          setState(() {
            this.favourite = true;
          }),
        },
      );
    });
  }

  void addToCount() {
    _quantity = _quantity + 1;
  }

  void substractToCount() {
    _quantity = _quantity - 1;
  }

  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    if (_user == null) {
      favourite = false;
    }
    if (_user != null) {
      esFavorito();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 1,
        toolbarHeight: 80,
        actions: <Widget>[
          new IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => new SearchScreen(),
                ),
              );
            },
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
          child: Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      if (_sizeSelected == null && _user != null) {
                        Fluttertoast.showToast(
                          msg: "Select a size",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                      if (_user == null) {
                        Fluttertoast.showToast(
                          msg: "Sign in to buy",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                      if (_sizeSelected != null && _user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => new BuyNowScreen(
                              widget.name,
                              widget.image[0],
                              widget.price,
                              _sizeSelected,
                              widget.color[0],
                              _quantity,
                            ),
                          ),
                        );
                      }
                    },
                    color: _user != null ? Colors.blue : Colors.grey,
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
                      if (_sizeSelected != null &&
                          _user != null &&
                          _user.emailVerified) {
                        addToCart();
                      }
                      if (_user == null && _user != null) {
                        Fluttertoast.showToast(
                          msg: "Sign in to buy",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                      if (_sizeSelected == null && _user != null) {
                        Fluttertoast.showToast(
                          msg: "Select a size",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    color: _user != null ? Colors.blue : Colors.grey,
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
                        backgroundDecoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        minScale: 0.07,
                        maxScale: 0.35,
                      ),
                      PhotoView(
                        imageProvider: NetworkImage("${widget.image[1]}"),
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
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: new Container(
                  color: Colors.white,
                  child: ListTile(
                    title: Row(
                      children: [
                        Container(
                          constraints: BoxConstraints(minWidth: 300),
                          child: Text(
                            "${widget.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        _user == null
                            ? Container()
                            : new FavoriteButton(
                                isFavorite: favourite,
                                valueChanged: (_isFavorite) {
                                  if (_isFavorite == true) {
                                    saveFavourite();
                                  }
                                  if (_isFavorite == false) {
                                    removeFavourite();
                                  }
                                },
                              ),
                      ],
                    ),
                    subtitle: Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: new Text(
                          "${widget.price}" + "€",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                      new Text(
                        widget.oldPrice == 0 ? "" : "${widget.oldPrice}" + "€",
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ]),
                  ),
                ),
              )
            ],
          ),
          _user == null
              ? Container()
              : Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text('Quantity: '),
                      ),
                      new IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          if (_quantity > 1) {
                            substractToCount();
                          }
                        },
                      ),
                      new Text("$_quantity"),
                      new IconButton(
                        icon: Icon(Icons.add_circle),
                        onPressed: () => addToCount(),
                      ),
                    ],
                  ),
                ),
          Container(
            height: 40,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: List.generate(
                  widget.size.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Material(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(3),
                        onTap: () {
                          print(widget.size[index]);
                          onSizeSelected(widget.size[index]);
                        },
                        child: Ink(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: _sizeSelected == widget.size[index]
                                ? Colors.blue
                                : Colors.white,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.size[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      color: _sizeSelected == widget.size[index]
                                          ? Colors.white
                                          : Colors.black87),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
