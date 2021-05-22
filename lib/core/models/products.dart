import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/product_details.dart';
import 'package:ventasclothing/view/widgets/card_products.dart';

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
                    child: CardProduct(document['imagen'][0], nameTshirt,
                        priceTshirt, oldPriceTshirt));
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
