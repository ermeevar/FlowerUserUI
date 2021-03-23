import 'package:flower_user_ui/models/template.category.dart';
import 'package:flutter/material.dart';

class TemplateCategorySelection extends StatefulWidget {
  TemplateCategorySelectionState createState() =>
      TemplateCategorySelectionState();
}

class TemplateCategorySelectionState extends State<TemplateCategorySelection> {
  List<TemplateCategory> _templateCategories=[];

  _getProducts() async {
    List<BouquetProduct> middleProducts;
    await WebApiServices.fetchBouquetProduct().then((response) {
      var bouquetProductsData = bouquetProductFromJson(response.data);
      middleProducts = bouquetProductsData
          .where((element) => element.bouquetId == OrderMainMenuState.order.bouquetId)
          .toList();
    });

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
