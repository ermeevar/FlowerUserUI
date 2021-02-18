import 'package:flower_user_ui/models/account.dart';
import 'package:flower_user_ui/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainMenuContent extends StatelessWidget {
  User _user;
  Account _account;

  MainMenuContent(this._user, this._account);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _accountInfo(context),
            _bouquetCards(context),
            Container(
              height: 10,
            )
          ],
        ));
  }

  Widget _accountInfo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: Row(children: [
              Text(_account.login, style: Theme.of(context).textTheme.body1),
              Padding(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        "https://simple-fauna.ru/wp-content/uploads/2018/10/kvokka.jpg"),
                    backgroundColor: Colors.transparent),
              )
            ]))
      ],
    );
  }

  Widget _bouquetCards(context) {
    return Container(
      padding: EdgeInsets.zero,
      height: 335,
      //color: Colors.amber,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: EdgeInsets.only(left: 30),
            height: 300,
            width: 230,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white54,
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.add, color: Colors.white, size: 60),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Новый букет",
                        style: Theme.of(context).textTheme.subtitle),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: OutlineButton(
                      onPressed: () {

                      },
                      child: Text('Создать', style: Theme.of(context).textTheme.body2),
                      borderSide: BorderSide(
                          color:Colors.white
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30),
            height: 300,
            width: 230,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white54,
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Padding(
                  //   padding:EdgeInsets.all(20),
                  //   child: CircleAvatar(
                  //     backgroundImage: AssetImage("resources/images/bouquet.add.jpg"),
                  //     maxRadius: 100,
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.image_outlined, color: Colors.white, size: 60),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Букет по шаблону",
                        style: Theme.of(context).textTheme.subtitle),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: OutlineButton(
                      onPressed: () {

                      },
                      child: Text('Выбрать', style: Theme.of(context).textTheme.body2),
                      borderSide: BorderSide(
                          color:Colors.white
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30),
            height: 300,
            width: 230,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white54,
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.add_shopping_cart, color: Colors.white, size: 60),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Случайный букет",
                        style: Theme.of(context).textTheme.subtitle),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: OutlineButton(
                      onPressed: () {

                      },
                      child: Text('Заказать', style: Theme.of(context).textTheme.body2),
                      borderSide: BorderSide(
                          color:Colors.white
                      ),
                    ),
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
