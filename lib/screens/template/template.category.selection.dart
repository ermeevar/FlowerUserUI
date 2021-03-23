import 'package:flower_user_ui/models/template.category.dart';
import 'package:flower_user_ui/models/template.dart';
import 'package:flower_user_ui/models/web.api.services.dart';
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

  _getTemplateCategories() async {
    await WebApiServices.fetchTemplateCategory().then((response) {
      var templateCategoriesData = templateCategoryFromJson(response.data);
      setState(() {
        _templateCategories = templateCategoriesData;
      });
    });
  }

  _getTemplates() async {
    await WebApiServices.fetchTemplate().then((response) {
      var templateData = templateFromJson(response.data);
      setState(() {
        _templates = templateData;
      });
    });
  }

  int _getCountOfCategories(TemplateCategory templateCategory) {
    return _templates
        .where((element) => element.templateCategoryId == templateCategory.id)
        .toList()
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: _header(context),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: _createTemplateCategoriesListView(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _header(context) {
    return Row(
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
    );
  }

  Widget _createTemplateCategoriesListView(context) {
    return ListView.builder(
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
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(130, 147, 153, 1),
                  radius: 25,
                  child: Text(
                    _getCountOfCategories(_templateCategories[index]) != null
                        ? _getCountOfCategories(_templateCategories[index])
                            .toString()
                        : "0",
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  Container(
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
                  ),
                  Divider(
                    color: Color.fromRGBO(130, 147, 153, 1),
                    height: 1,
                  ),
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}
