import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/sweatshirts_details.dart';
import 'package:ventasclothing/view/screens/tshirts_details.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    print(_user!.uid);
    // ignore: unnecessary_null_comparison
    if (_user != null) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('favourite')
            .where("user", isEqualTo: "${_user.uid}")
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
                      Icons.favorite,
                      color: Colors.black,
                      size: 100,
                    ),
                    Text(
                      'You have not save any favourite product',
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
            padding: EdgeInsets.only(top: 25),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: MediaQuery.of(context).size.width / (150),
              ),
              children: snapshot.data!.docs.map(
                (document) {
                  var nameProduct = document['productName'];
                  var imagenProduct = document['image'];
                  var priceProduct = document['price'];
                  var oldPriceProduct = document['old_price'];
                  var categoria = document['categoria'];
                  var ventas = document['ventas'];
                  var stock = document['stock'];
                  var description = document['description'];
                  var size = document['size'];
                  var color = document['color'];
                  return new FavouriteProduct(
                    nameProduct,
                    imagenProduct,
                    oldPriceProduct,
                    priceProduct,
                    categoria,
                    ventas,
                    stock,
                    description,
                    size,
                    color,
                  );
                },
              ).toList(),
            ),
          );
        },
      );
    }
    return Text('No has iniciado sesion');
  }
}

// ignore: must_be_immutable
class FavouriteProduct extends StatelessWidget {
  final String favouriteProductName;
  final int favouriteProductOldPrice;
  final double favouriteProductPrice;
  List favouriteProductImage = [];
  List favouriteColor = [];
  List favouriteSize = [];
  List favouriteStock = [];
  final String favouriteDescription;
  final String favouriteCategoria;
  final int favouriteVentas;

  FavouriteProduct(
    this.favouriteProductName,
    this.favouriteProductImage,
    this.favouriteProductOldPrice,
    this.favouriteProductPrice,
    this.favouriteCategoria,
    this.favouriteVentas,
    this.favouriteStock,
    this.favouriteDescription,
    this.favouriteSize,
    this.favouriteColor,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (context) {
              if (favouriteCategoria == "camisetas") {
                return new TshirtDetails(
                    favouriteProductName,
                    favouriteProductOldPrice,
                    favouriteProductPrice,
                    favouriteProductImage,
                    favouriteStock,
                    favouriteDescription,
                    favouriteSize,
                    favouriteColor,
                    favouriteCategoria,
                    favouriteVentas);
              }
              if (favouriteCategoria == "sudaderas") {
                return new SweatshirtsDetails(
                    favouriteProductName,
                    favouriteProductOldPrice,
                    favouriteProductPrice,
                    favouriteProductImage,
                    favouriteStock,
                    favouriteDescription,
                    favouriteSize,
                    favouriteColor,
                    favouriteCategoria,
                    favouriteVentas);
              }
              return Container(
                child: Text('Error'),
              );
            },
          ),
        ),
        child: Container(
          color: Colors.grey[100],
          height: 10,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  width: 80,
                  constraints: BoxConstraints(minWidth: 80, maxWidth: 80),
                  child: new Image.network(
                    favouriteProductImage[0],
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.only(right: 25)),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 180,
                  constraints: BoxConstraints(minWidth: 180, maxWidth: 180),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: const EdgeInsets.only(top: 25)),
                      Text(
                        favouriteProductName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Text("$favouriteProductPrice"),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "$favouriteProductOldPrice",
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
