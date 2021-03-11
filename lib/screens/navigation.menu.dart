import 'package:flower_user_ui/models/account.dart';
import 'package:flower_user_ui/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.menu/main.menu.content.dart';
import 'orders.observe/orders.observe.main.dart';
import 'package:flower_user_ui/screens/account/account.main.dart';
import 'package:connectivity/connectivity.dart';

class NavigationMenu extends StatefulWidget {
  static User user;
  static Account account;

  NavigationMenu() {
    user = User();
    user.id = 1;
    user.name = "Рината";
    user.surname = "Завойская";
    user.phone = "8(927)880-67-82";
    user.accountId = 3;

    account = Account();
    account.login = "mia_2105";
    account.passwordHash = "qwerty";
    account.role = "user";
  }

  @override
  NavigationMenuState createState() => NavigationMenuState();
}

class NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;
  List<Widget> _pages;

  NavigationMenuState() {
    _pages = <Widget>[
      MainMenuContent(),
      OrdersObserveMain(),
      AccountObserve(),
    ];

    checkConnection();
  }

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      await _showConnectionError();
    }
  }

  Future<void> _showConnectionError() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Text('Нет соединения с интернетом', style: Theme.of(context).textTheme.body1,),
          ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text(
                  "Закрыть",
                  style: Theme.of(context).textTheme.body1.copyWith(
                    color: Color.fromRGBO(130, 147, 153, 1),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: _selectedIndex == 0
                ? AssetImage("resources/images/background.menu.jpg")
                : AssetImage(""),
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
                    backgroundColor: Color.fromRGBO(110, 53, 76, 1),
                    child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.home,
                          color: Color.fromRGBO(110, 53, 76, 1),
                          size: 40,
                        ))),
                icon: CircleAvatar(
                    radius: 25,
                    backgroundColor: Color.fromRGBO(110, 53, 76, 1),
                    child: Icon(
                      Icons.home,
                      color: Colors.white,
                    )),
                label: "",
              ),
              BottomNavigationBarItem(
                activeIcon: CircleAvatar(
                    radius: 31,
                    backgroundColor: Color.fromRGBO(110, 53, 76, 1),
                    child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.shopping_cart,
                          color: Color.fromRGBO(110, 53, 76, 1),
                          size: 40,
                        ))),
                icon: CircleAvatar(
                    radius: 25,
                    backgroundColor: Color.fromRGBO(110, 53, 76, 1),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    )),
                label: "",
              ),
              BottomNavigationBarItem(
                activeIcon: CircleAvatar(
                    radius: 31,
                    backgroundColor: Color.fromRGBO(110, 53, 76, 1),
                    child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Color.fromRGBO(110, 53, 76, 1),
                          size: 40,
                        ))),
                icon: CircleAvatar(
                    radius: 25,
                    backgroundColor: Color.fromRGBO(110, 53, 76, 1),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    )),
                label: "",
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ));
  }
}
