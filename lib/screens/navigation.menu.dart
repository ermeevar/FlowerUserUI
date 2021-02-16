import 'package:flower_user_ui/models/account.dart';
import 'package:flower_user_ui/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.menu/main.menu.content.dart';
import 'orders.observe/orders.observe.main.dart';

class NavigationMenu extends StatefulWidget{
  User user;
  Account account;

  NavigationMenu(){
    user = User();
    user.id = 1;
    user.name = "Рината";
    user.surname = "Завойская";
    user.phone = "8(927)880-67-82";
    user.accountId = 3;

    account = Account();
    account.login = "mia_2105";
    account.password = "qwerty";
    account.role = "user";
  }

  @override
  NavigationMenuState createState() => NavigationMenuState(user, account);
}

class NavigationMenuState extends State<NavigationMenu> {
  User _user;
  Account _account;
  int _selectedIndex = 0;
  List<Widget> _pages;

  NavigationMenuState(this._user, this._account){
    _pages = <Widget>[
      MainMenuContent(_user, _account),
      OrdersObserveMain(_user, _account),
      Text(
          'Index 2: School'
      ),
    ];
  }

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
