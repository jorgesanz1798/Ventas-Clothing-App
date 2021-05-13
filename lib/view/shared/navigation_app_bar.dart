import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/cart_screen_woab.dart';
import 'package:ventasclothing/view/screens/categories_screen.dart';
import 'package:ventasclothing/view/screens/home_screen.dart';
import 'package:ventasclothing/view/screens/profile_screen.dart';

class NavigationAppBar extends StatefulWidget {
  @override
  _NavigationAppBar createState() => _NavigationAppBar();
}

class _NavigationAppBar extends State<NavigationAppBar> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CategoriesScreen(),
    CartScreenWoab(),
    ProfileScreen(),
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
