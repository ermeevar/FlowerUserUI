import 'package:flower_user_ui/entities/template.dart';
import 'package:flower_user_ui/screens/navigation.menu.dart';
import 'package:flower_user_ui/states/calc.dart';
import 'package:flower_user_ui/states/profile.manipulation.dart';
import 'package:flower_user_ui/entities/order.dart';
import 'package:flower_user_ui/entities/shop.dart';
import 'package:flower_user_ui/states/web.api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TemplateBouquetOrder extends StatefulWidget {
  Template _template;

  TemplateBouquetOrder(this._template) {}

  @override
  TemplateBouquetOrderState createState() =>
      TemplateBouquetOrderState(_template);
}

class TemplateBouquetOrderState extends State<TemplateBouquetOrder> {
  Order order = new Order();
  bool isSelectedCard = false;
  Template _template;
  List<Shop> _shops = [];

  TemplateBouquetOrderState(this._template) {
    _setOrderInitialData();
  }

  //#region Set data
  _setOrderInitialData() async {
    await _getShops();

    await setState(() {
      order.userId = ProfileManipulation.user.id;
      order.finish = DateTime.now().add(Duration(days: 1));
      order.start = DateTime.now();
      order.shopId = _shops.first.id;
      order.templateId = _template.id;
      order.orderStatusId = 1;
      order.cost = _template.cost;
      order.isRandom = false;
    });
  }

