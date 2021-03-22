import 'dart:math';
import 'package:flower_user_ui/models/bouquet.dart';
import 'package:flower_user_ui/models/order.dart';
import 'package:flower_user_ui/models/shop.dart';
import 'package:flower_user_ui/models/bouquet.product.dart';
import 'package:flower_user_ui/models/web.api.services.dart';
import 'package:flower_user_ui/screens/bouquet/bouquet.main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../navigation.menu.dart';
import 'order.products.list.dart';

class OrderMainMenu extends StatefulWidget {
  Bouquet _accountBouquet = Bouquet();
  double _cost;

  OrderMainMenu() {}
  OrderMainMenu.OldBouquet(this._accountBouquet) {}
  OrderMainMenu.RandomBouquet(this._cost) {}

  @override
  OrderMainMenuState createState() => _accountBouquet.id == 0
      ? OrderMainMenuState()
      : _cost != null
          ? OrderMainMenuState.RandomBouquet(_cost)
          : OrderMainMenuState.OldBouquet(_accountBouquet);
}

class OrderMainMenuState extends State<OrderMainMenu> {
  static Order order = new Order();
  static bool isSelectedCard = false;
  double _cost;
  Bouquet _accountBouquet = Bouquet();
  List<Shop> _shops = [];

  OrderMainMenuState() {
    _setOrderInitialData();
  }

  OrderMainMenuState.OldBouquet(this._accountBouquet) {
    _setOrderInitialData();
  }

  OrderMainMenuState.RandomBouquet(this._cost) {
    _setOrderInitialData();
  }

  _setOrderInitialData() async {
    await _getShops();

    await setState(() {
      order.userId = NavigationMenu.user.id;
      order.finish = DateTime.now().add(Duration(days: 1));
      order.shopId = _shops.first.id;
      order.orderStatusId = 1;

      if (_accountBouquet.id != null)
        order.cost = _accountBouquet.cost;
      else if (_cost != null)
        order.cost = _cost;
      else
        order.cost = BouquetMainMenuState.newBouquet.cost;

      if (_accountBouquet.id != 0) order.bouquetId = _accountBouquet.id;

      if (_cost == null)
        order.isRandom = false;
      else
        order.isRandom = true;
    });
  }

  _getShops() async {
    await WebApiServices.fetchShop().then((response) {
      var shopsData = shopFromJson(response.data);
      setState(() {
        if (_cost != null)
          _shops = shopsData;
        else if (_accountBouquet.id == null)
          _shops = shopsData
              .where((element) =>
                  element.storeId == BouquetMainMenuState.newBouquet.storeId)
              .toList();
        else
          _shops = shopsData
              .where((element) => element.storeId == _accountBouquet.storeId)
              .toList();
      });
    });
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _header(context),
          _nameAndCostInfo(context),
          _orderInfo(context),
          if (_cost == null)
            ProductsList(),
          _buttons(context),
        ],
      ),
    );
  }

  Widget _header(context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 30),
              padding: EdgeInsets.zero,
              color: Color.fromRGBO(130, 147, 153, 1),
              onPressed: () {
                order = Order();
                _shops = [];
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
                order.bouquetId != null && order.bouquetId != 0
                    ? _accountBouquet.name
                    : BouquetMainMenuState.newBouquet.name != null
                        ? BouquetMainMenuState.newBouquet.name
                        : _cost != null
                            ? "Случайный букет"
                            : "Название букета",
                overflow: TextOverflow.clip,
                softWrap: true,
                style: Theme.of(context).textTheme.body1.copyWith(
                      fontSize: 23,
                      color: Color.fromRGBO(130, 147, 153, 1),
                    )),
          ),
          Text(
              order.cost != null
                  ? roundDouble(order.cost, 2).toString() + " ₽"
                  : _cost != null
                      ? roundDouble(_cost, 2).toString() + " ₽"
                      : "Цена",
              style: Theme.of(context).textTheme.body1.copyWith(
                    color: Color.fromRGBO(130, 147, 153, 1),
                    fontSize: 25,
                  )),
        ],
      ),
    );
  }

  Widget _orderInfo(context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Дата сборки:  ",
                style: Theme.of(context).textTheme.body1,
              ),
              Text(
                order.finish == null
                    ? ""
                    : DateFormat('dd.MM.yyyy hh:mm')
                        .format(order.finish)
                        .toString(),
                style: Theme.of(context).textTheme.body1,
              ),
              IconButton(
                icon: Icon(
                  Icons.access_time,
                  color: Color.fromRGBO(130, 147, 153, 1),
                ),
                onPressed: () {
                  showDateTimeDialog();
                },
              )
            ],
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
          Row(
            children: [
              Text(
                "Магазин: ",
                style: Theme.of(context).textTheme.body1,
              ),
              Text(
                order.shopId == null
                    ? ""
                    : _shops
                        .where((element) => element.id == order.shopId)
                        .first
                        .address,
                style: Theme.of(context).textTheme.body1,
              ),
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: Color.fromRGBO(130, 147, 153, 1),
                ),
                onPressed: () {
                  showShopsDialog();
                },
              )
            ],
          )
        ],
      ),
    );
  }

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

  Widget _buttons(context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          _accountBouquet.id == null && _cost == null
              ? FlatButton(
                  onPressed: () async {
                    _postBouquet(context);
                    BouquetMainMenuState.products = [];
                    BouquetMainMenuState.newBouquet = Bouquet();
                    order = Order();
                    _shops = [];
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: new Text(
                    "Сохранить как шаблон",
                    style: Theme.of(context).textTheme.body1.copyWith(
                          color: Color.fromRGBO(130, 147, 153, 1),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(10),
            child: FlatButton(
                onPressed: () async {
                  await _postOrder(context);

                  BouquetMainMenuState.products = [];
                  BouquetMainMenuState.newBouquet = Bouquet();
                  _cost = null;
                  order = Order();
                  _shops = [];
                  isSelectedCard = false;
                  _accountBouquet = Bouquet();

                  Navigator.pop(context);
                },
                padding: EdgeInsets.zero,
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(130, 147, 153, 1),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: new Text("Заказать",
                        style: Theme.of(context).textTheme.body2))),
          ),
        ],
      ),
    );
  }

  Future _postBouquet(context) async {
    BouquetMainMenuState.newBouquet.userId = NavigationMenu.user.id;
    await WebApiServices.postBouquet(BouquetMainMenuState.newBouquet);

    Bouquet postedBouquet;
    await WebApiServices.fetchBouquet().then((response) {
      var bouquetsData = bouquetFromJson(response.data);
      postedBouquet = bouquetsData.last;
    });

    for (var item in BouquetMainMenuState.products) {
      BouquetProduct middleBouquetProduct = BouquetProduct();
      middleBouquetProduct.bouquetId = postedBouquet.id;
      middleBouquetProduct.productId = item.id;
      await WebApiServices.postBouquetProduct(middleBouquetProduct);
    }
  }

  void _postOrder(context) async {
    if (order.bouquetId == null && _cost == null){
      await _postBouquet(context);

      Bouquet postedBouquet;
      await WebApiServices.fetchBouquet().then((response) {
        var bouquetsData = bouquetFromJson(response.data);
        postedBouquet = bouquetsData.last;
      });

      order.bouquetId = postedBouquet.id;
    }

    order.start = DateTime.now();
    await WebApiServices.postOrder(order);
  }
}
