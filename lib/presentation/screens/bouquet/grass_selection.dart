import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/domain/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bouquet_main.dart';

class GrassSelection extends StatefulWidget {
  @override
  GrassSelectionState createState() => GrassSelectionState();
}

class GrassSelectionState extends State<GrassSelection> {
  List<Product> _products = [];

  GrassSelectionState() {
    _getStoreProducts();
  }

  _getStoreProducts() {
    ApiService.fetchProducts().then((response) {
      var storeproductsData = productFromJson(response.data);
      setState(() {
        _products = storeproductsData
            .where((element) =>
                element.storeId == BouquetMainMenuState.newBouquet.storeId &&
                element.productCategoryId == 2)
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getGrassTitle(context),
        getNonSelectedStoreError(context),
      ],
    );
  }

  Expanded getNonSelectedStoreError(BuildContext context) {
    return Expanded(
      child: _products.length == 0
          ? Center(
              child: Text("Сеть не выбрана",
                  style: Theme.of(context).textTheme.bodyText1))
          : _storeProductsList(context),
    );
  }

  Padding getGrassTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20, top: 20),
      child: Text(
        "Зелень",
        style: Theme.of(context).textTheme.bodyText1,
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
                          ? Text("Зелень добавлена в букет")
                          : Text("Зелень уже присутствует в букете"),
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
                            : ClipOval(
                                child: Image(
                                  image: MemoryImage(
                                    _products[index].picture,
                                  ),
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            _products[index].name,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Color.fromRGBO(55, 50, 52, 1),
                                    ),
                          ),
                        ),
                        Text(
                          _products[index].cost.toString() + " ₽",
                          style: Theme.of(context).textTheme.bodyText1,
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
