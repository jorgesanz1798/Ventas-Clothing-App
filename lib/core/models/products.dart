import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productList = [
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
    },
    {
      "name": "Ventas Roman Tshirt 2",
      "image": "assets/images/romanWhite.png",
      "old_price": 13,
      "price": 10.99,
    },
    {
      "name": "Ventas Vc Tshirt 2",
      "image": "assets/images/vcWhite.png",
      "old_price": 13,
      "price": 10.99,
    },
    {
      "name": "Ventas Roman Tshirt 2",
      "image": "assets/images/romanWhite.png",
      "old_price": 13,
      "price": 10.99,
    },
    {
      "name": "Ventas Roman Tshirt 3",
      "image": "assets/images/romanWhite.png",
      "old_price": 13,
      "price": 10.99,
    },
    {
      "name": "Ventas Vc Tshirt 3",
      "image": "assets/images/vcWhite.png",
      "old_price": 13,
      "price": 10.99,
    },
    {
      "name": "Ventas Roman Tshirt 3",
      "image": "assets/images/romanWhite.png",
      "old_price": 13,
      "price": 10.99,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: (productList.length / 2) * 207,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: productList.length,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return SingleProduct(
              productName: productList[index]['name'],
              productImage: productList[index]['image'],
              productOldPrice: productList[index]['old_price'],
              productPrice: productList[index]['price'],
            );
          },
        ),
      ),
    ]);
  }
}

class SingleProduct extends StatelessWidget {
  final productName;
  final productImage;
  final productOldPrice;
  final productPrice;

  SingleProduct(
      {this.productName,
      this.productImage,
      this.productOldPrice,
      this.productPrice});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: productName,
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => new ProductDetails(
                  productDetailName: productName,
                  productDetailImage: productImage,
                  productDetailPrice: productPrice,
                  productDetailOldPrice: productOldPrice,
                ),
              ),
            ),
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  title: Text(
                    productName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        "$productPrice€",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      "$productOldPrice€",
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ]),
                ),
              ),
              child: Image.asset(
                productImage,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
