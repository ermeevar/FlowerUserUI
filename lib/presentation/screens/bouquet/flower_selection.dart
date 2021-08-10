import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/data/services/services.dart';
import 'package:flower_user_ui/presentation/common_widgets/slider_shape.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bouquet_main.dart';

class FlowerSelection extends StatefulWidget {
  @override
  FlowerSelectionState createState() => FlowerSelectionState();
}

class FlowerSelectionState extends State<FlowerSelection> {
  List<Product> _products = [];

  FlowerSelectionState() {
    _getStoreProducts();
  }

  Future<void> _getStoreProducts() async {
    ApiService.fetchProducts().then((response) {
      final storeproductsData = productFromJson(response.data as String);
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
        getProductTitle(context),
        showNonSelectedStoreError(context),
      ],
    );
  }

  Expanded showNonSelectedStoreError(BuildContext context) {
    return Expanded(
      child: _products.isEmpty
          ? Center(
              child: Text("Сеть не выбрана",
                  style: Theme.of(context).textTheme.bodyText1))
          : _storeProductsList(context),
    );
  }

  Padding getProductTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 20),
      child: Text(
        "Цветы",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  //#region ProductList
  Widget _storeProductsList(context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        return buildProductItem(index, context);
      },
    );
  }

  Column buildProductItem(int index, BuildContext context) {
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
              margin: const EdgeInsets.only(
                  bottom: 20, right: 10, left: 10, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_products[index].picture == null)
                    Container(
                      width: 140,
                      height: 140,
                      color: Colors.black12,
                      child: const Icon(
                        Icons.image_outlined,
                        color: Colors.black38,
                        size: 50,
                      ),
                    )
                  else
                    ClipOval(
                      child: Image(
                        image: MemoryImage(
                          _products[index].picture!,
                        ),
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Container(
                    width: 140,
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      _products[index].name!,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: const Color.fromRGBO(55, 50, 52, 1),
                          ),
                    ),
                  ),
                  Text(
                    "${_products[index].cost} ₽",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  //#endregion

  //#region CountOfFlower
  Future<void> _showCountOfProductDialog(Product selectedProduct) async {
    int _count = 1;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(
              selectedProduct.name!,
              style: Theme.of(context).textTheme.headline6,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    "Количество: $_count шт.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(height: 2),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      trackShape: SliderShape(),
                    ),
                    child: Slider(
                      value: _count.toDouble(),
                      divisions: 20,
                      activeColor: const Color.fromRGBO(130, 147, 153, 1),
                      inactiveColor: const Color.fromRGBO(130, 147, 153, 130),
                      max: 20,
                      min: 1,
                      label: "$_count",
                      onChanged: (count) {
                        setState(() => _count = count.toInt());
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              getBackButton(context),
              getAddButton(_count, selectedProduct, context),
            ],
          );
        });
      },
    );
  }

  Container getAddButton(
      int _count, Product selectedProduct, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: TextButton(
        onPressed: () {
          if (_count != 0) {
            for (int i = 0; i < _count; i++) {
              BouquetMainMenuState.products.add(selectedProduct);
            }
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Цветок добавлен"),
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
        child: Text(
          "Сохранить",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: const Color.fromRGBO(130, 147, 153, 1),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Container getBackButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: TextButton(
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
    );
  }
  //#endregion
}
