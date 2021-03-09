import 'package:flower_user_ui/models/bouquet.dart';
import 'package:flower_user_ui/models/store.product.dart';
import 'package:flower_user_ui/screens/bouquet/flower.selection.dart';
import 'package:flower_user_ui/screens/bouquet/store.selection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

class BouquetMainMenu extends StatefulWidget {
  @override
  BouquetMainMenuState createState() => BouquetMainMenuState();
}

class BouquetMainMenuState extends State<BouquetMainMenu> {
  int _countOfPages = 4;
  int _stepIndex = 0;
  String swipeDirection = "";
  static Bouquet newBouquet = new Bouquet();
  static List<StoreProduct> products = [];
  static List<Widget> _pages = [];

  BouquetMainMenuState() {
    _pages = [
      StoreSelection(),
      FlowerSelection(),
      Container(height: 100, width: 100, color: Colors.red),
      Container(height: 100, width: 100, color: Colors.green),
    ];
  }

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

  removeProduct(product) {
    setState(() {
      products.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showBouquetInformation(),
          backgroundColor: Color.fromRGBO(130, 147, 153, 1),
          child: Icon(Icons.list),
        ),
        body: Container(
            color: Colors.white,
            child: Column(children: [
              _header(context),
              Container(
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
                      strokeColor: Color.fromRGBO(130, 147, 153, 1)),
                ),
              ),
              Expanded(
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
              ))
            ])));
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
                // ignore: deprecated_member_use
                products = new List<StoreProduct>();
                Navigator.pop(context);
              }),
          Text("Создание букета", style: Theme.of(context).textTheme.subtitle)
        ],
      ),
    );
  }

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
          title: Text(
            newBouquet.name != null ? newBouquet.name : "Пустое название",
            style: Theme.of(context).textTheme.subtitle,
          ),
          content: products.length == 0
              ? Center(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Text("Цветы не выбраны",
                        style: Theme.of(context)
                            .textTheme
                            .body1
                            .copyWith(fontSize: 15)),
                  ),
                )
              : StatefulBuilder(builder: (context, setState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bouquetCost.toString() + " ₽",
                        style: Theme.of(context).textTheme.body1.copyWith(
                            color: Color.fromRGBO(130, 147, 153, 1),
                            fontSize: 25),
                      ),
                      Container(
                        width: 300,
                        height: 300,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(products[index].name,
                                      style: Theme.of(context).textTheme.body1),
                                  Text(products[index].cost.toString() + " ₽",
                                      style: Theme.of(context).textTheme.body1),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete_outline,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                      padding: EdgeInsets.zero,
                                      color: Color.fromRGBO(130, 147, 153, 1),
                                      onPressed: () {
                                        setState(() {
                                          bouquetCost = 0;
                                          products.remove(products[index]);
                                          if (products.length != 0)
                                            for (var item in products) {
                                              bouquetCost += item.cost;
                                            }
                                        });
                                      }),
                                ],
                              );
                            }),
                      )
                    ],
                  );
                }),
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
          ],
        );
      },
    );
  }
}
