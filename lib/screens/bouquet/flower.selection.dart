import 'package:flower_user_ui/models/store.dart';
import 'package:flower_user_ui/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flower_user_ui/models/web.api.services.dart';
import 'bouquet.main.dart';

class FlowerSelection extends StatefulWidget {
  @override
  FlowerSelectionState createState() => FlowerSelectionState();
}

class FlowerSelectionState extends State<FlowerSelection> {
  List<Product> _products = [];

  FlowerSelectionState() {
    _getStoreProducts();
  }

  _getStoreProducts() {
    WebApiServices.fetchProduct().then((response) {
      var storeproductsData = productFromJson(response.data);
      setState(() {
        _products = storeproductsData
            .where((element) =>
                element.storeId == BouquetMainMenuState.newBouquet.storeId &&
                element.productCategoryId == 1)
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20, top: 20),
          child: Text(
            "Цветы",
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        Expanded(
          child: _products.length == 0
              ? Center(
                  child: Text("Сеть не выбрана",
                      style: Theme.of(context).textTheme.body1))
              : _storeProductsList(context),
        ),
      ],
    );
  }

  Widget _storeProductsList(context) {
    return GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  _showCountOfProductDialog(_products[index]);
                },
                child: Card(
                  elevation: 10,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: 20, right: 10, left: 10, top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _products[index].picture == null
                            ? Container(
                                width: 140,
                                height: 140,
                                child: Icon(
                                  Icons.image_outlined,
                                  color: Colors.black38,
                                  size: 50,
                                ),
                                color: Colors.black12,
                              )
                            : _products[index].picture,
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            _products[index].name,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style:
                                Theme.of(context).textTheme.subtitle.copyWith(
                                      color: Color.fromRGBO(55, 50, 52, 1),
                                    ),
                          ),
                        ),
                        Text(
                          _products[index].cost.toString() + " ₽",
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _showCountOfProductDialog(Product selectedProduct) async {
    int _count = 0;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            selectedProduct.name,
            style: Theme.of(context).textTheme.subtitle,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                    onChanged: (count) {
                      _count = int.parse(count);
                    },
                    cursorColor: Color.fromRGBO(130, 147, 153, 1),
                    style: Theme.of(context).textTheme.body1,
                    decoration: InputDecoration(
                      labelText: "Количество",
                      focusColor: Color.fromRGBO(130, 147, 153, 1),
                    ))
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
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
                  if (_count != 0) {
                    for (int i = 0; i < _count; i++) {
                      BouquetMainMenuState.products.add(selectedProduct);
                    }
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Цветок добавлен"),
                        action: SnackBarAction(
                          label: "Понятно",
                          onPressed: () {
                            // Code to execute.
                          },
                        ),
                      ),
                    );
                  }
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
