import 'package:flower_user_ui/screens/bouquet/bouquet.main.dart';
import 'package:flower_user_ui/screens/order/order.main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../navigation.menu.dart';

class MainMenuContent extends StatelessWidget {
  MainMenuContent();

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
              Text(NavigationMenu.account.login,
                  style: Theme.of(context).textTheme.body1),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: NavigationMenu.user.picture == null
                        ? Icon(
                            Icons.image_outlined,
                            color: Colors.black38,
                            size: 20,
                          )
                        : NavigationMenu.user.picture,
                  ))
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BouquetMainMenu()));
                      },
                      child: Text('Создать',
                          style: Theme.of(context).textTheme.body2),
                      borderSide: BorderSide(color: Colors.white),
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
                    child: Icon(Icons.image_outlined,
                        color: Colors.white, size: 60),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Букет по шаблону",
                        style: Theme.of(context).textTheme.subtitle),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: OutlineButton(
                      onPressed: () {},
                      child: Text('Выбрать',
                          style: Theme.of(context).textTheme.body2),
                      borderSide: BorderSide(color: Colors.white),
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
                    child: Icon(Icons.add_shopping_cart,
                        color: Colors.white, size: 60),
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
                        _showCountOfProductDialog(context);
                      },
                      child: Text('Заказать',
                          style: Theme.of(context).textTheme.body2),
                      borderSide: BorderSide(color: Colors.white),
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

  Future<void> _showCountOfProductDialog(context) async {
    double _cost = 0;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Выбор ценовой категории",
            style: Theme.of(context).textTheme.subtitle,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                    onChanged: (cost) {
                      _cost = double.parse(cost);
                      print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
                      print(_cost);
                    },
                    cursorColor: Color.fromRGBO(130, 147, 153, 1),
                    style: Theme.of(context).textTheme.body1,
                    decoration: InputDecoration(
                      labelText: "Цена",
                      focusColor: Color.fromRGBO(130, 147, 153, 1),
                    ))
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text(
                  "Назад",
                  style: Theme.of(context).textTheme.body1.copyWith(
                        color: Color.fromRGBO(130, 147, 153, 1),
                      ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: FlatButton(
                onPressed: () async{
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OrderMainMenu.RandomBouquet(_cost)));
                  Navigator.pop(context);
                },
                child: new Text(
                  "Заказать",
                  style: Theme.of(context).textTheme.body1.copyWith(
                      color: Color.fromRGBO(130, 147, 153, 1),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
