import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/domain/services/api_service.dart';
import 'package:flower_user_ui/domain/services/profile_service.dart';
import 'package:flower_user_ui/presentation/screens/order/bouquet_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flower_user_ui/internal/extensions/double_extensions.dart';

import '../navigation_menu.dart';

class AccountBouquets extends StatefulWidget {
  @override
  AccountBouquetsState createState() => AccountBouquetsState();
}

class AccountBouquetsState extends State<AccountBouquets> {
  List<Bouquet> _bouquets = [];

  AccountBouquetsState() {
    getBouquets();
  }

  Future<void> getBouquets() {
    return ApiService.fetchBouquets().then((response) {
      final bouquetData = bouquetFromJson(response.data as String);
      setState(() {
        _bouquets = bouquetData.reversed
            .where((element) => element.userId == ProfileService.user.id)
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: const Color.fromRGBO(110, 53, 76, 1),
      key: NavigationMenuState.refreshIndicatorKey,
      onRefresh: getBouquets,
      child: Column(
        children: [
          getBouquetTitle(context),
          Expanded(
            child: _bouquets.isEmpty
                ? getNullBouquetError()
                : Container(
                    padding: EdgeInsets.zero,
                    height: 200,
                    child: buildBouquetList(),
                  ),
          )
        ],
      ),
    );
  }

  ListView buildBouquetList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _bouquets.length,
      itemBuilder: (context, index) {
        return getItem(index, context);
      },
    );
  }

  //#region BouquetItem
  Card getItem(int index, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.only(top: 10, right: 10, left: 20, bottom: 10),
      color: const Color.fromRGBO(130, 147, 153, 1),
      elevation: 5,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getDeleteButton(index),
            getBouquetItemName(index, context),
            getBouquetItemCost(index, context),
            getBouquetItemOrder(context, index)
          ],
        ),
      ),
    );
  }

  Row getDeleteButton(int index) {
    return Row(
      children: [
        const Spacer(),
        SizedBox(
          height: 30,
          child: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () async {
              await ApiService.deleteBouquet(_bouquets[index].id);

              getBouquets();
            },
          ),
        ),
      ],
    );
  }

  Padding getBouquetItemOrder(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BouquetOrder(_bouquets[index]),
            ),
          );
        },
        child: Text('Заказать', style: Theme.of(context).textTheme.bodyText2),
        // : BorderSide(color: Colors.white),
      ),
    );
  }

  Padding getBouquetItemCost(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text("${_bouquets[index].cost!.roundDouble(2)} ₽",
          style: Theme.of(context).textTheme.bodyText1),
    );
  }

  Padding getBouquetItemName(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Text(
        _bouquets[index].name == null ? "" : _bouquets[index].name!,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              //fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
      ),
    );
  }
  //#endregion

  Center getNullBouquetError() =>
      const Center(child: Text("У вас нет ни одного букета"));

  Container getBouquetTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, bottom: 5),
      child: Row(
        children: [
          Text("Мои букеты", style: Theme.of(context).textTheme.subtitle1),
          const Spacer(),
        ],
      ),
    );
  }
}
