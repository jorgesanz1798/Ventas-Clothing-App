import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/cart_screen_wab.dart';
import 'package:ventasclothing/view/screens/sweatshirts_details.dart';
import 'package:ventasclothing/view/screens/tshirts_details.dart';
import 'package:ventasclothing/view/widgets/card_products.dart';

class SearchedProductsSreen extends StatefulWidget {
  final String? value;

  SearchedProductsSreen(this.value);

  @override
  _SearchedProductsSreenState createState() => _SearchedProductsSreenState();
}

class _SearchedProductsSreenState extends State<SearchedProductsSreen> {
  @override
  Widget build(BuildContext context) {
    String? searchKey = widget.value;
    print(searchKey);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 1,
        toolbarHeight: 80,
        actions: <Widget>[
          new IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreenWab()));
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: new StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('camisetas')
            .where('keywords', arrayContains: searchKey)
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
                      Icons.engineering_rounded,
                      color: Colors.black,
                      size: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'The product searched not macth wit any product',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.only(top: 25, left: 20, right: 20),
            child: GridView.count(
              crossAxisCount: 2,
              children: snapshot.data!.docs.map(
                (document) {
                  var nameTshirt = document['name'];
                  var priceTshirt = document['price'];
                  var oldPriceTshirt = document['old_price'];
                  var imagenTshirt = document['imagen'];
                  var stock = document['stock'];
                  var description = document['description'];
                  var size = document['size'];
                  var color = document['color'];
                  var categoria = document['categoria'];
                  var ventas = document['ventas'];
                  return InkWell(
                      onTap: () => Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (context) {
                                if (categoria == "camisetas") {
                                  return new TshirtDetails(
                                      nameTshirt,
                                      oldPriceTshirt,
                                      priceTshirt,
                                      imagenTshirt,
                                      stock,
                                      description,
                                      size,
                                      color,
                                      categoria,
                                      ventas);
                                }
                                if (categoria == "sudaderas") {
                                  return new SweatshirtsDetails(
                                      nameTshirt,
                                      oldPriceTshirt,
                                      priceTshirt,
                                      imagenTshirt,
                                      stock,
                                      description,
                                      size,
                                      color,
                                      categoria,
                                      ventas);
                                }
                                return Container(
                                  child: Text('Error'),
                                );
                              },
                            ),
                          ),
                      child: CardProduct(document['imagen'][0], nameTshirt,
                          priceTshirt, oldPriceTshirt));
                },
              ).toList(),
            ),
          );
        },
      ),
    );
  }
}
