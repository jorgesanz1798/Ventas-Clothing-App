import 'package:flutter/material.dart';
import 'package:ventasclothing/core/models/accesories.dart';
import 'package:ventasclothing/core/models/jacket.dart';
import 'package:ventasclothing/core/models/shorts.dart';
import 'package:ventasclothing/core/models/sweatshirts.dart';
import 'package:ventasclothing/core/models/troussers.dart';
import 'package:ventasclothing/core/models/tshirts.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen();
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var categorySelected;

  @override
  void initState() {
    super.initState();
    categorySelected = Tshirts();
  }

  void changeToTshirt() {
    setState(() {
      categorySelected = Tshirts();
    });
  }

  void changeToSweatshirt() {
    setState(() {
      categorySelected = Sweatshirts();
    });
  }

  void changeToTroussers() {
    setState(() {
      categorySelected = Troussers();
    });
  }

  void changeToShorts() {
    setState(() {
      categorySelected = Shorts();
    });
  }

  void changeToJacket() {
    setState(() {
      categorySelected = Jacket();
    });
  }

  void changeToAccesories() {
    setState(() {
      categorySelected = Accesories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 25, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                height: 80.0,
                child: new ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () => changeToTshirt(),
                        child: Container(
                          width: 100.0,
                          child: ListTile(
                            title: Image.asset(
                              'assets/icons/camiseta.png',
                              width: 100.0,
                              height: 60.0,
                              color: Colors.blue.withOpacity(1.0),
                            ),
                            subtitle: Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'T-shirt',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () => changeToSweatshirt(),
                        child: Container(
                          width: 100.0,
                          child: ListTile(
                            title: Image.asset(
                              'assets/icons/chaqueta-con-bolsillos.png',
                              width: 100.0,
                              height: 60.0,
                              color: Colors.blue.withOpacity(1.0),
                            ),
                            subtitle: Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Sweatshirt',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () => changeToTroussers(),
                        child: Container(
                          width: 100.0,
                          child: ListTile(
                            title: Image.asset(
                              'assets/icons/pantalones.png',
                              width: 100.0,
                              height: 60.0,
                              color: Colors.blue.withOpacity(1.0),
                            ),
                            subtitle: Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Troussers',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () => changeToShorts(),
                        child: Container(
                          width: 100.0,
                          child: ListTile(
                            title: Image.asset(
                              'assets/icons/pantalones-cortos.png',
                              width: 100.0,
                              height: 60.0,
                              color: Colors.blue.withOpacity(1.0),
                            ),
                            subtitle: Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Shorts',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () => changeToJacket(),
                        child: Container(
                          width: 100.0,
                          child: ListTile(
                            title: Image.asset(
                              'assets/icons/sueter-con-cremallera.png',
                              width: 100.0,
                              height: 60.0,
                              color: Colors.blue.withOpacity(1.0),
                            ),
                            subtitle: Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Jacket',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () => changeToAccesories(),
                        child: Container(
                          width: 100.0,
                          child: ListTile(
                            title: Image.asset(
                              'assets/icons/gorra.png',
                              width: 100.0,
                              height: 60.0,
                              color: Colors.blue.withOpacity(1.0),
                            ),
                            subtitle: Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Accesories',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: categorySelected,
        ),
      ],
    );
  }
}
