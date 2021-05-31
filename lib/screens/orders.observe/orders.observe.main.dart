import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'orders.list.dart';

class OrdersObserveMain extends StatelessWidget {
  OrdersObserveMain();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text("Заказы",
                  style:
                  Theme.of(context).textTheme.subtitle.copyWith(height: 2))),
          Expanded(
            child: OrdersList(),
          )
        ],
      ),
    );
  }
}
