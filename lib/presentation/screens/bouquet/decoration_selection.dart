import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/data/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bouquet_main.dart';

class DecorationSelection extends StatefulWidget {
  @override
  DecorationSelectionState createState() => DecorationSelectionState();
}

class DecorationSelectionState extends State<DecorationSelection> {
  List<Product> _products = [];

  DecorationSelectionState() {
    _getStoreProducts();
  }

  Future<void> _getStoreProducts() async {
    ApiService.fetchProducts().then((response) {
      final storeproductsData = productFromJson(response.data as String);
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
      child: _products.isEmpty
          ? Center(
              child: Text("Сеть не выбрана",
                  style: Theme.of(context).textTheme.bodyText1))
          : _storeProductsList(context),
    );
  }

  Padding getDecorationTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 20),
      child: Text(
        "Украшения",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _storeProductsList(context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  for (final item in BouquetMainMenuState.products) {
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
                          ? const Text("Украшение добавлены в букет")
                          : const Text("Цукрашение уже присутствует в букете"),
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
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
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
        });
  }
}
