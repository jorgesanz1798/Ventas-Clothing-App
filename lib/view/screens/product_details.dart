import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/cart_screen_wab.dart';

class ProductDetails extends StatefulWidget {
  final productDetailName;
  final productDetailPrice;
  final productDetailImage;
  final productDetailOldPrice;

  ProductDetails({
    this.productDetailName,
    this.productDetailImage,
    this.productDetailPrice,
    this.productDetailOldPrice,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                color: Colors.white,
                child: Image.asset(widget.productDetailImage),
              ),
            ),
          ),
          new Container(
            color: Colors.white,
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    "${widget.productDetailName}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80),
                  ),
                  new IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              subtitle: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: new Text(
                    "${widget.productDetailPrice}",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
                new Text(
                  "${widget.productDetailOldPrice}",
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.red,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ]),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
              ),
              Row(children: [
                new Text("Color:"),
              ]),
              Row(children: [
                new IconButton(
                  icon: const Icon(Icons.circle_outlined, color: Colors.black),
                  color: Colors.white,
                  onPressed: () {},
                ),
                new IconButton(
                  icon: const Icon(Icons.circle, color: Colors.black),
                  color: Colors.black,
                  onPressed: () {},
                ),
                new IconButton(
                  icon: const Icon(Icons.circle, color: Colors.red),
                  color: Colors.black,
                  onPressed: () {},
                ),
                new IconButton(
                  icon: const Icon(Icons.circle, color: Colors.blue),
                  color: Colors.black,
                  onPressed: () {},
                ),
              ]),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
              ),
              Row(children: [
                new Text("Size:"),
              ]),
              Row(
                children: [],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 260),
          ),
          Row(
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
                  onPressed: () {},
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
          )
        ],
      ),
    );
  }
}
