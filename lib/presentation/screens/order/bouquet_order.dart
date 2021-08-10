import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/data/services/services.dart';
import 'package:flower_user_ui/presentation/screens/bouquet/bouquet_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flower_user_ui/internal/extensions/double_extensions.dart';
import '../navigation_menu.dart';
import 'order_products_list.dart';

class BouquetOrder extends StatefulWidget {
  final Bouquet? _bouquet;

  const BouquetOrder(this._bouquet);

  @override
  BouquetOrderState createState() => BouquetOrderState();
}

class BouquetOrderState extends State<BouquetOrder> {
  Order order = Order();
  bool isSelectedCard = false;
  late final Bouquet? _bouquet;
  List<Shop> _shops = [];

  BouquetOrderState() {
    _bouquet = widget._bouquet;
    _setOrderInitialData();
  }

  //#region Set data
  Future<void> _setOrderInitialData() async {
    await _getShops();

    setState(() {
      order.userId = ProfileService.user.id;
      order.finish = DateTime.now().add(const Duration(days: 1));
      order.start = DateTime.now();
      order.shopId = _shops.first.id;
      order.orderStatusId = 1;
      order.cost = _bouquet!.cost;
      order.bouquetId = _bouquet!.id;
      order.isRandom = false;
    });
  }

  Future<void> _getShops() async {
    await ApiService.fetchShops().then((response) {
      final shopsData = shopFromJson(response.data as String);
      setState(() {
        _shops = shopsData
            .where((element) => element.storeId == _bouquet!.storeId)
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
          ProductsList(_bouquet!.id),
          _orderButton(context),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 25),
              padding: const EdgeInsets.only(left: 20),
              color: const Color.fromRGBO(130, 147, 153, 1),
              onPressed: () {
                BouquetMainMenuState.newBouquet = Bouquet();
                BouquetMainMenuState.products = [];

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => NavigationMenu(),
                    ),
                    (Route<dynamic> route) => false);
              },
            ),
          ),
          Text("Оформление заказа",
              style: Theme.of(context).textTheme.headline6)
        ],
      ),
    );
  }

  Widget _nameAndCostInfo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _bouquet!.name == null ? "" : _bouquet!.name!,
            overflow: TextOverflow.clip,
            softWrap: true,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 23,
                  color: const Color.fromRGBO(130, 147, 153, 1),
                ),
          ),
          Text(
            order.cost != null ? "${order.cost!.roundDouble(2)} ₽" : "",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold, height: 2),
          ),
        ],
      ),
    );
  }

  //#region Order information
  Widget _orderInfo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
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

  Padding getCardButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: order.card == null
          ? OutlinedButton(
              onPressed: () {
                _showCardDialog();
              },
              child: Text(
                'Добавить открытку',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: const Color.fromRGBO(110, 53, 76, 1),
                    ),
              ),
              // borderSide: BorderSide(
              //   color: Color.fromRGBO(110, 53, 76, 1),
              // ),
            )
          : TextButton(
              onPressed: () {
                setState(() {
                  order.card = null;
                  isSelectedCard = false;
                });
              },
              child: Text(
                "Удалить открытку",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: const Color.fromRGBO(110, 53, 76, 1),
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
    );
  }

  Row getShop(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          child: IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            icon: const Icon(
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
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: const Color.fromRGBO(130, 147, 153, 1),
              ),
        ),
        Text(
          _shops.isNotEmpty
              ? _shops
                  .where((element) => element.id == order.shopId)
                  .first
                  .address!
              : "",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Container getPhone(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (phone) {
          setState(() {});
        },
        cursorColor: const Color.fromRGBO(130, 147, 153, 1),
        initialValue: ProfileService.user.phone,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: const InputDecoration(
          labelText: "Телефон",
          prefixText: "+7 ",
          focusColor: Color.fromRGBO(130, 147, 153, 1),
        ),
      ),
    );
  }

  Container getName(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        onChanged: (name) {
          setState(() {});
        },
        cursorColor: const Color.fromRGBO(130, 147, 153, 1),
        initialValue: ProfileService.user.name ?? "",
        style: Theme.of(context).textTheme.bodyText1,
        decoration: const InputDecoration(
          labelText: "Имя",
          focusColor: Color.fromRGBO(130, 147, 153, 1),
        ),
      ),
    );
  }

  Container getSurname(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        onChanged: (surname) {
          setState(() {});
        },
        cursorColor: const Color.fromRGBO(130, 147, 153, 1),
        initialValue: ProfileService.user.surname ?? "",
        style: Theme.of(context).textTheme.bodyText1,
        decoration: const InputDecoration(
          labelText: "Фамилия",
          focusColor: Color.fromRGBO(130, 147, 153, 1),
        ),
      ),
    );
  }

  Row getDate(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          child: IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            icon: const Icon(
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
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: const Color.fromRGBO(130, 147, 153, 1),
              ),
        ),
        Text(
          order.finish == null
              ? DateFormat('dd.MM.yyyy hh:mm').format(DateTime.now()).toString()
              : DateFormat('dd.MM.yyyy hh:mm').format(order.finish!).toString(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
  //#endregion

  //#region Dialogs
  Future<DateTime?> showDateTimeDialog() {
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
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Выбрать",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
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

  Future<Widget?> showShopsDialog() {
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
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        _shops[index].address!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    );
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Выбрать",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
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

  Widget _orderButton(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        padding: const EdgeInsets.only(top: 30, bottom: 20),
        child: TextButton(
          onPressed: () async {
            await ApiService.postOrder(order);

            BouquetMainMenuState.newBouquet = Bouquet();
            BouquetMainMenuState.products = [];

            showTopSnackBar(
              context,
              const CustomSnackBar.info(
                backgroundColor: Color.fromRGBO(110, 53, 76, 1),
                message: "Заказ оформлен",
              ),
            );

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => NavigationMenu(),
                ),
                (Route<dynamic> route) => false);
          },
          child: Container(
            width: 150,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(130, 147, 153, 1),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Center(
              child: Text("Заказать",
                  style: Theme.of(context).textTheme.bodyText2),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showCardDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Открытка",
            style: Theme.of(context).textTheme.subtitle1,
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
                  maxLines: null,
                  decoration: const InputDecoration(
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
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Назад",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: const Color.fromRGBO(130, 147, 153, 1),
                    ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Открытка добавлена"),
                      action: SnackBarAction(
                        label: "Понятно",
                        onPressed: () {
                          // Code to execute.
                        },
                      ),
                    ),
                  );
                },
                child: Text(
                  "Сохранить",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: const Color.fromRGBO(130, 147, 153, 1),
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
