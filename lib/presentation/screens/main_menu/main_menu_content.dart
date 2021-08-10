import 'package:flower_user_ui/domain/services/services.dart';
import 'package:flower_user_ui/presentation/common_widgets/slider_shape.dart';
import 'package:flower_user_ui/presentation/screens/bouquet/bouquet_main.dart';
import 'package:flower_user_ui/presentation/screens/order/random_bouquet_order.dart';
import 'package:flower_user_ui/presentation/screens/template/template_category_selection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flower_user_ui/internal/extensions/double_extensions.dart';

class MainMenuContent extends StatelessWidget {
  MainMenuContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _accountInfo(context),
          _bouquetCards(context),
          navigationBarOverSpace()
        ],
      ),
    );
  }

  Container navigationBarOverSpace() {
    return Container(
      height: 10,
    );
  }

  Widget _accountInfo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Row(
            children: [
              Text(ProfileService.account!.login!,
                  style: Theme.of(context).textTheme.bodyText2),
              Padding(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: ProfileService.user.picture == null
                      ? Icon(
                          Icons.supervisor_account_outlined,
                          color: Colors.black38,
                          size: 20,
                        )
                      : ClipOval(
                          child: Image(
                            image: MemoryImage(ProfileService.user.picture),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //#region Cards
  Widget _bouquetCards(context) {
    return Container(
      padding: EdgeInsets.zero,
      height: 335,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          buildBouquetCard(context),
          buildTemplateCard(context),
          buildRandomCard(context),
        ],
      ),
    );
  }

  Container buildRandomCard(context) {
    return Container(
      margin: EdgeInsets.only(left: 30),
      height: 300,
      width: 230,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white54,
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child:
                  Icon(Icons.add_shopping_cart, color: Colors.white, size: 60),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("Случайный букет",
                  style: Theme.of(context).textTheme.subtitle1),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: OutlinedButton(
                onPressed: () {
                  _showCountOfProductDialog(context);
                },
                child: Text('Заказать',
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildTemplateCard(context) {
    return Container(
      margin: EdgeInsets.only(left: 30),
      height: 300,
      width: 230,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white54,
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.image_outlined, color: Colors.white, size: 60),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("Букет по шаблону",
                  style: Theme.of(context).textTheme.subtitle1),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: OutlinedButton(
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TemplateCategorySelection()));
                },
                child: Text('Выбрать',
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildBouquetCard(context) {
    return Container(
      margin: EdgeInsets.only(left: 30),
      height: 300,
      width: 230,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white54,
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.add, color: Colors.white, size: 60),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("Новый букет",
                  style: Theme.of(context).textTheme.headline6),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BouquetMainMenu()));
                },
                child: Text('Создать',
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showCountOfProductDialog(context) async {
    double _cost = 300;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                "Выбор ценовой категории",
                style: Theme.of(context).textTheme.headline6,
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      "Цена:" + _cost.roundDouble(2).toString() + " ₽",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(height: 2),
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        trackShape: SliderShape(),
                      ),
                      child: Slider(
                        value: _cost,
                        divisions: 97,
                        activeColor: Color.fromRGBO(130, 147, 153, 1),
                        inactiveColor: Color.fromRGBO(130, 147, 153, 130),
                        max: 10000,
                        min: 300,
                        label: _cost.roundDouble(2).toString(),
                        onChanged: (cost) {
                          setState(() => _cost = cost);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text(
                      "Назад",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Color.fromRGBO(130, 147, 153, 1),
                          ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RandomBouquetOrder(_cost)));
                      Navigator.pop(context);
                    },
                    child: new Text(
                      "Заказать",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Color.fromRGBO(130, 147, 153, 1),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
  //#endregion
}
