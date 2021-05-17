import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/categories_screen.dart';

Widget categories = new ListView(
  scrollDirection: Axis.horizontal,
  children: [
    Category(
      imageLocation:
          'https://firebasestorage.googleapis.com/v0/b/ventas-clothing-app.appspot.com/o/icons%2Fcamiseta.png?alt=media&token=fa67af20-7b44-4087-8bf8-38c6fd923c1b',
      imageCaption: 'T-shirt',
    ),
    Category(
      imageLocation:
          'https://firebasestorage.googleapis.com/v0/b/ventas-clothing-app.appspot.com/o/icons%2Fchaqueta-con-bolsillos.png?alt=media&token=4f7d80cc-95df-45f4-b13f-c52a75ad9c87',
      imageCaption: 'Sweatshirt',
    ),
    Category(
      imageLocation:
          'https://firebasestorage.googleapis.com/v0/b/ventas-clothing-app.appspot.com/o/icons%2Fpantalon.png?alt=media&token=3ed8bef6-e92e-49b5-9ef8-bf85f7008bda',
      imageCaption: 'Troussers',
    ),
    Category(
      imageLocation:
          'https://firebasestorage.googleapis.com/v0/b/ventas-clothing-app.appspot.com/o/icons%2Fpantalones-cortos.png?alt=media&token=c1e8856d-5242-4a26-aa7f-045e1e5d2b28',
      imageCaption: 'Shorts',
    ),
    Category(
      imageLocation:
          'https://firebasestorage.googleapis.com/v0/b/ventas-clothing-app.appspot.com/o/icons%2Fsueter-con-cremallera.png?alt=media&token=df50ff49-76e0-4bb1-aa9b-bc16cdf5e800',
      imageCaption: 'Jacket',
    ),
    Category(
      imageLocation:
          'https://firebasestorage.googleapis.com/v0/b/ventas-clothing-app.appspot.com/o/icons%2Fgorra.png?alt=media&token=e18f2a47-6ce9-45c4-8061-9a07ee8837c6',
      imageCaption: 'Accesories',
    ),
  ],
);
