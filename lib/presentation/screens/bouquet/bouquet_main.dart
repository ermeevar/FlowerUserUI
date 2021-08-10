import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/data/services/services.dart';
import 'package:flower_user_ui/internal/extensions/double_extensions.dart';
import 'package:flower_user_ui/presentation/screens/bouquet/store_selection.dart';
import 'package:flower_user_ui/presentation/screens/navigation_menu.dart';
import 'package:flower_user_ui/presentation/screens/order/bouquet_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'decoration_selection.dart';
import 'flower_selection.dart';
import 'grass_selection.dart';

class BouquetMainMenu extends StatefulWidget {
  @override
  BouquetMainMenuState createState() => BouquetMainMenuState();
}

class BouquetMainMenuState extends State<BouquetMainMenu> {
  final int _countOfPages = 4;
  int _stepIndex = 0;
  String swipeDirection = "";
  static Bouquet newBouquet = Bouquet();
  static List<Product> products = [];
  static List<Widget> _pages = [];

  BouquetMainMenuState() {
    _pages = [
      StoreSelection(),
      FlowerSelection(),
      GrassSelection(),
      DecorationSelection(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: showBouquetInfo(),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _header(context),
            buildDoteStepper(),
            swipeController(),
          ],
        ),
      ),
    );
  }

  //#region NavigationController
  //#region IndexController
  void addStepIndex() {
    if (_stepIndex >= _countOfPages - 1) return;
    setState(() {
      _stepIndex++;
    });
  }

  void removeStepIndex() {
    if (_stepIndex <= 0) return;
    setState(() {
      _stepIndex--;
    });
  }

  Widget getStep() {
    return _pages[_stepIndex];
  }
  //#endregion

  Expanded swipeController() {
    return Expanded(
      child: GestureDetector(
        onPanUpdate: (details) {
          swipeDirection = details.delta.dx < 0 ? 'left' : 'right';
        },
        onPanEnd: (details) {
          if (swipeDirection == 'left') {
            addStepIndex();
          }
          if (swipeDirection == 'right') {
            removeStepIndex();
          }
        },
        child: getStep(),
      ),
    );
  }
  //#endregion

  Container buildDoteStepper() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: DotStepper(
        dotCount: _countOfPages,
        dotRadius: 6,
        activeStep: _stepIndex,
        spacing: 7,
        indicator: Indicator.worm,
        onDotTapped: (tappedDotIndex) {
          setState(() {
            _stepIndex = tappedDotIndex;
          });
        },
        fixedDotDecoration: const FixedDotDecoration(
            strokeWidth: 1,
            strokeColor: Color.fromRGBO(130, 147, 153, 1),
            color: Colors.white),
        indicatorDecoration: const IndicatorDecoration(
          color: Color.fromRGBO(130, 147, 153, 1),
          strokeColor: Color.fromRGBO(130, 147, 153, 1),
        ),
      ),
    );
  }

  FloatingActionButton showBouquetInfo() {
    return FloatingActionButton(
      onPressed: () => _showBouquetInformation(),
      backgroundColor: const Color.fromRGBO(130, 147, 153, 1),
      child: const Icon(Icons.list),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 30),
            padding: EdgeInsets.zero,
            color: const Color.fromRGBO(130, 147, 153, 1),
            onPressed: () {
              newBouquet = Bouquet();
              products = [];
              Navigator.pop(context);
            },
          ),
          Text(
            "Создание букета",
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }

  //#region BouquetInfo
  Future<void> _showBouquetInformation() {
    double bouquetCost = 0;
    for (final item in products) {
      bouquetCost += item.cost!;
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: getBouquetName(context),
          content: products.isEmpty
              ? showNullSelectedFlowerError(context)
              : StatefulBuilder(builder: (context, setState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCommonCost(bouquetCost, context),
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getSelectedFlowerName(index, context),
                                getSelectedFlowerCost(index, context),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  padding: EdgeInsets.zero,
                                  color: const Color.fromRGBO(130, 147, 153, 1),
                                  onPressed: () {
                                    setState(
                                      () {
                                        bouquetCost = 0;
                                        products.remove(products[index]);
                                        if (products.isNotEmpty) {
                                          for (final Product item in products) {
                                            bouquetCost += item.cost!;
                                          }
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getSaveTemplateButton(context, bouquetCost),
                getOrderButton(context, bouquetCost),
                getBackButton(context),
              ],
            ),
          ],
        );
      },
    );
  }

  SizedBox getSaveTemplateButton(BuildContext context, double bouquetCost) {
    return SizedBox(
      width: 80,
      child: IconButton(
        icon: const Icon(
          Icons.save_alt,
          color: Color.fromRGBO(130, 147, 153, 1),
        ),
        onPressed: () async {
          if (newBouquet.storeId == null ||
              products
                  .where((element) => element.productCategoryId == 1)
                  .isEmpty ||
              newBouquet.name == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Букет не собран"),
                action: SnackBarAction(
                  label: "Понятно",
                  onPressed: () {
                    // Code to execute.
                  },
                ),
              ),
            );
          }

          await postBouquet(bouquetCost);

          newBouquet = Bouquet();
          products = [];

          showTopSnackBar(
            context,
            const CustomSnackBar.info(
              backgroundColor: Color.fromRGBO(110, 53, 76, 1),
              message: "Шаблон сохранен",
            ),
          );

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => NavigationMenu(),
              ),
              (Route<dynamic> route) => false);
        },
      ),
    );
  }

  //#region ButtonsOfBouquetInfo
  Widget getBackButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        "Назад",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: const Color.fromRGBO(130, 147, 153, 1),
            ),
      ),
    );
  }

  Widget getOrderButton(BuildContext context, double bouquetCost) {
    return TextButton(
      onPressed: () async {
        if (newBouquet.storeId == null ||
            products
                .where((element) => element.productCategoryId == 1)
                .isEmpty ||
            newBouquet.name == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Букет не собран"),
              action: SnackBarAction(
                label: "Понятно",
                onPressed: () {
                  // Code to execute.
                },
              ),
            ),
          );
        } else {
          final Bouquet? postedBouquet = await postBouquet(bouquetCost);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => BouquetOrder(postedBouquet),
              ),
              (Route<dynamic> route) => false);
        }
      },
      child: Text(
        "Заказать",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: const Color.fromRGBO(130, 147, 153, 1),
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Future<Bouquet?> postBouquet(double bouquetCost) async {
    newBouquet.cost = bouquetCost;
    newBouquet.userId = ProfileService.user.id;

    await ApiService.postBouquet(BouquetMainMenuState.newBouquet);

    Bouquet? postedBouquet;
    await ApiService.fetchBouquets().then((response) {
      final bouquetsData = bouquetFromJson(response.data as String);
      postedBouquet = bouquetsData.last;
    });

    for (final item in BouquetMainMenuState.products) {
      final BouquetProduct middleBouquetProduct = BouquetProduct();
      middleBouquetProduct.bouquetId = postedBouquet!.id;
      middleBouquetProduct.productId = item.id;
      await ApiService.postBouquetProduct(middleBouquetProduct);
    }

    return postedBouquet;
  }
  //#endregion

  //#region SelectedProductInfo
  Text getSelectedFlowerCost(int index, BuildContext context) {
    return Text("${products[index].cost!.roundDouble(2)} ₽",
        style: Theme.of(context).textTheme.bodyText1);
  }

  Widget getSelectedFlowerName(int index, BuildContext context) {
    return SizedBox(
      width: 150,
      child: Text(products[index].name!,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: Theme.of(context).textTheme.bodyText1),
    );
  }

  Text getCommonCost(double bouquetCost, BuildContext context) {
    return Text(
      "${bouquetCost.roundDouble(1)} ₽",
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: const Color.fromRGBO(130, 147, 153, 1), fontSize: 25),
    );
  }
  //#endregion
  //endregion

  Center showNullSelectedFlowerError(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        child: Text(
          "Цветы не выбраны",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
        ),
      ),
    );
  }

  Widget getBouquetName(BuildContext context) {
    return Text(
      newBouquet.name != null ? newBouquet.name! : "Пустое название",
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
