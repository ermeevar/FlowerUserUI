import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.menu/main.menu.content.dart';

class NavigationMenu extends StatefulWidget{
  @override
  NavigationMenuState createState() => NavigationMenuState();
}

class NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;
  List<Widget> _pages = <Widget>[
    MainMenuContent(),
    Text(
      'Index 1: Business'
    ),
    Text(
      'Index 2: School'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: _selectedIndex==0?AssetImage("resources/images/background.menu.jpg"):AssetImage(""),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: _pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          showSelectedLabels: false,
          backgroundColor: Colors.transparent,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: CircleAvatar(
                  radius: 31,
                  backgroundColor: Color.fromRGBO(110,53, 76, 1),
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor:
                      Colors.white,
                      child: Icon(
                        Icons.home,
                        color: Color.fromRGBO(110, 53, 76, 1),
                        size: 40,
                      ))),
              icon: CircleAvatar(
                  radius: 25,
                  backgroundColor: Color.fromRGBO(110, 53, 76, 1),
                  child: Icon(Icons.home, color: Colors.white,)),
              label: "",
            ),
            BottomNavigationBarItem(
              activeIcon: CircleAvatar(
                  radius: 31,
                  backgroundColor: Color.fromRGBO(110,53, 76, 1),
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor:
                      Colors.white,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Color.fromRGBO(110, 53, 76, 1),
                        size: 40,
                      ))),
              icon: CircleAvatar(
                  radius: 25,
                  backgroundColor: Color.fromRGBO(110, 53, 76, 1),
                  child: Icon(Icons.shopping_cart, color: Colors.white,)),
              label: "",
            ),
            BottomNavigationBarItem(
              activeIcon: CircleAvatar(
                  radius: 31,
                  backgroundColor: Color.fromRGBO(110,53, 76, 1),
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor:
                      Colors.white,
                      child: Icon(
                        Icons.person,
                        color: Color.fromRGBO(110, 53, 76, 1),
                        size: 40,
                      ))),
              icon: CircleAvatar(
                  radius: 25,
                  backgroundColor: Color.fromRGBO(110, 53, 76, 1),
                  child: Icon(Icons.person, color: Colors.white,)),
              label: "",
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      )
    );
  }
}
