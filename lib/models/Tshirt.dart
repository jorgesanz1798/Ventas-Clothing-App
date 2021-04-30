import 'package:flutter/material.dart';

class Tshirt {
  final String image, title, description;
  final int price, size, id;
  final Color color;

  //Constructor
  Tshirt(this.image, this.title, this.description, this.price, this.size,
      this.id, this.color);
}

List<Tshirt> tshirts = [];
