import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(top: 25, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/ventas-clothing-app.appspot.com/o/banner.png?alt=media&token=239ae3d4-f01a-4e71-b211-cc7251caf40b',
                    scale: 8.0,
                  ),
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 30,
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 25, bottom: 25),
                height: 200.0,
                child: new Carousel(
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
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'MOST SELLED PRODUCTS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
