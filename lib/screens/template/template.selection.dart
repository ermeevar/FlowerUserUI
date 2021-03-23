import 'package:flower_user_ui/models/template.category.dart';
import 'package:flower_user_ui/models/template.dart';
import 'package:flower_user_ui/models/web.api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TemplateSelection extends StatefulWidget {
  TemplateCategory _templateCategory;
  TemplateSelection(this._templateCategory) {}

  @override
  TemplateSelectionState createState() =>
      TemplateSelectionState(_templateCategory);
}

class TemplateSelectionState extends State<TemplateSelection> {
  TemplateCategory _templateCategory;
  List<Template> _templates = [];

  TemplateSelectionState(this._templateCategory) {
    _getTemplates();
  }

  _getTemplates() async {
    await WebApiServices.fetchTemplate().then((response) {
      var templateData = templateFromJson(response.data);
      setState(() {
        _templates = templateData
            .where(
                (element) => element.templateCategoryId == _templateCategory.id)
            .toList();
      });
    });
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
                child: _createTemplatesListView(context),
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
        Text("Шаблоны", style: Theme.of(context).textTheme.subtitle)
      ],
    );
  }

  Widget _createTemplatesListView(context) {
    return GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: _templates.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(
                child: Card(
                  elevation: 10,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: 20, right: 10, left: 10, top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _templates[index].picture == null
                            ? Container(
                          width: 140,
                          height: 140,
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.black38,
                            size: 50,
                          ),
                          color: Colors.black12,
                        )
                            : _templates[index].picture,
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            _templates[index].name,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style:
                            Theme.of(context).textTheme.subtitle.copyWith(
                              color: Color.fromRGBO(55, 50, 52, 1),
                            ),
                          ),
                        ),
                        Text(
                          _templates[index].cost.toString() + " ₽",
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
