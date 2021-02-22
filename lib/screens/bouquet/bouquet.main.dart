import 'package:flower_user_ui/models/account.dart';
import 'package:flower_user_ui/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BouquetMainMenu extends StatefulWidget{
  User _user;

  BouquetMainMenu(this._user);

  @override
  BouquetMainMenuState createState() => BouquetMainMenuState(_user);
}

class BouquetMainMenuState extends State<BouquetMainMenu>{
  User _user;

  BouquetMainMenuState(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _header(context),
          ],
        ),
      ),
    );
  }

  Widget _header(context){
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 30),
              padding: EdgeInsets.zero,
              color: Color.fromRGBO(130, 147, 153, 1),
              onPressed: () {
                Navigator.pop(context);
              }
          ),
          Text("Создание букета",
              style: Theme.of(context).textTheme.subtitle)
        ],
      ),
    );
  }
}