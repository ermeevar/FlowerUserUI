import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/internal/utils/nullContainer.dart';
import 'package:flower_user_ui/internal/utils/web.api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatefulWidget {
  final int bouquetId;

  ProductsList(this.bouquetId) {}

  @override
  ProductsListState createState() => ProductsListState(this.bouquetId);
}

class ProductsListState extends State<ProductsList> {
  List<Product> _products = [];
  int bouquetId;

  ProductsListState(this.bouquetId) {
    _getProducts();
  }

  _getProducts() async {
    List<BouquetProduct> middleProducts;
    await WebApiServices.fetchBouquetProducts().then((response) {
      var bouquetProductsData = bouquetProductFromJson(response.data);
      middleProducts = bouquetProductsData
          .where((element) => element.bouquetId == bouquetId)
          .toList();
    });

    await WebApiServices.fetchProducts().then((response) {
      var productsData = productFromJson(response.data);
      setState(() {
        _products = productsData
            .where((element) =>
                middleProducts.any((bp) => bp.productId == element.id))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      height: 260,
      clipBehavior: Clip.none,
      color: Color.fromRGBO(110, 53, 76, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTitle(context),
          getProductList(),
        ],
      ),
    );
  }

  Expanded getProductList() {
    return Expanded(
      child: _products.length != 0
          ? Padding(
              padding: EdgeInsets.zero,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    return getValue(index, context);
                  }),
            )
          : nullContainer(),
    );
  }

  Card getValue(int index, BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10, right: 10, left: 20, bottom: 10),
      elevation: 5,
      color: Color.fromRGBO(55, 50, 52, 1),
      child: _products[index].picture == null
          ? Container(
              width: 140,
              child: Icon(
                Icons.image_outlined,
                color: Colors.white,
                size: 50,
              ),
              color: Colors.black12,
            )
          : Image(
              image: MemoryImage(
                _products[index].picture,
              ),
              width: 140,
              fit: BoxFit.cover,
            ),
    );
  }

  Container getTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
      child: Row(
        children: [
          Text(
            "Состав букета",
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Colors.white),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
