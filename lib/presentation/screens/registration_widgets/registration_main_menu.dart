import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/domain/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationMainMenu extends StatefulWidget {
  @override
  RegistrationMainMenuState createState() => RegistrationMainMenuState();
}

class RegistrationMainMenuState extends State<RegistrationMainMenu> {
  final User _user = User();
  final Account _account = Account();
  late List<Account> _accounts;

  RegistrationMainMenuState() {
    getAccounts();
  }

  Future<void> getAccounts() async {
    await ApiService.fetchAccounts().then((response) {
      final accountData = accountFromJson(response.data as String);
      setState(() {
        _accounts = accountData.toList();
      });
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
          drawBackgroundCircles(context),
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
            "Регистрация",
            style: Theme.of(context).textTheme.headline6,
          ),
          getFirstName(context),
          getName(context),
          getPhone(context),
          getLogin(context),
          getPassword(context),
          getSaveButton(context),
          const Spacer(),
        ],
      ),
    );
  }

  Container getSaveButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: TextButton(
        onPressed: () async {
          if (await ProfileService.addUser(_account, _user) == true) {
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Произошла ошибка",
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
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 90),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Text(
            "СОХРАНИТЬ",
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: const Color.fromRGBO(110, 53, 76, 1),
                ),
          ),
        ),
      ),
    );
  }

  Padding getPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
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
      padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
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

  Padding getPhone(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
      child: TextFormField(
        onChanged: (phone) {
          setState(() {
            _user.phone = phone;
          });
        },
        cursorColor: Colors.white,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: const InputDecoration(
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          labelText: "Телефон",
          focusColor: Colors.white,
        ),
      ),
    );
  }

  Padding getName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
      child: TextFormField(
        onChanged: (name) {
          setState(() {
            _user.name = name;
          });
        },
        cursorColor: Colors.white,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: const InputDecoration(
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          labelText: "Имя",
          focusColor: Colors.white,
        ),
      ),
    );
  }

  Padding getFirstName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, top: 40),
      child: TextFormField(
        onChanged: (surname) {
          setState(() {
            _user.surname = surname;
          });
        },
        cursorColor: Colors.white,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: const InputDecoration(
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          labelText: "Фамилия",
          focusColor: Colors.white,
        ),
      ),
    );
  }
  //#endregion

  //#region Background
  Stack drawBackgroundCircles(BuildContext context) {
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
          top: 80,
          left: 30,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
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