import 'package:flower_user_ui/models/account.info.dart';
import 'package:flower_user_ui/models/user.dart';
import 'package:flower_user_ui/models/store.dart';
import 'package:flower_user_ui/models/web.api.services.dart';
import 'package:flower_user_ui/screens/registration.widgets/registration.main.menu.dart';
import 'package:flower_user_ui/models/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypt/crypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigation.menu.dart';

class AuthorizationMainMenu extends StatefulWidget {
  AuthorizationMainMenuState createState() => AuthorizationMainMenuState();
}

class AuthorizationMainMenuState extends State<AuthorizationMainMenu> {
  Account _account = Account();
  bool isWrong = false;
  List<Account> _accounts = [];

  AuthorizationMainMenuState() {
    getAccounts();
  }

  getAccounts() async {
    await WebApiServices.fetchAccount().then((response) {
      var accountsData = accountFromJson(response.data);
      setState(() {
        _accounts = accountsData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        overflow: Overflow.clip,
        children: [
          Container(
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
          ),
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
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  "Вход",
                  style: Theme.of(context).textTheme.title,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40, left: 40, top: 40),
                  child: TextFormField(
                      onChanged: (login) {
                        setState(() {
                          this._account.login = login;
                        });
                      },
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.body2,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color:Colors.white,
                        ),
                        labelText: "Логин",
                        focusColor: Colors.white,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40, left: 40, top: 30),
                  child: TextFormField(
                      onChanged: (password) {
                        setState(() {
                          this._account.passwordHash = password;
                        });
                      },
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.body2,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color:Colors.white,
                        ),
                        labelText: "Пароль",
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: isWrong
                      ? Text(
                          "Пароль или логин введен неправильно",
                          style: Theme.of(context).textTheme.body2,
                        )
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 80),
                  child: FlatButton(
                      onPressed: () async {
                        User accUser = await getUser(_account);

                        if (accUser == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Пользователь не найден",
                                style: Theme.of(context).textTheme.body2,
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

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationMenu()),
                        );
                      },
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 90),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: new Text(
                          "ВОЙТИ",
                          style: Theme.of(context).textTheme.body2.copyWith(
                                color: Color.fromRGBO(110, 53, 76, 1),
                              ),
                        ),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: FlatButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationMainMenu()),
                      );
                    },
                    padding: EdgeInsets.zero,
                    child: new Text(
                      "Зарегистрироваться",
                      style: Theme.of(context).textTheme.body2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                Spacer(),
              ],
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
      ),
    );
  }

  Future<Account> getAccount(Account account) async {
    Account accountBD;

    await WebApiServices.fetchAccount().then((response) {
      var accountData = accountFromJson(response.data);
      accountBD = accountData.firstWhere((element) =>
        element.login == account.login && element.role == "user", orElse: ()=>null);
    });
    if (accountBD == null) return null;

    final crypto = Crypt.sha256(account.passwordHash, salt: accountBD.salt);

    if (accountBD.passwordHash == crypto.hash) {
      return accountBD;
    } else
      return null;
  }

  Future<User> getUser(Account account) async {
    Account accountBD = await getAccount(account);

    if (accountBD == null) return null;

    User user;
    await WebApiServices.fetchUser().then((response) {
      var userData = userFromJson(response.data);
      user = userData
          .firstWhere((element) => element.accountId == accountBD.id);
    });

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    prefs.setInt("AccountId", accountBD.id);
    prefs.setInt("UserId", user.id);

    return user;
  }
}
