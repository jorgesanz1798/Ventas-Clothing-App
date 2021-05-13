import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/categories_screen.dart';

Widget categories = new ListView(
  scrollDirection: Axis.horizontal,
  children: [
    Category(
      imageLocation: 'assets/icons/camiseta.png',
      imageCaption: 'T-shirt',
    ),
    Category(
      imageLocation: 'assets/icons/chaqueta-con-bolsillos.png',
      imageCaption: 'Sweatshirt',
    ),
    Category(
      imageLocation: 'assets/icons/pantalon.png',
      imageCaption: 'Troussers',
    ),
    Category(
      imageLocation: 'assets/icons/pantalones-cortos.png',
      imageCaption: 'Shorts',
    ),
    Category(
      imageLocation: 'assets/icons/sueter-con-cremallera.png',
      imageCaption: 'Jacket',
    ),
    Category(
      imageLocation: 'assets/icons/gorra.png',
      imageCaption: 'Accesories',
    ),
  ],
);
