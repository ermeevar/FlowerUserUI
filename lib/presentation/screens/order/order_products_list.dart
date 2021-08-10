import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/domain/services/services.dart';
import 'package:flower_user_ui/presentation/common_widgets/null_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatefulWidget {
  final int? bouquetId;

  const ProductsList(this.bouquetId);

  @override
  ProductsListState createState() => ProductsListState();
}

class ProductsListState extends State<ProductsList> {
  List<Product> _products = [];
  late int? bouquetId;

  ProductsListState() {
    bouquetId = widget.bouquetId;
    _getProducts();
  }

  Future<void> _getProducts() async {
    late List<BouquetProduct> middleProducts;
    await ApiService.fetchBouquetProducts().then((response) {
      final bouquetProductsData =
          bouquetProductFromJson(response.data as String);
      middleProducts = bouquetProductsData
          .where((element) => element.bouquetId == bouquetId)
          .toList();
    });

    await ApiService.fetchProducts().then((response) {
      final productsData = productFromJson(response.data as String);
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
      padding: const EdgeInsets.only(bottom: 10),
      height: 260,
      color: const Color.fromRGBO(110, 53, 76, 1),
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
      child: _products.isNotEmpty
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
      margin: const EdgeInsets.only(top: 10, right: 10, left: 20, bottom: 10),
      elevation: 5,
      color: const Color.fromRGBO(55, 50, 52, 1),
      child: _products[index].picture == null
          ? Container(
              width: 140,
              color: Colors.black12,
              child: const Icon(
                Icons.image_outlined,
                color: Colors.white,
                size: 50,
              ),
            )
          : Image(
              image: MemoryImage(
                _products[index].picture!,
              ),
              width: 140,
              fit: BoxFit.cover,
            ),
    );
  }

  Container getTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
      child: Row(
        children: [
          Text(
            "Состав букета",
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
