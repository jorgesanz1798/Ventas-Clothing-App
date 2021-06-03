import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/sweatshirts_details.dart';
import 'package:ventasclothing/view/widgets/card_products.dart';

class Sweatshirts extends StatefulWidget {
  @override
  _SweatshirtsState createState() => _SweatshirtsState();
}

class _SweatshirtsState extends State<Sweatshirts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('camisetas')
          .where("categoria", isEqualTo: "sudaderas")
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
                  Text(
                    'In maintance',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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
                      builder: (context) => new SweatshirtsDetails(
                        nameTshirt,
                        oldPriceTshirt,
                        priceTshirt,
                        imagenTshirt,
                        stock,
                        description,
                        size,
                        color,
                        categoria,
                        ventas,
                      ),
                    ),
                  ),
                  child: CardProduct(document['imagen'][0], nameTshirt,
                      priceTshirt, oldPriceTshirt),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
