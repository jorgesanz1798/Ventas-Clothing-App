import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/most_selled_products_screen.dart';
import 'package:ventasclothing/view/screens/search_screen.dart';
import 'package:ventasclothing/view/widgets/main_carrousel.dart';
import 'package:ventasclothing/view/widgets/most_selled_products.dart';

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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => new SearchScreen(),
                        ),
                      );
                    },
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
          height: 195,
          child: MostSelledProducts(),
        ),
        InkWell(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Text('See more ...'),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new MostSelledProductsScreen()));
          },
        ),
      ],
    );
  }
}
