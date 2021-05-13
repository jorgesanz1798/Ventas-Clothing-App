// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

Widget mainCarrousel = new Carousel(
  boxFit: BoxFit.cover,
  images: [
    Image.network(
        'https://firebasestorage.googleapis.com/v0/b/ventas-clothing-app.appspot.com/o/WhatsApp%20Image%202021-04-21%20at%2023.17.48.jpeg?alt=media&token=dbbd0126-f94f-47e0-aae1-c1c6cb5548b8'),
    Image.network(
        'https://firebasestorage.googleapis.com/v0/b/ventas-clothing-app.appspot.com/o/carousel2.jpg?alt=media&token=01a7e36f-7e6d-4e03-ad4a-ab70b812f45f'),
    Image.network(
        'https://firebasestorage.googleapis.com/v0/b/ventas-clothing-app.appspot.com/o/WhatsApp%20Image%202021-04-21%20at%2023.17.48.jpeg?alt=media&token=dbbd0126-f94f-47e0-aae1-c1c6cb5548b8'),
  ],
  dotSize: 4.0,
  dotSpacing: 15.0,
  dotColor: Colors.white,
  indicatorBgPadding: 5.0,
  dotBgColor: Colors.transparent,
  borderRadius: true,
  autoplay: true,
  animationCurve: Curves.fastOutSlowIn,
  animationDuration: Duration(milliseconds: 3500),
  autoplayDuration: Duration(milliseconds: 10000),
  dotIncreasedColor: Colors.white,
);
