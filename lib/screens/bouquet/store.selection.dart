import 'package:flower_user_ui/models/user.dart';
import 'package:flower_user_ui/models/store.dart';
import 'package:flower_user_ui/models/bouquet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flower_user_ui/models/web.api.services.dart';

class StoreSelection extends StatefulWidget {
  User _user;

  StoreSelection(this._user);

  @override
  StoreSelectionState createState() => StoreSelectionState(_user);
}

class StoreSelectionState extends State<StoreSelection> {
  User _user;
  Bouquet _bouquet = Bouquet();
  List<Store> _stores = [];

  StoreSelectionState(this._user) {
    _getStores();
  }

  _getStores() {
    WebApiServices.fetchStore().then((response) {
      var storesData = storeFromJson(response.data);
      setState(() {
        _stores = storesData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: TextFormField(
              onChanged: (name) {
                setState(() {
                  this._bouquet.name = name;
                });
              },
              cursorColor: Color.fromRGBO(130, 147, 153, 1),
              style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(
                labelText: "Наименование букета",
                focusColor: Color.fromRGBO(130, 147, 153, 1),
              )),
        ),
        Expanded(
          child: _storesList(context),
        ),
      ],
    );
  }

  Widget _storesList(context) {
    return GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: _stores.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                elevation: 10,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(_stores[index].picture == null
                        ? "https://simple-fauna.ru/wp-content/uploads/2018/10/kvokka.jpg"
                        : _stores[index].picture),
                    backgroundColor: Colors.transparent),
              ),
              Text(
                _stores[index].name.toString(),
                style: Theme.of(context).textTheme.body1,
              )
            ],
          );
        });
  }
}
