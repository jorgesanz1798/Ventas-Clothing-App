import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/cart_screen_wab.dart';
import 'package:ventasclothing/view/screens/sweatshirts_details.dart';
import 'package:ventasclothing/view/screens/tshirts_details.dart';
import 'package:ventasclothing/view/widgets/card_products.dart';

class MostSelledProductsScreen extends StatefulWidget {
  @override
  _MostSelledProductsScreenState createState() =>
      _MostSelledProductsScreenState();
}

class _MostSelledProductsScreenState extends State<MostSelledProductsScreen> {
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
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('camisetas')
              .orderBy('ventas', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 13),
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
      ),
    );
  }
}
