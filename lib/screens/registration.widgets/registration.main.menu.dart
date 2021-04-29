import 'package:crypt/crypt.dart';
import 'package:flower_user_ui/models/account.dart';
import 'package:flower_user_ui/models/web.api.services.dart';
import 'package:flower_user_ui/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationMainMenu extends StatefulWidget {
  RegistrationMainMenuState createState() => RegistrationMainMenuState();
}

class RegistrationMainMenuState extends State<RegistrationMainMenu> {
  User _user = User();
  Account _account = Account();
  List<Account> accounts = [];

  RegistrationMainMenuState() {
    getAccounts();
  }

   getAccounts() async {
    await WebApiServices.fetchAccount().then((response) {
      var accountData = accountFromJson(response.data);
      setState(() {
        accounts = accountData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Positioned(
            top: 70,
            left: 30,
            child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  "Регистрация",
                  style: Theme.of(context).textTheme.title,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40, left: 40, top: 40),
                  child: TextFormField(
                      onChanged: (surname) {
                        setState(() {
                          this._user.surname = surname;
                        });
                      },
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.body2,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color:Colors.white,
                        ),
                        labelText: "Фамилия",
                        focusColor: Colors.white,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40, left: 40, top: 20),
                  child: TextFormField(
                      onChanged: (name) {
                        setState(() {
                          this._user.name = name;
                        });
                      },
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.body2,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color:Colors.white,
                        ),
                        labelText: "Имя",
                        focusColor: Colors.white,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40, left: 40, top: 20),
                  child: TextFormField(
                      onChanged: (phone) {
                        setState(() {
                          this._user.phone = phone;
                        });
                      },
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.body2,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color:Colors.white,
                        ),
                        labelText: "Телефон",
                        focusColor: Colors.white,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40, left: 40, top: 20),
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
                  padding: EdgeInsets.only(right: 40, left: 40, top: 20),
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
                Container(
                  padding: EdgeInsets.only(top: 50),
                  child: FlatButton(
                      onPressed: () async{
                        await addUser();
                        Navigator.pop(context);
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
                          "СОХРАНИТЬ",
                          style: Theme.of(context).textTheme.body2.copyWith(
                                color: Color.fromRGBO(110, 53, 76, 1),
                              ),
                        ),
                      )),
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

   addUser() async {
    final crypto = Crypt.sha256(_account.passwordHash);
    _account.passwordHash = crypto.hash;
    _account.salt = crypto.salt;
    _account.role = "user";

    for (var item in accounts) {
      if (item.login == _account.login) return;
    }

    await WebApiServices.postAccount(_account);
    await getAccounts();

    _user.accountId = accounts.last.id;
    await WebApiServices.postUser(_user);
  }
}
