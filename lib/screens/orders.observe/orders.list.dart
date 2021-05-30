import 'package:flower_user_ui/entities/bouquet.dart';
import 'package:flower_user_ui/entities/order.dart';
import 'package:flower_user_ui/entities/shop.dart';
import 'package:flower_user_ui/entities/order.status.dart';
import 'package:flower_user_ui/screens/navigation.menu.dart';
import 'package:flower_user_ui/states/calc.dart';
import 'package:flower_user_ui/states/nullContainer.dart';
import 'package:flower_user_ui/states/spaceContainer.dart';
import 'package:flower_user_ui/states/web.api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersList extends StatefulWidget {
  @override
  OrdersListState createState() => OrdersListState();
}

class OrdersListState extends State<OrdersList>
    with SingleTickerProviderStateMixin {
  List<Order> _orders = [];
  List<Shop> _shops = [];
  List<Bouquet> _bouquets = [];
  List<OrderStatus> _orderStatuses = [];

  OrdersListState() {
    _getOrders();
    _getShops();
    _getBouquets();
    _getOrderStatuses();
  }

  //#region GetData
  Future<void> _refresh() async {
    await _getOrders();
    await _getShops();
    await _getBouquets();
    await _getOrderStatuses();
  }

  _getOrders() async {
    await WebApiServices.fetchOrders().then((response) {
      var ordersData = orderFromJson(response.data);
      setState(() {
        _orders = ordersData.reversed.toList();
      });
    });
  }

  _getShops() async {
    await WebApiServices.fetchShops().then((response) {
      var shopsData = shopFromJson(response.data);
      setState(() {
        _shops = shopsData;
      });
    });
  }

  _getBouquets() async {
    await WebApiServices.fetchBouquets().then((response) {
      var bouquetData = bouquetFromJson(response.data);
      setState(() {
        _bouquets = bouquetData;
      });
    });
  }

  _getOrderStatuses() async {
    await WebApiServices.fetchOrderStatuses().then((response) {
      var orderStatusesData = orderStatusFromJson(response.data);
      setState(() {
        _orderStatuses = orderStatusesData;
      });
    });
  }
  //#endregion

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Color.fromRGBO(110, 53, 76, 1),
      key: NavigationMenuState.refreshIndicatorKey,
      onRefresh: _refresh,
      child: _orders.length == 0 ||
              _shops.length == 0 ||
              _bouquets.length == 0 ||
              _orderStatuses.length == 0
          ? nullContainer()
          : buildContent(context),
    );
  }

  Container buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Expanded(
        child: _orders.length == 0
            ? showNullOrderError(context)
            : buildOrderList(),
      ),
    );
  }

  ListView buildOrderList() {
    return ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemCount: _orders.length + 1,
        itemBuilder: (context, index) {
          return index + 1 == _orders.length + 1
              ? getSpaceContainer()
              : drawCard(index, context);
        });
  }

  //#region Card
  Card drawCard(int index, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      color: Colors.white,
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getDate(index, context),
          getOrderId(index, context),
          getShop(index, context),
          getDivider(),
          _orders[index].bouquetId != null
              ? getBouquet(context, index)
              : nullContainer(),
          _orders[index].templateId != null
              ? getTemplate(context, index)
              : nullContainer(),
          _orders[index].isRandom != false
              ? getRandom(context, index)
              : nullContainer(),
          getStatus(index, context),
        ],
      ),
    );
  }

  Padding getStatus(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Spacer(),
          Text(
            getOrderStatusInOrder(_orders[index]).name,
            style: Theme.of(context).textTheme.body1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(110, 53, 76, 1),
                ),
          ),
        ],
      ),
    );
  }

  Padding getRandom(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text("Случайный букет",
                  style: Theme.of(context).textTheme.body1)),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              Calc.roundDouble(_orders[index].cost, 2).toString() + " ₽",
              style: Theme.of(context).textTheme.body1.copyWith(
                  color: Color.fromRGBO(130, 157, 143, 1),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Padding getTemplate(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text("Букет по шаблону",
                  style: Theme.of(context).textTheme.body1)),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              Calc.roundDouble(_orders[index].cost, 2).toString() + " ₽",
              style: Theme.of(context).textTheme.body1.copyWith(
                  color: Color.fromRGBO(130, 157, 143, 1),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Padding getBouquet(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Персональный букет",
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(getBouquetInOrder(_orders[index]).name,
                    style: Theme.of(context).textTheme.body1),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  Calc.roundDouble(_orders[index].cost, 2).toString() + " ₽",
                  style: Theme.of(context).textTheme.body1.copyWith(
                      color: Color.fromRGBO(130, 157, 143, 1),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding getDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Divider(
        thickness: 1,
        color: Color.fromRGBO(130, 157, 143, 1),
      ),
    );
  }

  Padding getShop(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 40),
      child: Text("Пункт выдачи на " + getShopInOrder(_orders[index]).address,
          style: Theme.of(context).textTheme.body1),
    );
  }

  Padding getOrderId(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Номер заказа: " + _orders[index].id.toString(),
        style: Theme.of(context).textTheme.body1.copyWith(
              color: Color.fromRGBO(110, 53, 76, 1),
            ),
      ),
    );
  }

  Padding getDate(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Text(
        DateFormat('Букет на dd.MM.yyyy hh:mm')
            .format(_orders[index].finish)
            .toString(),
        style: Theme.of(context)
            .textTheme
            .body1
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
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
  //#endregion

  Center showNullOrderError(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Text("У вас нет ни одного заказа",
            style: Theme.of(context).textTheme.body1),
      ),
    );
  }
}
