import 'package:flower_user_ui/models/user.dart';
import 'package:flower_user_ui/screens/bouquet/store.selection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';

class BouquetMainMenu extends StatefulWidget {
  User _user;

  BouquetMainMenu(this._user);

  @override
  BouquetMainMenuState createState() => BouquetMainMenuState(_user);
}

class BouquetMainMenuState extends State<BouquetMainMenu> {
  User _user;
  int _countOfPages = 4;
  int _stepIndex = 0;
  String swipeDirection ="";
  List<Widget> _pages = [];

  BouquetMainMenuState(this._user){
    _pages=[
      StoreSelection(_user),
      Container(height: 100, width: 100, color: Colors.amber),
      Container(height: 100, width: 100, color: Colors.red),
      Container(height: 100, width: 100, color: Colors.green),
    ];
  }

  addStepIndex() {
    if(_stepIndex>=_countOfPages-1) return;
    setState(() {
      _stepIndex++;
    });
  }

  removeStepIndex() {
    if(_stepIndex<=0) return;
    setState(() {
      _stepIndex--;
    });
  }

  Widget getStep(){
    return _pages[_stepIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(130, 147, 153, 1),
        child: Icon(Icons.list),
      ),
      body: Container(
          color: Colors.white,
          child: Column(
            children: [
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
                      color: Colors.white
                  ),
                  indicatorDecoration: IndicatorDecoration(
                      color: Color.fromRGBO(130, 147, 153, 1),
                      strokeColor: Color.fromRGBO(130, 147, 153, 1)
                  ),
                ),
              ),
              Expanded(child: GestureDetector(
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
                Navigator.pop(context);
              }),
          Text("Создание букета", style: Theme.of(context).textTheme.subtitle)
        ],
      ),
    );
  }
}
