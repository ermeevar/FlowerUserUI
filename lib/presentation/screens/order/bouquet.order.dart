import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/internal/utils/profile.manipulation.dart';
import 'package:flower_user_ui/internal/utils/web.api.services.dart';
import 'package:flower_user_ui/presentation/screens/bouquet/bouquet.main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flower_user_ui/internal/extensions/double_extensions.dart';
import '../navigation.menu.dart';
import 'order.products.list.dart';

class BouquetOrder extends StatefulWidget {
  final Bouquet _bouquet;

  BouquetOrder(this._bouquet) {}

  @override
  BouquetOrderState createState() => BouquetOrderState(_bouquet);
}

class BouquetOrderState extends State<BouquetOrder> {
  Order order = new Order();
  bool isSelectedCard = false;
  Bouquet _bouquet;
  List<Shop> _shops = [];

  BouquetOrderState(this._bouquet) {
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
      order.orderStatusId = 1;
      order.cost = _bouquet.cost;
      order.bouquetId = _bouquet.id;
      order.isRandom = false;
    });
  }

  _getShops() async {
    await WebApiServices.fetchShops().then((response) {
      var shopsData = shopFromJson(response.data);
      setState(() {
        _shops = shopsData
            .where((element) => element.storeId == _bouquet.storeId)
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
          ProductsList(_bouquet.id),
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

  Widget _nameAndCostInfo(context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              _bouquet.name == null ? "" : _bouquet.name,
              overflow: TextOverflow.clip,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 23,
                    color: Color.fromRGBO(130, 147, 153, 1),
                  ),
            ),
          ),
          Text(
            order.cost != null
                ? order.cost.roundDouble(2).toString() + " ₽"
                : "",
            style: Theme.of(context)
                .textTheme
                .bodyText1
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
          ? OutlinedButton(
              onPressed: () {
                _showCardDialog();
              },
              child: Text(
                'Добавить открытку',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Color.fromRGBO(110, 53, 76, 1),
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
              child: new Text(
                "Удалить открытку",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
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
          style: Theme.of(context).textTheme.bodyText1.copyWith(
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
          style: Theme.of(context).textTheme.bodyText1,
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
        style: Theme.of(context).textTheme.bodyText1,
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
        style: Theme.of(context).textTheme.bodyText1,
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
        style: Theme.of(context).textTheme.bodyText1,
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
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Color.fromRGBO(130, 147, 153, 1),
              ),
        ),
        Text(
          order.finish == null
              ? DateFormat('dd.MM.yyyy hh:mm').format(DateTime.now()).toString()
              : DateFormat('dd.MM.yyyy hh:mm').format(order.finish).toString(),
          style: Theme.of(context).textTheme.bodyText1,
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
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text(
                  "Выбрать",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
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
                child: new Text(
                  "Выбрать",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
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
        child: TextButton(
          onPressed: () async {
            await WebApiServices.postOrder(order);

            BouquetMainMenuState.newBouquet = Bouquet();
            BouquetMainMenuState.products = [];

            showTopSnackBar(
              context,
              CustomSnackBar.info(
                icon: null,
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
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
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
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text(
                  "Назад",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Color.fromRGBO(130, 147, 153, 1),
                      ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextButton(
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
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
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
