import 'package:flower_user_ui/entities/template.category.dart';
import 'package:flower_user_ui/entities/template.dart';
import 'package:flower_user_ui/states/web.api.services.dart';
import 'package:flower_user_ui/screens/template/template.selection.dart';
import 'package:flutter/material.dart';

class TemplateCategorySelection extends StatefulWidget {
  TemplateCategorySelectionState createState() =>
      TemplateCategorySelectionState();
}

class TemplateCategorySelectionState extends State<TemplateCategorySelection> {
  List<TemplateCategory> _templateCategories = [];
  List<Template> _templates = [];

  TemplateCategorySelectionState() {
    _getTemplateCategories();
    _getTemplates();
  }

  //#region GetData
  _getTemplateCategories() async {
    await WebApiServices.fetchTemplateCategories().then((response) {
      var templateCategoriesData = templateCategoryFromJson(response.data);
      setState(() {
        _templateCategories = templateCategoriesData;
      });
    });
  }

  _getTemplates() async {
    await WebApiServices.fetchTemplates().then((response) {
      var templateData = templateFromJson(response.data);
      setState(() {
        _templates = templateData;
      });
    });
  }
  //#endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context),
            _createTemplateCategoriesListView(context),
          ],
        ),
      ),
    );
  }

  Container _header(context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 30),
              padding: EdgeInsets.zero,
              color: Color.fromRGBO(130, 147, 153, 1),
              onPressed: () {
                Navigator.pop(context);
              }),
          Text("Категории", style: Theme.of(context).textTheme.subtitle)
        ],
      ),
    );
  }

  Expanded _createTemplateCategoriesListView(context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: _templateCategories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TemplateSelection(_templateCategories[index])));
              },
              child: buildTemplateCategoryItem(index, context),
            );
          },
        ),
      ),
    );
  }

  //#region TemplateItem
  Row buildTemplateCategoryItem(int index, BuildContext context) {
    return Row(
      children: [
        getCircleCountTemplates(index, context),
        Expanded(
          child: Column(
            children: [
              getTemplateName(index, context),
              getDivider(),
            ],
          ),
        )
      ],
    );
  }

  Divider getDivider() {
    return Divider(
      color: Color.fromRGBO(130, 147, 153, 1),
      height: 1,
    );
  }

  Container getTemplateName(int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Text(
            _templateCategories[index].name,
            style: Theme.of(context).textTheme.body1,
          ),
          Spacer(),
          Icon(
            Icons.navigate_next,
            color: Color.fromRGBO(130, 147, 153, 1),
          )
        ],
      ),
    );
  }

  Container getCircleCountTemplates(int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
      child: CircleAvatar(
        backgroundColor: Color.fromRGBO(130, 147, 153, 1),
        radius: 25,
        child: Text(
          _getCountOfCategories(_templateCategories[index]) != null
              ? _getCountOfCategories(_templateCategories[index]).toString()
              : "0",
          style: Theme.of(context).textTheme.body2,
        ),
      ),
    );
  }

  int _getCountOfCategories(TemplateCategory templateCategory) {
    return _templates
        .where((element) => element.templateCategoryId == templateCategory.id)
        .toList()
        .length;
  }
  //#endregion
}
