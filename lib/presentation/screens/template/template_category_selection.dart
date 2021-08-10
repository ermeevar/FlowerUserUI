import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/data/services/services.dart';
import 'package:flower_user_ui/presentation/screens/template/template_selection.dart';
import 'package:flutter/material.dart';

class TemplateCategorySelection extends StatefulWidget {
  @override
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
  Future<void> _getTemplateCategories() async {
    await ApiService.fetchTemplateCategories().then((response) {
      final templateCategoriesData =
          templateCategoryFromJson(response.data as String);
      setState(() {
        _templateCategories = templateCategoriesData;
      });
    });
  }

  Future<void> _getTemplates() async {
    await ApiService.fetchTemplates().then((response) {
      final templateData = templateFromJson(response.data as String);
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

  Container _header(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 30),
              padding: EdgeInsets.zero,
              color: const Color.fromRGBO(130, 147, 153, 1),
              onPressed: () {
                Navigator.pop(context);
              }),
          Text("Категории", style: Theme.of(context).textTheme.subtitle1)
        ],
      ),
    );
  }

  Expanded _createTemplateCategoriesListView(context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 10),
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
    return const Divider(
      color: Color.fromRGBO(130, 147, 153, 1),
      height: 1,
    );
  }

  Container getTemplateName(int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Text(
            _templateCategories[index].name!,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Spacer(),
          const Icon(
            Icons.navigate_next,
            color: Color.fromRGBO(130, 147, 153, 1),
          )
        ],
      ),
    );
  }

  Container getCircleCountTemplates(int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
      child: CircleAvatar(
        backgroundColor: const Color.fromRGBO(130, 147, 153, 1),
        radius: 25,
        child: Text(
          _getCountOfCategories(_templateCategories[index]).toString(),
          style: Theme.of(context).textTheme.bodyText2,
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
