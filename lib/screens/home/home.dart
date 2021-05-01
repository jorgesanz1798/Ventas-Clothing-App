import 'package:flutter/material.dart';
import 'package:ventasclothing/screens/cart/cart_screen.dart';
import 'package:ventasclothing/screens/categories/categories_screen.dart';
import 'package:ventasclothing/screens/home/home_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen23(),
    CategoriesScreen(),
    CartScreen(),
    Text('Profile')
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        toolbarHeight: 0,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps, color: Colors.black),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            label: ('Cart'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.black),
            label: 'Profile',
          )
        ],
        fixedColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        elevation: 0,
      ),
    );
  }
}
