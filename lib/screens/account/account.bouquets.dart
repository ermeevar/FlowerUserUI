import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flower_user_ui/models/user.dart';
import 'package:flower_user_ui/models/bouquet.dart';
import 'package:flower_user_ui/models/web.api.services.dart';

class AccountBouquets extends StatefulWidget {
  User _user;

  AccountBouquets(this._user);

  @override
  AccountBouquetsState createState() => AccountBouquetsState(_user);
}

class AccountBouquetsState extends State<AccountBouquets> {
  User _user;
  List<Bouquet> _bouquets = [];

  AccountBouquetsState(this._user) {
    _getBouquets();
  }

  _getBouquets() {
    WebApiServices.fetchBouquets().then((response) {
      var bouquetData = bouquetFromJson(response.data);
      setState(() {
        _bouquets =
            bouquetData.where((element) => element.userId == _user.id).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text("Мои букеты",
                      style: Theme.of(context).textTheme.subtitle),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              child: _bouquets.length == 0
                  ? Center(child: Text("У вас нет ни одного букета"))
                  : Padding(
                      padding: EdgeInsets.zero,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _bouquets.length,
                          itemBuilder: (context, index) {
                            return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                margin: EdgeInsets.only(
                                    top: 10, right: 10, left:20, bottom: 10),
                                color: Color.fromRGBO(130, 147, 153, 1),
                                elevation: 5,
                                child: Container(
                                  width: 200,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.zero,
                                        child: Text(_bouquets[index].name,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle
                                                .copyWith(color: Colors.white)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.zero,
                                        child: Text(
                                            _bouquets[index].cost.toString() +
                                                " " ,
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: OutlineButton(
                                          onPressed: () {},
                                          child: Text('Заказать',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .body2),
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          }),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
