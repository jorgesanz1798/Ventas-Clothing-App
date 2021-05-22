import 'package:flutter/material.dart';
import 'package:ventasclothing/view/widgets/main_carrousel.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 25, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Image.asset(
                    'assets/images/banner.png',
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
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 25, bottom: 12, left: 20, right: 20),
          height: 200.0,
          child: mainCarrousel,
        ),
        Container(
          margin: EdgeInsets.only(top: 12, left: 20, right: 20),
          height: 40.0,
          child: Text(
            'MOST SELLED PRODUCTS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              height: 1.5,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Text('Productos mas vendidos'),
        ),
      ],
    );
  }
}
