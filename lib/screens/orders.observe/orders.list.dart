import 'package:flower_user_ui/models/bouquet.dart';
import 'package:flower_user_ui/models/order.dart';
import 'package:flower_user_ui/models/shop.dart';
import 'package:flower_user_ui/models/user.dart';
import 'package:flower_user_ui/models/account.dart';
import 'package:flower_user_ui/models/order.status.dart';
import 'package:flower_user_ui/models/web.api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:currency_pickers/currency_pickers.dart';

class OrdersList extends StatefulWidget {
  User _user;
  Account _account;
  OrdersList(this._user, this._account);

  @override
  OrdersListState createState() => OrdersListState(_user, _account);
}

class OrdersListState extends State<OrdersList> {
  List<Order> _orders = [];
  List<Shop> _shops = [];
  List<Bouquet> _bouquets = [];
  List<OrderStatus> _orderStatuses = [];
  User _user;
  Account _account;

  OrdersListState(this._user, this._account) {
    _getOrders();
    _getShops();
    _getBouquets();
    _getOrderStatuses();
  }

  _getOrders() {
    WebApiServices.fetchOrders().then((response) {
      var ordersData = orderFromJson(response.data);
      setState(() {
        _orders = ordersData;
      });
    });
  }

  _getShops() {
    WebApiServices.fetchShop().then((response) {
      var shopsData = shopFromJson(response.data);
      setState(() {
        _shops = shopsData;
      });
    });
  }

  _getBouquets() {
    WebApiServices.fetchBouquets().then((response) {
      var bouquetData = bouquetFromJson(response.data);
      setState(() {
        _bouquets = bouquetData;
      });
    });
  }

  _getOrderStatuses() {
    WebApiServices.fetchOrderStatuses().then((response) {
      var orderStatusesData = orderStatusFromJson(response.data);
      setState(() {
        _orderStatuses = orderStatusesData;
      });
    });
  }

  Shop getShopInOrder(Order order) {
    for (var item in _shops) {
      if (order.shopId == item.id) return item;
    }
  }

  Bouquet getBouquetInOrder(Order order) {
    for (var item in _bouquets) {
      if (order.bouquetId == item.id) return item;
    }
  }

  OrderStatus getOrderStatusInOrder(Order order) {
    for (var item in _orderStatuses) {
      if (order.orderStatusId == item.id) return item;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Expanded(
          child: _orders.length == 0
              ? Center(
                  child: Container(
                      color: Colors.white,
                      child: Text("У вас нет ни одного заказа",
                          style: Theme.of(context).textTheme.body1)))
              : ListView.builder(
                  itemCount: _orders.length + 1,
                  itemBuilder: (context, index) {
                    return index + 1 == _orders.length + 1
                        ? Container(height: 90, color: Colors.white)
                        : Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 20, left: 20, right: 20),
                                    child: Text(
                                        DateFormat('Букет на dd.MM.yyyy hh:mm')
                                            .format(_orders[index].finish)
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .body1
                                            .copyWith(
                                                fontWeight: FontWeight.bold))),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                        "Номер заказа: " +
                                            _orders[index].id.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .body1
                                            .copyWith(
                                                color: Color.fromRGBO(
                                                    110, 53, 76, 1)))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, top: 40),
                                    child: Text(
                                        "Пункт выдачи на " +
                                            getShopInOrder(_orders[index])
                                                .address,
                                        style:
                                            Theme.of(context).textTheme.body1)),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Divider(
                                      thickness: 1,
                                      color: Color.fromRGBO(130, 157, 143, 1),
                                    )),
                                _orders[index].bouquetId != null
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20, top: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Персональный букет",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .body1
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        getBouquetInOrder(
                                                                _orders[index])
                                                            .name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .body1)),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                        _orders[index]
                                                                .cost
                                                                .toString() +
                                                            " " +
                                                            CurrencyPickerUtils.getCountryByIsoCode(
                                                                    'RU')
                                                                .currencyCode
                                                                .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .body1
                                                            .copyWith(
                                                                color:
                                                                    Color.fromRGBO(
                                                                        130,
                                                                        157,
                                                                        143,
                                                                        1),
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                              ],
                                            ),
                                          ],
                                        ))
                                    : Container(height: 0),
                                _orders[index].templateId != null
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20, top: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: Text("Букет по шаблону",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .body1)),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                    _orders[index]
                                                        .cost
                                                        .toString() +
                                                        " " +
                                                        CurrencyPickerUtils
                                                                .getCountryByIsoCode(
                                                                    'RU')
                                                            .currencyCode
                                                            .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .body1
                                                        .copyWith(
                                                            color: Color.fromRGBO(
                                                                130, 157, 143, 1),
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                          ],
                                        ))
                                    : Container(height: 0),
                                _orders[index].isRandom != false
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20, top: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: Text("Случайный букет",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .body1)),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                    _orders[index]
                                                        .cost
                                                        .toString() +
                                                        " " +
                                                        CurrencyPickerUtils
                                                                .getCountryByIsoCode(
                                                                    'RU')
                                                            .currencyCode
                                                            .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .body1
                                                        .copyWith(
                                                            color: Color.fromRGBO(
                                                                130, 157, 143, 1),
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                          ],
                                        ))
                                    : Container(height: 0),
                                Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Text(
                                            getOrderStatusInOrder(
                                                    _orders[index])
                                                .name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromRGBO(
                                                        110, 53, 76, 1)))
                                      ],
                                    )),
                              ],
                            ),
                          );
                  }),
        ));
  }
}
