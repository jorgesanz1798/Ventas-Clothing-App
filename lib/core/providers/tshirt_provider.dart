import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ventasclothing/core/models/tshirt_model_provider.dart';
import 'package:flutter/material.dart';

class TshirtProvider with ChangeNotifier {
  List<TshirtModelProvider> _tshirts = [
    TshirtModelProvider(
      tshirtName: "Ventas original Tshirt",
      tshirtImage: "assets/images/originalWhite.png",
      tshirtOldPrice: 13.0,
      tshirtPrice: 10.99,
    ),
    TshirtModelProvider(
      tshirtId: 'p1',
      tshirtName: 'Red Shirt',
      tshirtDescription: 'A red shirt - it is pretty red!',
      tshirtPrice: "29.99",
      tshirtImage:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    TshirtModelProvider(
      tshirtId: 'p1',
      tshirtName: 'Red Shirt',
      tshirtDescription: 'A red shirt - it is pretty red!',
      tshirtPrice: "29.99",
      tshirtImage:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
  ];

  // getter
  //  List<Product> get products => [..._products];
  List<TshirtModelProvider> get products {
    return _tshirts;
  }

  List<TshirtModelProvider> get favoriteProducts {
    return _tshirts.where((product) => product.isFavorite).toList();
  }

  /*Future<void> addProduct(TshirtModelProvider product) {
    const String url =
        "https://flutter-shop-7ddca.firebaseio.com/products.json";
    return http
        .post(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'price': product.price,
              'isFavorite': product.isFavorite,
            }))
        .then((response) {
      _products.add(product);
      notifyListeners();
    }).catchError((err) {
      // Print Something ...
    });
  }*/

  void updateProduct(String id, TshirtModelProvider product) {
    final productIndex = _tshirts.indexWhere((prod) => prod.tshirtId == id);
    if (productIndex >= 0) {
      _tshirts[productIndex] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _tshirts.removeWhere((prod) => prod.tshirtId == id);
    notifyListeners();
  }

  TshirtModelProvider findProductById(String id) {
    return _tshirts.firstWhere((product) => product.tshirtId == id);
  }

  void addProductToFavourite(String id) {
    final product = _tshirts.firstWhere((product) => product.tshirtId == id);
    if (product.isFavorite == false) {
      product.isFavorite = true;
      notifyListeners();
    }
  }

  void removeProductFromFavourite(String id) {
    final product = _tshirts.firstWhere((product) => product.tshirtId == id);
    if (product.isFavorite) {
      product.isFavorite = false;
      notifyListeners();
    }
  }
}
