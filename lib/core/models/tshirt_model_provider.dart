import 'dart:ffi';
import 'package:flutter/foundation.dart';

class TshirtModelProvider with ChangeNotifier {
  String tshirtId;
  String tshirtName;
  String tshirtImage;
  String tshirtDescription;
  double tshirtOldPrice;
  double tshirtPrice;
  Array size;
  int stock;
  String color;
  bool isFavorite;

  TshirtModelProvider(
      {required this.tshirtId,
      required this.tshirtName,
      required this.tshirtImage,
      required this.tshirtOldPrice,
      required this.tshirtPrice,
      required this.tshirtDescription,
      required this.color,
      required this.size,
      required this.stock,
      this.isFavorite = false});

  void changeFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
