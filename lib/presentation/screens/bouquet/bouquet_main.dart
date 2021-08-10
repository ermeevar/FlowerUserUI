import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/domain/services/services.dart';
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
import 'package:flower_user_ui/internal/extensions/double_extensions.dart';

class BouquetMainMenu extends StatefulWidget {
  @override
  BouquetMainMenuState createState() => BouquetMainMenuState();
}

class BouquetMainMenuState extends State<BouquetMainMenu> {
  int _countOfPages = 4;
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
  addStepIndex() {
    if (_stepIndex >= _countOfPages - 1) return;
    setState(() {
      _stepIndex++;
    });
  }

  removeStepIndex() {
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
        child: getStep(),
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
      ),
    );
  }
  //#endregion

  Container buildDoteStepper() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: DotStepper(
        dotCount: _countOfPages,
        dotRadius: 6,
        activeStep: _stepIndex,
        shape: Shape.circle,
        spacing: 7,
        indicator: Indicator.worm,
        onDotTapped: (tappedDotIndex) {
          setState(() {
            _stepIndex = tappedDotIndex;
          });
        },
        fixedDotDecoration: FixedDotDecoration(
            strokeWidth: 1,
            strokeColor: Color.fromRGBO(130, 147, 153, 1),
            color: Colors.white),
        indicatorDecoration: IndicatorDecoration(
          color: Color.fromRGBO(130, 147, 153, 1),
          strokeColor: Color.fromRGBO(130, 147, 153, 1),
        ),
      ),
    );
  }

  FloatingActionButton showBouquetInfo() {
    return FloatingActionButton(
      onPressed: () => _showBouquetInformation(),
      backgroundColor: Color.fromRGBO(130, 147, 153, 1),
      child: Icon(Icons.list),
    );
  }

  Widget _header(context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 30),
            padding: EdgeInsets.zero,
            color: Color.fromRGBO(130, 147, 153, 1),
            onPressed: () {
              newBouquet = new Bouquet();
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
    for (var item in products) {
      bouquetCost += item.cost;
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: getBouquetName(context),
          content: products.length == 0
              ? showNullSelectedFlowerError(context)
              : StatefulBuilder(builder: (context, setState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCommonCost(bouquetCost, context),
                      Container(
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
                                  icon: Icon(
                                    Icons.delete_outline,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  padding: EdgeInsets.zero,
                                  color: Color.fromRGBO(130, 147, 153, 1),
                                  onPressed: () {
                                    setState(
                                      () {
                                        bouquetCost = 0;
                                        products.remove(products[index]);
                                        if (products.length != 0)
                                          for (var item in products) {
                                            bouquetCost += item.cost;
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
        icon: Icon(
          Icons.save_alt,
          color: Color.fromRGBO(130, 147, 153, 1),
        ),
        onPressed: () async {
          if (newBouquet.storeId == null ||
              products
                      .where((element) => element.productCategoryId == 1)
                      .length ==
                  0 ||
              newBouquet.name == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Букет не собран"),
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

          newBouquet = new Bouquet();
          products = [];

          showTopSnackBar(
            context,
            CustomSnackBar.info(
              icon: null,
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
  Container getBackButton(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(10),
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
    );
  }

  Container getOrderButton(BuildContext context, double bouquetCost) {
    return Container(
      child: TextButton(
        onPressed: () async {
          if (newBouquet.storeId == null ||
              products
                      .where((element) => element.productCategoryId == 1)
                      .length ==
                  0 ||
              newBouquet.name == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Букет не собран"),
                action: SnackBarAction(
                  label: "Понятно",
                  onPressed: () {
                    // Code to execute.
                  },
                ),
              ),
            );
          } else {
            Bouquet postedBouquet = await postBouquet(bouquetCost);

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => BouquetOrder(postedBouquet),
                ),
                (Route<dynamic> route) => false);
          }
        },
        child: new Text(
          "Заказать",
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Color.fromRGBO(130, 147, 153, 1),
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  Future<Bouquet> postBouquet(double bouquetCost) async {
    newBouquet.cost = bouquetCost;
    newBouquet.userId = ProfileService.user.id;

    await ApiService.postBouquet(BouquetMainMenuState.newBouquet);

    Bouquet postedBouquet;
    await ApiService.fetchBouquets().then((response) {
      var bouquetsData = bouquetFromJson(response.data);
      postedBouquet = bouquetsData.last;
    });

    for (var item in BouquetMainMenuState.products) {
      BouquetProduct middleBouquetProduct = BouquetProduct();
      middleBouquetProduct.bouquetId = postedBouquet.id;
      middleBouquetProduct.productId = item.id;
      await ApiService.postBouquetProduct(middleBouquetProduct);
    }

    return postedBouquet;
  }
  //#endregion

  //#region SelectedProductInfo
  Text getSelectedFlowerCost(int index, BuildContext context) {
    return Text(products[index].cost.roundDouble(2).toString() + " ₽",
        style: Theme.of(context).textTheme.bodyText1);
  }

  Container getSelectedFlowerName(int index, BuildContext context) {
    return Container(
      width: 150,
      child: Text(products[index].name,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: Theme.of(context).textTheme.bodyText1),
    );
  }

  Text getCommonCost(double bouquetCost, BuildContext context) {
    return Text(
      bouquetCost.roundDouble(1).toString() + " ₽",
      style: Theme.of(context)
          .textTheme
          .bodyText1
          .copyWith(color: Color.fromRGBO(130, 147, 153, 1), fontSize: 25),
    );
  }
  //#endregion
  //endregion

  Center showNullSelectedFlowerError(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(10),
        color: Colors.white,
        child: Text(
          "Цветы не выбраны",
          style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 15),
        ),
      ),
    );
  }

  Container getBouquetName(BuildContext context) {
    return Container(
      child: Text(
        newBouquet.name != null ? newBouquet.name : "Пустое название",
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
