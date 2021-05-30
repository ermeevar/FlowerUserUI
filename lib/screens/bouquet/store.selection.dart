import 'package:flower_user_ui/entities/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flower_user_ui/states/web.api.services.dart';
import 'bouquet.main.dart';

class StoreSelection extends StatefulWidget {
  @override
  StoreSelectionState createState() => StoreSelectionState();
}

class StoreSelectionState extends State<StoreSelection> {
  List<Store> _stores = [];

  StoreSelectionState() {
    _getStores();
  }

  _getStores() {
    WebApiServices.fetchStores().then((response) {
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
        getNameBouquet(context),
        getStoreTitle(context),
        _storesList(context),
      ],
    );
  }

  Padding getStoreTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Text(
        "Сети магазинов",
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }

  Padding getNameBouquet(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        onChanged: (name) {
          setState(() {
            BouquetMainMenuState.newBouquet.name = name;
          });
        },
        initialValue: BouquetMainMenuState.newBouquet.name != null
            ? BouquetMainMenuState.newBouquet.name
            : "",
        cursorColor: Color.fromRGBO(130, 147, 153, 1),
        style: Theme.of(context).textTheme.body1,
        decoration: InputDecoration(
          labelText: "Наименование букета",
          focusColor: Color.fromRGBO(130, 147, 153, 1),
        ),
      ),
    );
  }

  //#region StoreList
  Expanded _storesList(context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: _stores.length,
        itemBuilder: (context, index) {
          return buildStoreItem(index, context);
        },
      ),
    );
  }

  Column buildStoreItem(int index, BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 5,
          shape: CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: IconButton(
            iconSize: 120,
            padding: EdgeInsets.zero,
            icon: BouquetMainMenuState.newBouquet.storeId != null &&
                    BouquetMainMenuState.newBouquet.storeId == _stores[index].id
                ? getCheckIcon()
                : getStoreImage(index),
            onPressed: () {
              if (_stores[index].id == BouquetMainMenuState.newBouquet.storeId)
                setState(() {
                  BouquetMainMenuState.newBouquet.storeId = null;
                });
              else
                setState(() {
                  BouquetMainMenuState.newBouquet.storeId = _stores[index].id;
                });
            },
          ),
        ),
        getStoreName(index, context)
      ],
    );
  }

  Text getStoreName(int index, BuildContext context) {
    return Text(
      _stores[index].name.toString(),
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: Theme.of(context).textTheme.body1.copyWith(height: 2.5),
    );
  }

  CircleAvatar getStoreImage(int index) {
    return CircleAvatar(
        radius: 60,
        child: _stores[index].picture == null
            ? Icon(
                Icons.image_outlined,
                color: Colors.black38,
                size: 50,
              )
            : _stores[index].picture,
        backgroundColor: Colors.transparent);
  }

  Icon getCheckIcon() {
    return Icon(
      Icons.check,
      color: Color.fromRGBO(110, 53, 76, 1),
      size: 30,
    );
  }
  //#endregion
}
