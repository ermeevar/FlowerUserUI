import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'account_bouquets.dart';
import 'account_information.dart';

class AccountObserve extends StatefulWidget {
  @override
  AccountObserveState createState() => AccountObserveState();
}

class AccountObserveState extends State<AccountObserve> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          getTitle(context),
          AccountInformation(),
          Container(
            padding: EdgeInsets.only(top: 20),
            height: 250,
            child: AccountBouquets(),
          ),
        ],
      ),
    );
  }

  Row getTitle(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Text(
            "Личный кабинет",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 2),
          ),
        ),
        Spacer()
      ],
    );
  }
}
