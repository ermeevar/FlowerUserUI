import 'package:flower_user_ui/screens/bouquet/bouquet.main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../navigation.menu.dart';

class OrderMainMenu extends StatefulWidget {
  @override
  OrderMainMenuState createState() => OrderMainMenuState();
}

class OrderMainMenuState extends State<OrderMainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _header(context),
          _nameAndCostInfo(context),
          _orderInfo(context),
        ],
      ),
    );
  }

  Widget _header(context) {
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
              }),
          Text("Оформление заказа", style: Theme.of(context).textTheme.subtitle)
        ],
      ),
    );
  }

  Widget _nameAndCostInfo(context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: Row(
        children: [
          Container(
            width: 250,
            child: Text(
                BouquetMainMenuState.newBouquet.name != null
                    ? BouquetMainMenuState.newBouquet.name
                    : "Название букета",
                overflow: TextOverflow.clip,
                softWrap: true,
                style: Theme.of(context).textTheme.body1),
          ),
          Spacer(),
          Text(
              BouquetMainMenuState.newBouquet.cost != null
                  ? BouquetMainMenuState.newBouquet.cost.toString() + " ₽"
                  : "Цена",
              style: Theme.of(context).textTheme.body1.copyWith(
                    color: Color.fromRGBO(110, 53, 76, 1),
                    fontSize: 25,
                  )),
        ],
      ),
    );
  }
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //     });
  // }
  Widget _orderInfo(context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
                onChanged: (dateTime) {
                  setState(() {});
                },
                cursorColor: Color.fromRGBO(130, 147, 153, 1),
                style: Theme.of(context).textTheme.body1,
                decoration: InputDecoration(
                  labelText: "Дата выдачи",
                  focusColor: Color.fromRGBO(130, 147, 153, 1),
                )),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: TextFormField(
                onChanged: (surname) {
                  setState(() {});
                },
                cursorColor: Color.fromRGBO(130, 147, 153, 1),
                initialValue: NavigationMenu.user.surname != null
                    ? NavigationMenu.user.surname
                    : "",
                style: Theme.of(context).textTheme.body1,
                decoration: InputDecoration(
                  labelText: "Фамилия",
                  focusColor: Color.fromRGBO(130, 147, 153, 1),
                )),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
                onChanged: (name) {
                  setState(() {});
                },
                cursorColor: Color.fromRGBO(130, 147, 153, 1),
                initialValue: NavigationMenu.user.name != null
                    ? NavigationMenu.user.name
                    : "",
                style: Theme.of(context).textTheme.body1,
                decoration: InputDecoration(
                  labelText: "Имя",
                  focusColor: Color.fromRGBO(130, 147, 153, 1),
                )),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
                onChanged: (phone) {
                  setState(() {});
                },
                cursorColor: Color.fromRGBO(130, 147, 153, 1),
                initialValue: NavigationMenu.user.phone != null
                    ? NavigationMenu.user.phone
                    : "",
                style: Theme.of(context).textTheme.body1,
                decoration: InputDecoration(
                  labelText: "Телефон",
                  focusColor: Color.fromRGBO(130, 147, 153, 1),
                )),
          ),
          TextFormField(
              cursorColor: Color.fromRGBO(130, 147, 153, 1),
              style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(
                labelText: "Магазин",
                focusColor: Color.fromRGBO(130, 147, 153, 1),
              )),
        ],
      ),
    );
  }
}
