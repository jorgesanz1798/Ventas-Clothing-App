import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/tshirts_details.dart';
import 'package:ventasclothing/view/widgets/card_products.dart';

class MostSelledProducts extends StatefulWidget {
  @override
  _MostSelledProductsState createState() => _MostSelledProductsState();
}

class _MostSelledProductsState extends State<MostSelledProducts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('camisetas')
          .orderBy('ventas', descending: true)
          .limit(4)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                return InkWell(
                    onTap: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (context) => new TshirtDetails(
                                nameTshirt,
                                oldPriceTshirt,
                                priceTshirt,
                                imagenTshirt,
                                stock,
                                description,
                                size,
                                color),
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