  _getShops() async {
    await WebApiServices.fetchShops().then((response) {
      var shopsData = shopFromJson(response.data);
      setState(() {
        _shops = shopsData
            .where((element) => element.storeId == _template.storeId)
            .toList();
      });
    });
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _header(context),
          _nameAndCostInfo(context),
          _orderInfo(context),
          _orderButton(context),
        ],
      ),
    );
  }

  Widget _header(context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 25),
              padding: EdgeInsets.only(left: 20),
              color: Color.fromRGBO(130, 147, 153, 1),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => NavigationMenu(),
                    ),
                    (Route<dynamic> route) => false);
              },
            ),
          ),
          Text("Оформление заказа", style: Theme.of(context).textTheme.subtitle)
        ],
      ),
    );
  }

  Widget _nameAndCostInfo(context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              _template.name,
              overflow: TextOverflow.clip,
              softWrap: true,
              style: Theme.of(context).textTheme.body1.copyWith(
                    fontSize: 23,
                    color: Color.fromRGBO(130, 147, 153, 1),
                  ),
            ),
          ),
          Text(
            _template.cost != null
                ? Calc.roundDouble(_template.cost, 2).toString()
                : "",
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(fontWeight: FontWeight.bold, height: 2),
          ),
        ],
      ),
    );
  }

  //#region Order information
  Widget _orderInfo(context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: Column(
        children: [
          getDate(context),
          getSurname(context),
          getName(context),
          getPhone(context),
          getShop(context),
          getCardButton(context),
        ],
      ),
    );
  }

  Padding getCardButton(context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: order.card == null
          ? OutlineButton(
              onPressed: () {
                _showCardDialog();
              },
              child: Text(
                'Добавить открытку',
                style: Theme.of(context).textTheme.body2.copyWith(
                      color: Color.fromRGBO(110, 53, 76, 1),
                    ),
              ),
              borderSide: BorderSide(
                color: Color.fromRGBO(110, 53, 76, 1),
              ),
            )
          : FlatButton(
              onPressed: () {
                setState(() {
                  order.card = null;
                  isSelectedCard = false;
                });
              },
              child: new Text(
                "Удалить открытку",
                style: Theme.of(context).textTheme.body1.copyWith(
                      color: Color.fromRGBO(110, 53, 76, 1),
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
    );
  }

  Row getShop(context) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          child: IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            icon: Icon(
              Icons.home,
              color: Color.fromRGBO(130, 147, 153, 1),
            ),
            onPressed: () {
              showShopsDialog();
            },
          ),
        ),
        Text(
          "Магазин: ",
          style: Theme.of(context).textTheme.body1.copyWith(
                color: Color.fromRGBO(130, 147, 153, 1),
              ),
        ),
        Text(
          _shops.length != 0
              ? _shops
                  .where((element) => element.id == order.shopId)
                  .first
                  .address
              : "",
          style: Theme.of(context).textTheme.body1,
        ),
      ],
    );
  }

  Container getPhone(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (phone) {
          setState(() {});
        },
        cursorColor: Color.fromRGBO(130, 147, 153, 1),
        initialValue: ProfileManipulation.user.phone,
        style: Theme.of(context).textTheme.body1,
        decoration: InputDecoration(
          labelText: "Телефон",
          prefixText: "+7 ",
          focusColor: Color.fromRGBO(130, 147, 153, 1),
        ),
      ),
    );
  }

  Container getName(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        onChanged: (name) {
          setState(() {});
        },
        cursorColor: Color.fromRGBO(130, 147, 153, 1),
        initialValue: ProfileManipulation.user.name != null
            ? ProfileManipulation.user.name
            : "",
        style: Theme.of(context).textTheme.body1,
        decoration: InputDecoration(
          labelText: "Имя",
          focusColor: Color.fromRGBO(130, 147, 153, 1),
        ),
      ),
    );
  }

  Container getSurname(context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        onChanged: (surname) {
          setState(() {});
        },
        cursorColor: Color.fromRGBO(130, 147, 153, 1),
        initialValue: ProfileManipulation.user.surname != null
            ? ProfileManipulation.user.surname
            : "",
        style: Theme.of(context).textTheme.body1,
        decoration: InputDecoration(
          labelText: "Фамилия",
          focusColor: Color.fromRGBO(130, 147, 153, 1),
        ),
      ),
    );
  }

  Row getDate(context) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          child: IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            icon: Icon(
              Icons.access_time,
              color: Color.fromRGBO(130, 147, 153, 1),
            ),
            onPressed: () {
              showDateTimeDialog();
            },
          ),
        ),
        Text(
          "Дата сборки:  ",
          style: Theme.of(context).textTheme.body1.copyWith(
                color: Color.fromRGBO(130, 147, 153, 1),
              ),
        ),
        Text(
          order.finish == null
              ? DateFormat('dd.MM.yyyy hh:mm').format(DateTime.now()).toString()
              : DateFormat('dd.MM.yyyy hh:mm').format(order.finish).toString(),
          style: Theme.of(context).textTheme.body1,
        ),
      ],
    );
  }
  //#endregion

  //#region Dialogs
  Future<DateTime> showDateTimeDialog() {
    return showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white70,
          child: Column(
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  minimumDate: DateTime.now(),
                  use24hFormat: true,
                  onDateTimeChanged: (dateTime) {
                    setState(() {
                      order.finish = dateTime;
                    });
                  },
                ),
              ),
              FlatButton(
                padding: EdgeInsets.all(30),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text(
                  "Выбрать",
                  style: Theme.of(context).textTheme.body1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<Widget> showShopsDialog() {
    return showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white70,
          child: Column(
            children: [
              Expanded(
                child: CupertinoPicker.builder(
                  childCount: _shops.length,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      order.shopId = _shops[index].id;
                    });
                  },
                  itemExtent: 50,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        _shops[index].address,
                        style: Theme.of(context).textTheme.body1,
                      ),
                    );
                  },
                ),
              ),
              FlatButton(
                padding: EdgeInsets.all(30),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text(
                  "Выбрать",
                  style: Theme.of(context).textTheme.body1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
  //#endregion

  Widget _orderButton(context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        padding: EdgeInsets.only(top: 30, bottom: 20),
        child: FlatButton(
          onPressed: () async {
            await WebApiServices.postOrder(order);

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => NavigationMenu(),
                ),
                (Route<dynamic> route) => false);
          },
          padding: EdgeInsets.zero,
          child: Container(
            width: 150,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color.fromRGBO(130, 147, 153, 1),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Center(
              child: Text("Заказать", style: Theme.of(context).textTheme.body2),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showCardDialog() async {
    int _count = 0;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Открытка",
            style: Theme.of(context).textTheme.subtitle,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  onChanged: (card) {
                    setState(() {
                      order.card = card;
                    });
                  },
                  minLines: null,
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                    labelText: 'Надпись',
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
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
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Открытка добавлена"),
                      action: SnackBarAction(
                        label: "Понятно",
                        onPressed: () {
                          // Code to execute.
                        },
                      ),
                    ),
                  );
                },
                child: new Text(
                  "Сохранить",
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
