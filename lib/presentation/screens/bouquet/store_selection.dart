import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/data/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bouquet_main.dart';

class StoreSelection extends StatefulWidget {
  @override
  StoreSelectionState createState() => StoreSelectionState();
}

class StoreSelectionState extends State<StoreSelection> {
  List<Store> _stores = [];

  StoreSelectionState() {
    _getStores();
  }

  Future<void> _getStores() async {
    ApiService.fetchStores().then((response) {
      final storesData = storeFromJson(response.data as String);
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
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        "Сети магазинов",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Padding getNameBouquet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        onChanged: (name) {
          setState(() {
            BouquetMainMenuState.newBouquet.name = name;
          });
        },
        initialValue: BouquetMainMenuState.newBouquet.name ?? "",
        cursorColor: const Color.fromRGBO(130, 147, 153, 1),
        style: Theme.of(context).textTheme.bodyText1,
        decoration: const InputDecoration(
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
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
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
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: IconButton(
            iconSize: 120,
            padding: EdgeInsets.zero,
            icon: BouquetMainMenuState.newBouquet.storeId != null &&
                    BouquetMainMenuState.newBouquet.storeId == _stores[index].id
                ? getCheckIcon()
                : getStoreImage(index),
            onPressed: () {
              if (_stores[index].id ==
                  BouquetMainMenuState.newBouquet.storeId) {
                setState(() {
                  BouquetMainMenuState.newBouquet.storeId = null;
                });
              } else {
                setState(() {
                  BouquetMainMenuState.newBouquet.storeId = _stores[index].id;
                });
              }
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
      style: Theme.of(context).textTheme.bodyText1!.copyWith(height: 2.5),
    );
  }

  CircleAvatar getStoreImage(int index) {
    return CircleAvatar(
        radius: 60,
        backgroundColor: Colors.transparent,
        child: _stores[index].picture == null
            ? const Icon(
                Icons.image_outlined,
                color: Colors.black38,
                size: 50,
              )
            : ClipOval(
                child: Image(
                  image: MemoryImage(_stores[index].picture!),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ));
  }

  Icon getCheckIcon() {
    return const Icon(
      Icons.check,
      color: Color.fromRGBO(110, 53, 76, 1),
      size: 30,
    );
  }
  //#endregion
}
