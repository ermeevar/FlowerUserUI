import 'package:flower_user_ui/models/account.dart';
import 'package:flower_user_ui/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainMenuContent extends StatelessWidget {
  User user;
  Account account;

  MainMenuContent(){
    user = User();
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bulb.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: null,
    );
  }

  Widget _accountInfo(context){
    return Row(
      children: [
        Text(account.login, style: Theme.of(context).textTheme.body1),
        CircleAvatar(
          radius: 10,
          backgroundImage: NetworkImage("https://simple-fauna.ru/wp-content/uploads/2018/10/kvokka.jpg"),
          backgroundColor: Colors.transparent)
      ],
    );
  }
}
