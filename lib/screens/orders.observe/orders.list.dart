import 'package:flower_user_ui/models/bouquet.dart';
import 'package:flower_user_ui/models/order.dart';
import 'package:flower_user_ui/models/shop.dart';
import 'package:flower_user_ui/models/user.dart';
import 'package:flower_user_ui/models/account.dart';
import 'package:flower_user_ui/models/web.api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdersList extends StatefulWidget {
  User _user;
  Account _account;
  OrdersList(this._user, this._account);

  @override
  OrdersListState createState() => OrdersListState(_user, _account);
}

class OrdersListState extends State<OrdersList> {
  List<Order> _orders;
  List<Shop> _shops;
  List<Bouquet> _bouquets;
  User _user;
  Account _account;
  OrdersListState(this._user, this._account) {
    _getOrders();
    _getShops();
    _getBouquets();
  }

  _getOrders() {
    WebApiServices.fetchOrders().then((response) {
      var ordersData = orderFromJson(response.data);
      setState(() {
        _orders =
            ordersData;
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

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Expanded(
          child: _orders.length == null
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
                            color: Colors.white,
                            elevation: 10,
                            child: Column(
                              children: [
                                Text(
                                    "Букет на " +
                                        _orders[index].finish.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .body1
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text(
                                    "Номер заказа: " +
                                        _orders[index].id.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .body1
                                        .copyWith(
                                            color: Color.fromRGBO(
                                                110, 53, 76, 1))),
                                Text(
                                    "Пункт выдачи на " +
                                        getShopInOrder(_orders[index]).address,
                                    style: Theme.of(context)
                                        .textTheme
                                        .body1
                                        .copyWith(
                                            height: 4,
                                            color: Color.fromRGBO(
                                                110, 53, 76, 1))),
                                Divider(
                                  thickness: 2,
                                  color: Color.fromRGBO(130, 157, 143, 1),
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                            getBouquetInOrder(_orders[index]).name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        Text("<ertn "),
                                      ],
                                    ),
                                    Text(
                                        getBouquetInOrder(_orders[index]).cost.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .body1
                                            .copyWith(fontSize: 25, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Text(
                                    _orders[index].orderStatusId.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .body1
                                        .copyWith(fontWeight: FontWeight.bold, color: Color.fromRGBO(110, 53, 76, 1))),
                              ],
                            ),
                          );
                  }),
        ));
  }
}
