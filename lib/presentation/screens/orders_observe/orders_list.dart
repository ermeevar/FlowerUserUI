import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/data/services/services.dart';
import 'package:flower_user_ui/internal/extensions/double_extensions.dart';
import 'package:flower_user_ui/presentation/common_widgets/null_container.dart';
import 'package:flower_user_ui/presentation/common_widgets/space_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../navigation_menu.dart';

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

  Future<void> _getOrders() async {
    await ApiService.fetchOrders().then((response) {
      final ordersData = orderFromJson(response.data as String);
      setState(() {
        _orders = ordersData.reversed.toList();
      });
    });
  }

  Future<void> _getShops() async {
    await ApiService.fetchShops().then((response) {
      final shopsData = shopFromJson(response.data as String);
      setState(() {
        _shops = shopsData;
      });
    });
  }

  Future<void> _getBouquets() async {
    await ApiService.fetchBouquets().then((response) {
      final bouquetData = bouquetFromJson(response.data as String);
      setState(() {
        _bouquets = bouquetData;
      });
    });
  }

  Future<void> _getOrderStatuses() async {
    await ApiService.fetchOrderStatuses().then((response) {
      final orderStatusesData = orderStatusFromJson(response.data as String);
      setState(() {
        _orderStatuses = orderStatusesData;
      });
    });
  }
  //#endregion

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: const Color.fromRGBO(110, 53, 76, 1),
      key: NavigationMenuState.refreshIndicatorKey,
      onRefresh: _refresh,
      child: _orders.isEmpty ||
              _shops.isEmpty ||
              _bouquets.isEmpty ||
              _orderStatuses.isEmpty
          ? nullContainer()
          : buildContent(context),
    );
  }

  Container buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      color: Colors.white,
      child: _orders.isEmpty ? showNullOrderError(context) : buildOrderList(),
    );
  }

  ListView buildOrderList() {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 10),
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
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      color: Colors.white,
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getDate(index, context),
          getOrderId(index, context),
          getShop(index, context),
          getDivider(),
          if (_orders[index].bouquetId != null)
            getBouquet(context, index)
          else
            nullContainer(),
          if (_orders[index].templateId != null)
            getTemplate(context, index)
          else
            nullContainer(),
          if (_orders[index].isRandom != false)
            getRandom(context, index)
          else
            nullContainer(),
          getStatus(index, context),
        ],
      ),
    );
  }

  Padding getStatus(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Spacer(),
          Text(
            getOrderStatusInOrder(_orders[index])!.name!,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(110, 53, 76, 1),
                ),
          ),
        ],
      ),
    );
  }

  Padding getRandom(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text("Случайный букет",
                  style: Theme.of(context).textTheme.bodyText1)),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "${_orders[index].cost!.roundDouble(2)} ₽",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: const Color.fromRGBO(130, 157, 143, 1),
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
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text("Букет по шаблону",
                  style: Theme.of(context).textTheme.bodyText1)),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "${_orders[index].cost!.roundDouble(2)} ₽",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: const Color.fromRGBO(130, 157, 143, 1),
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
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Персональный букет",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(getBouquetInOrder(_orders[index])!.name!,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "${_orders[index].cost!.roundDouble(2)} ₽",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: const Color.fromRGBO(130, 157, 143, 1),
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Divider(
        thickness: 1,
        color: Color.fromRGBO(130, 157, 143, 1),
      ),
    );
  }

  Padding getShop(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
      child: Text("Пункт выдачи на ${getShopInOrder(_orders[index])!.address!}",
          style: Theme.of(context).textTheme.bodyText1),
    );
  }

  Padding getOrderId(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Номер заказа: ${_orders[index].id}",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: const Color.fromRGBO(110, 53, 76, 1),
            ),
      ),
    );
  }

  Padding getDate(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Text(
        DateFormat('Букет на dd.MM.yyyy hh:mm')
            .format(_orders[index].finish!)
            .toString(),
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Shop? getShopInOrder(Order order) {
    for (final item in _shops) {
      if (order.shopId == item.id) return item;
    }
  }

  Bouquet? getBouquetInOrder(Order order) {
    for (final item in _bouquets) {
      if (order.bouquetId == item.id) return item;
    }
  }

  OrderStatus? getOrderStatusInOrder(Order order) {
    for (final item in _orderStatuses) {
      if (order.orderStatusId == item.id) return item;
    }
  }
  //#endregion

  Center showNullOrderError(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Text("У вас нет ни одного заказа",
            style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }
}
