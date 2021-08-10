import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/internal/utils/nullContainer.dart';
import 'package:flower_user_ui/internal/utils/profile.manipulation.dart';
import 'package:flower_user_ui/internal/utils/web.api.services.dart';
import 'package:flower_user_ui/presentation/screens/registration.widgets/registration.main.menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../navigation.menu.dart';

class AuthorizationMainMenu extends StatefulWidget {
  AuthorizationMainMenuState createState() => AuthorizationMainMenuState();
}

class AuthorizationMainMenuState extends State<AuthorizationMainMenu> {
  Account _account = Account();
  bool isWrong = false;

  AuthorizationMainMenuState() {
    getAccounts();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  getAccounts() async {
    await WebApiServices.fetchAccounts().then((response) {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "Вход",
            style: Theme.of(context).textTheme.headline6,
          ),
          getLogin(context),
          getPassword(context),
          getWrongAccountError(context),
          signIn(context),
          signUp(context),
          Spacer(),
        ],
      ),
    );
  }

  Container signUp(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrationMainMenu()),
          );
        },
        child: new Text(
          "Зарегистрироваться",
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  Container signIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 80),
      child: TextButton(
        onPressed: () async {
          User accUser = await ProfileManipulation.getUser(_account);

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
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 90),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          child: new Text(
            "ВОЙТИ",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Color.fromRGBO(110, 53, 76, 1),
                ),
          ),
        ),
      ),
    );
  }

  Padding getWrongAccountError(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
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
      padding: EdgeInsets.only(right: 40, left: 40, top: 30),
      child: TextFormField(
        obscureText: true,
        onChanged: (password) {
          setState(() {
            this._account.passwordHash = password;
          });
        },
        cursorColor: Colors.white,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: InputDecoration(
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
      padding: EdgeInsets.only(right: 40, left: 40, top: 40),
      child: TextFormField(
        onChanged: (login) {
          setState(() {
            this._account.login = login;
          });
        },
        cursorColor: Colors.white,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: InputDecoration(
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
            decoration: BoxDecoration(
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
            decoration: BoxDecoration(
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
            decoration: BoxDecoration(
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
            decoration: BoxDecoration(
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
            decoration: BoxDecoration(
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
            decoration: BoxDecoration(
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
      decoration: BoxDecoration(
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
