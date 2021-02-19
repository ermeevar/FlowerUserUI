import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flower_user_ui/models/user.dart';
import 'package:flower_user_ui/screens/account/account.information.dart';
import 'package:flower_user_ui/screens/account/account.bouquets.dart';

class AccountObserve extends StatefulWidget{
  User _user;

  AccountObserve(this._user);

  @override
  AccountObserveState createState() => AccountObserveState(_user);
}

class AccountObserveState extends State<AccountObserve>{
  User _user;

  AccountObserveState(this._user);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 20, left:20, right: 20),
                  child: Text("Личный кабинет",
                      style: Theme.of(context).textTheme.subtitle.copyWith(height: 2))),
              Spacer()
            ],
          ),
          AccountInformation(_user),
          AccountBouquets(_user)
        ],
      ),
    );
  }
}