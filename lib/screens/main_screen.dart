import 'package:flutter/material.dart';
import 'package:recipe_book/screens/category_screen.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _pageList = <Widget>[
    CategoryGridScreen(),
    Text(
      'TODO: Shopping List',
      style: optionStyle,
    ),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent[50],
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'My CookBook',
          style: TextStyle(fontSize: 40, letterSpacing: 2, wordSpacing: 5),
        ),
      ),
      body: Center(
        child: _pageList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 40.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shopping List',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrangeAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
