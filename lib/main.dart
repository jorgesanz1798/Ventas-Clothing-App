import 'package:flutter/material.dart';
import 'package:ventasclothing/constants.dart';
import 'package:ventasclothing/screens/cart/cart_screen.dart';
import 'package:ventasclothing/screens/categories/categories_screen.dart';
import 'package:ventasclothing/screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ventas Clothing',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: mainColorText),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
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
        backgroundColor: Colors.blue,
        elevation: 1,
        toolbarHeight: 0,
      ),
      body: Center(
        child: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
            activeIcon: Icon(Icons.home, color: Colors.blue),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps, color: Colors.black),
            label: 'Categories',
            activeIcon: Icon(Icons.apps, color: Colors.blue),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            label: ('Cart'),
            activeIcon: Icon(Icons.shopping_cart, color: Colors.blue),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.black),
            label: 'Profile',
            activeIcon: Icon(Icons.account_circle, color: Colors.blue),
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
