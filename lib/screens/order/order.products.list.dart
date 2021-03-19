import 'package:flower_user_ui/models/product.dart';
import 'package:flower_user_ui/screens/bouquet/bouquet.main.dart';
import 'package:flower_user_ui/screens/order/order.main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatefulWidget {
  @override
  ProductsListState createState() => ProductsListState();
}

class ProductsListState extends State<ProductsList> {
  List<Product> _products = [];
  String _card=null;

  ProductsListState() {
    _products = BouquetMainMenuState.products;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 420,
        clipBehavior: Clip.none,
        color: Color.fromRGBO(110, 53, 76, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "Состав букета",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(color: Colors.white),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.zero,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      return Card(
                          margin: EdgeInsets.only(
                              top: 10, right: 10, left: 20, bottom: 10),
                          elevation: 5,
                          color: Color.fromRGBO(55, 50, 52, 1),
                          child: Container(
                            padding: EdgeInsets.zero,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _products[index].picture == null
                                    ? Container(
                                        width: 140,
                                        height: 200,
                                        child: Icon(
                                          Icons.image_outlined,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                        color: Colors.black12,
                                      )
                                    : _products[index].picture,
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                      _products[index].cost.toString() + " ₽",
                                      style: Theme.of(context).textTheme.body2),
                                ),
                              ],
                            ),
                          ));
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: OrderMainMenuState.order.card == null
                  ? OutlineButton(
                      onPressed: () {
                        _showCardDialog();
                      },
                      child: Text(
                        'Добавить открытку',
                        style: Theme.of(context)
                            .textTheme
                            .body2
                            .copyWith(color: Color.fromRGBO(130, 147, 153, 1)),
                      ),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(130, 147, 153, 1)),
                    )
                  : FlatButton(
                      onPressed: () {
                        setState(() {
                          OrderMainMenuState.order.card=null;
                          OrderMainMenuState.isSelectedCard =  false;
                        });
                      },
                      child: new Text(
                        "Удалить открытку",
                        style: Theme.of(context).textTheme.body1.copyWith(
                              color: Color.fromRGBO(130, 147, 153, 1),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
            ),
          ],
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
                  onChanged: (card){
                    setState(() {
                      _card=card;
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
                  setState(() {
                    OrderMainMenuState.order.card=_card;
                  });

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
