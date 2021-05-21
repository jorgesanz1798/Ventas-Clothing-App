import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('camisetas').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
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
                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (context) => new ProductDetails(nameTshirt,
                          oldPriceTshirt, priceTshirt, imagenTshirt),
                    ),
                  ),
                  child: Card(
                    elevation: 1.0,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          new Image.network(
                            "${document['imagen'][0]}",
                            fit: BoxFit.fitHeight,
                            height: 100,
                          ),
                          Container(
                            color: Colors.white70,
                            child: ListTile(
                              title: Text(
                                "$nameTshirt",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Row(children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    "${document['price']}" + "€",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${document['old_price']}" + "€",
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
