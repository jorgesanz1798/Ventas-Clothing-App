import 'package:flutter/material.dart';

class Tshirt extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}

class TshirtState extends State<Tshirt> {
  var tshirtList = [
    {
      "name": "Ventas original Tshirt",
      "image": "assets/images/originalWhite.png",
      "old_price": 13,
      "price": 10.99,
    },
    {
      "name": "Ventas Vc Tshirt",
      "image": "assets/images/vcWhite.png",
      "old_price": 13,
      "price": 10.99,
    },
    {
      "name": "Ventas Roman Tshirt",
      "image": "assets/images/romanWhite.png",
      "old_price": 13,
      "price": 10.99,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: tshirtList.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return SingleTshirt(
          tshirtName: tshirtList[index]['name'],
          tshirtImage: tshirtList[index]['image'],
          tshirtOldPrice: tshirtList[index]['old_price'],
          tshirtPrice: tshirtList[index]['price'],
        );
      },
    );
  }
}

class SingleTshirt extends StatelessWidget {
  final tshirtName;
  final tshirtImage;
  final tshirtOldPrice;
  final tshirtPrice;

  SingleTshirt(
      {this.tshirtName,
      this.tshirtImage,
      this.tshirtOldPrice,
      this.tshirtPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('test'),
    );
  }
}
