import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:ventasclothing/view/screens/cart_screen_wab.dart';

// ignore: must_be_immutable
class TshirtDetails extends StatefulWidget {
  final String name;
  final int oldPrice;
  final double price;
  List image = [];
  List color = [];
  List size = [];
  List stock = [];
  final String description;

  TshirtDetails(this.name, this.oldPrice, this.price, this.image, this.stock,
      this.description, this.size, this.color);

  @override
  _TshirtDetailsState createState() => _TshirtDetailsState();
}

class _TshirtDetailsState extends State<TshirtDetails> {
  var colorTshirt;
  bool favourite = false;
  var _sizeSelected;
  var _colorSelected;
  var _imageSelected;

  void onSizeSelected(String size) {
    setState(() {
      _sizeSelected = size;
      print(_sizeSelected);
    });
  }

  void onColorSelected(String color) {
    setState(() {
      _colorSelected = color;
      print(_colorSelected);
    });
  }

  void onImageSelected(option) {
    setState(() {
      _imageSelected = option;
      print(_imageSelected);
    });
  }

  @override
  void initState() {
    super.initState();
    colorTshirt = widget.image[0];
  }

  void changeToWhite() {
    setState(() {
      colorTshirt = widget.image[0];
      onColorSelected(widget.color[0]);
      onImageSelected(0);
    });
  }

  void changeToBlack() {
    setState(() {
      colorTshirt = widget.image[1];
      onColorSelected(widget.color[1]);
      onImageSelected(1);
    });
  }

  void changeToBlue() {
    setState(() {
      colorTshirt = widget.image[2];
      onColorSelected(widget.color[2]);
      onImageSelected(2);
    });
  }

  void changeToRed() {
    setState(() {
      colorTshirt = widget.image[3];
      onColorSelected(widget.color[3]);
      onImageSelected(3);
    });
  }

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
          'productName': widget.name,
          'user': _user!.uid,
        })
        .then((value) => Fluttertoast.showToast(
              msg: "Product added to favourites",
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

  Future<void> addToCart() {
    CollectionReference _cart = FirebaseFirestore.instance.collection('cart');
    User? _user = FirebaseAuth.instance.currentUser;
    return _cart
        .add({
          'product': widget.name,
          'size': _sizeSelected,
          'color': _colorSelected,
          'image': widget.image[_imageSelected],
          'price': widget.price,
          'user': _user!.uid,
          'quantity': 1,
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
                  child: PhotoView(
                    imageProvider: NetworkImage("$colorTshirt"),
                    /*AssetImage("assets/images/originalWhite.png")*/
                    backgroundDecoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    minScale: 0.07,
                    maxScale: 0.35,
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
            ],
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                ),
                Row(children: [
                  new Text("Color:"),
                ]),
                Row(children: [
                  new IconButton(
                    icon:
                        const Icon(Icons.circle_outlined, color: Colors.black),
                    color: Colors.white,
                    onPressed: () => changeToWhite(),
                  ),
                  new IconButton(
                    icon: const Icon(Icons.circle, color: Colors.black),
                    color: Colors.black,
                    onPressed: () => changeToBlack(),
                  ),
                  new IconButton(
                    icon: const Icon(Icons.circle, color: Colors.red),
                    color: Colors.black,
                    onPressed: () => changeToRed(),
                  ),
                  new IconButton(
                    icon: const Icon(Icons.circle, color: Colors.blue),
                    color: Colors.black,
                    onPressed: () => changeToBlue(),
                  ),
                ]),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 40,
              color: Colors.white,
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
