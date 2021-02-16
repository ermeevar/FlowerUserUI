import 'package:flower_user_ui/models/user.dart';
import 'package:flower_user_ui/models/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'orders.list.dart';

class OrdersObserveMain extends StatelessWidget {
  User _user;
  Account _account;
  OrdersObserveMain(this._user, this._account);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text("Заказы",
              style: Theme.of(context).textTheme.subtitle.copyWith(height: 2))),
        OrdersList(_user, _account)
      ],
    );
  }
}
