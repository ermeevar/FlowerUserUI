import 'package:flower_user_ui/entities/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flower_user_ui/states/web.api.services.dart';
import 'bouquet.main.dart';

class DecorationSelection extends StatefulWidget {
  @override
  DecorationSelectionState createState() => DecorationSelectionState();
}

class DecorationSelectionState extends State<DecorationSelection> {
  List<Product> _products = [];

  DecorationSelectionState() {
    _getStoreProducts();
  }

  _getStoreProducts() {
    WebApiServices.fetchProducts().then((response) {
      var storeproductsData = productFromJson(response.data);
      setState(() {
        _products = storeproductsData
            .where((element) =>
                element.storeId == BouquetMainMenuState.newBouquet.storeId &&
                element.productCategoryId == 3)
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getDecorationTitle(context),
        showNonSelectedStoreError(context),
      ],
    );
  }

  Expanded showNonSelectedStoreError(BuildContext context) {
    return Expanded(
      child: _products.length == 0
          ? Center(
              child: Text("Сеть не выбрана",
                  style: Theme.of(context).textTheme.body1))
          : _storeProductsList(context),
    );
  }

  Padding getDecorationTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20, top: 20),
      child: Text(
        "Украшения",
        style: Theme.of(context).textTheme.body1,
      ),
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
                  bool isHasInBouquet = false;
                  for (var item in BouquetMainMenuState.products) {
                    if (item.id == _products[index].id) {
                      isHasInBouquet = true;
                    }
                  }

                  if (!isHasInBouquet) {
                    BouquetMainMenuState.products.add(_products[index]);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: !isHasInBouquet
                          ? Text("Украшение добавлены в букет")
                          : Text("Цукрашение уже присутствует в букете"),
                      action: SnackBarAction(
                        label: "Понятно",
                        onPressed: () {
                          // Code to execute.
                        },
                      ),
                    ),
                  );
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
}
