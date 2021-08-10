import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/domain/services/api_service.dart';
import 'package:flower_user_ui/domain/services/services.dart';
import 'package:flower_user_ui/presentation/common_widgets/circle_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'account/account_main.dart';
import 'main.menu/main_menu_content.dart';
import 'orders_observe/orders_observe_main.dart';

class NavigationMenu extends StatefulWidget {
  @override
  NavigationMenuState createState() => NavigationMenuState();
}

class NavigationMenuState extends State<NavigationMenu>
    with TickerProviderStateMixin {
  static final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _selectedIndex = 0;
  late List<Widget> _pages;

  NavigationMenuState() {
    _pages = <Widget>[
      const MainMenuContent(),
      const OrdersObserveMain(),
      AccountObserve(),
    ];
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Future<void> loadProfile() async {
    final SharedPreferences prefs = await _prefs;

    await ApiService.fetchAccounts().then((response) {
      final accountData = accountFromJson(response.data as String);
      ProfileService.account = accountData
          .firstWhere((element) => element.id == prefs.getInt('AccountId'));
    });

    await ApiService.fetchUsers().then((response) {
      final userData = userFromJson(response.data as String);
      ProfileService.user = userData
          .firstWhere((element) => element.id == prefs.getInt('UserId'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadProfile(),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return vinousCircleProgressBarScaffold(this);
            case ConnectionState.done:
              return buildNavigationMenu();
            case ConnectionState.none:
              return const Text("No connection");
            case ConnectionState.active:
              return vinousCircleProgressBarScaffold(this);
          }
        });
  }

  //#region NavigationMenu
  Container buildNavigationMenu() {
    return Container(
      decoration: drawBackground(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: buildContent(),
        bottomNavigationBar: buildNavigationBar(),
      ),
    );
  }

  BottomNavigationBar buildNavigationBar() {
    return BottomNavigationBar(
      elevation: 0,
      showSelectedLabels: false,
      backgroundColor: Colors.transparent,
      items: <BottomNavigationBarItem>[
        getHomeItem(),
        getOrderItem(),
        getAccountItem(),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  BottomNavigationBarItem getAccountItem() {
    return const BottomNavigationBarItem(
      backgroundColor: Colors.transparent,
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
          ),
        ),
      ),
      icon: CircleAvatar(
        radius: 25,
        backgroundColor: Color.fromRGBO(110, 53, 76, 1),
        child: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      label: "",
    );
  }

  BottomNavigationBarItem getOrderItem() {
    return const BottomNavigationBarItem(
      backgroundColor: Colors.transparent,
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
          ),
        ),
      ),
      icon: CircleAvatar(
        radius: 25,
        backgroundColor: Color.fromRGBO(110, 53, 76, 1),
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
      label: "",
    );
  }

  BottomNavigationBarItem getHomeItem() {
    return const BottomNavigationBarItem(
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
          ),
        ),
      ),
      icon: CircleAvatar(
          radius: 25,
          backgroundColor: Color.fromRGBO(110, 53, 76, 1),
          child: Icon(
            Icons.home,
            color: Colors.white,
          )),
      label: "",
    );
  }

  Container buildContent() {
    return Container(
      child: _pages.elementAt(_selectedIndex),
    );
  }
  //#endregion

  BoxDecoration drawBackground() {
    return BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        image: _selectedIndex == 0
            ? const AssetImage("resources/images/background.menu.jpg")
            : const AssetImage(""),
        fit: BoxFit.cover,
      ),
    );
  }
}
