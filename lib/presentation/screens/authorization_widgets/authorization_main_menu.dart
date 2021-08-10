import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/data/services/services.dart';
import 'package:flower_user_ui/presentation/common_widgets/null_container.dart';
import 'package:flower_user_ui/presentation/screens/registration_widgets/registration_main_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../navigation_menu.dart';

class AuthorizationMainMenu extends StatefulWidget {
  @override
  AuthorizationMainMenuState createState() => AuthorizationMainMenuState();
}

class AuthorizationMainMenuState extends State<AuthorizationMainMenu> {
  final Account _account = Account();
  bool isWrong = false;

  AuthorizationMainMenuState() {
    getAccounts();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Future<void> getAccounts() async {
    await ApiService.fetchAccounts().then((response) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          drawBackgroundGradient(context),
          drawBackgroundCircles(),
          buildContent(context),
        ],
      ),
    );
  }

  //#region Content
  Center buildContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            "Вход",
            style: Theme.of(context).textTheme.headline6,
          ),
          getLogin(context),
          getPassword(context),
          getWrongAccountError(context),
          signIn(context),
          signUp(context),
          const Spacer(),
        ],
      ),
    );
  }

  Container signUp(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrationMainMenu()),
          );
        },
        child: Text(
          "Зарегистрироваться",
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  Container signIn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 80),
      child: TextButton(
        onPressed: () async {
          final User? accUser = await ProfileService.getUser(_account);

          if (accUser == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Пользователь не найден",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                action: SnackBarAction(
                  label: "Понятно",
                  onPressed: () {
                    // Code to execute.
                  },
                ),
              ),
            );
            return;
          }

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => NavigationMenu(),
              ),
              (Route<dynamic> route) => false);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 90),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          child: Text(
            "ВОЙТИ",
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: const Color.fromRGBO(110, 53, 76, 1),
                ),
          ),
        ),
      ),
    );
  }

  Padding getWrongAccountError(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: isWrong
          ? Text(
              "Пароль или логин введен неправильно",
              style: Theme.of(context).textTheme.bodyText2,
            )
          : nullContainer(),
    );
  }

  Padding getPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, top: 30),
      child: TextFormField(
        obscureText: true,
        onChanged: (password) {
          setState(() {
            _account.passwordHash = password;
          });
        },
        cursorColor: Colors.white,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: const InputDecoration(
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          labelText: "Пароль",
          focusColor: Colors.white,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Padding getLogin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, top: 40),
      child: TextFormField(
        onChanged: (login) {
          setState(() {
            _account.login = login;
          });
        },
        cursorColor: Colors.white,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: const InputDecoration(
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          labelText: "Логин",
          focusColor: Colors.white,
        ),
      ),
    );
  }
  //#endregion

  //#region Background
  Stack drawBackgroundCircles() {
    return Stack(
      children: [
        Positioned(
          top: 70,
          left: 10,
          child: Container(
            width: 15,
            height: 15,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white54,
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 35,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white54,
            ),
          ),
        ),
        Positioned(
          top: -20,
          right: -25,
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white54,
            ),
          ),
        ),
        Positioned(
          top: -30,
          right: 40,
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white54,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white54,
            ),
          ),
        ),
        Positioned(
          bottom: 60,
          right: 20,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white54,
            ),
          ),
        ),
      ],
    );
  }

  Container drawBackgroundGradient(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(110, 53, 76, 1),
            Color.fromRGBO(130, 147, 153, 1),
          ],
        ),
      ),
    );
  }
  //#endregion
}
