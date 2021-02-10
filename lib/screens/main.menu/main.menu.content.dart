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
              image: AssetImage("resources/images/background.menu.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _accountInfo(context),
              _bouquetCards(context),
              Container(height: 100,)
            ],
          )
      ));
  }
  Widget _accountInfo(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
            padding: EdgeInsets.only(top:30, left: 10, right: 10),
            child:Row(
                children: [
                  Text(account.login, style: Theme.of(context).textTheme.body1),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage("https://simple-fauna.ru/wp-content/uploads/2018/10/kvokka.jpg"),
                        backgroundColor: Colors.transparent),
                  )
                ])
        )
      ],
    );
  }
  Widget _bouquetCards(context){
    return Container(
      padding: EdgeInsets.zero,
      height: 335,
      //color: Colors.amber,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: EdgeInsets.only(left:30),
            height: 300,
            width: 230,
            child: Card(
              color: Colors.white54,
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage("resources/images/bouquet.add.jpg"),
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    height: 280),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Новый букет", style: Theme.of(context).textTheme.subtitle),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left:30),
            height: 300,
            width: 230,
            child: Card(
              color: Colors.white54,
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage("resources/images/template.add.jpg"),
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    height: 280),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Заказать по шаблону", style: Theme.of(context).textTheme.subtitle),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left:30, right: 70),
            height: 300,
            width: 230,
            child: Card(
              color: Colors.white54,
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage("resources/images/random.add.jpg"),
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    height: 280),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Случайный букет", style: Theme.of(context).textTheme.subtitle),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
