import 'package:flower_user_ui/entities/template.category.dart';
import 'package:flower_user_ui/entities/template.dart';
import 'package:flower_user_ui/screens/order/template.bouquet.order.dart';
import 'package:flower_user_ui/states/calc.dart';
import 'package:flower_user_ui/states/web.api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TemplateSelection extends StatefulWidget {
  final TemplateCategory _templateCategory;
  TemplateSelection(this._templateCategory);

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
    await WebApiServices.fetchTemplates().then((response) {
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
            _header(context),
            _createTemplatesListView(context),
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
            },
          ),
          Text("Шаблоны", style: Theme.of(context).textTheme.subtitle1)
        ],
      ),
    );
  }

  Expanded _createTemplatesListView(context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: _templates.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) =>
                              TemplateBouquetOrder(_templates[index]),
                        ),
                        (Route<dynamic> route) => false);
                  },
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
                              : ClipOval(
                                  child: Image(
                                    image: MemoryImage(
                                      _templates[index].picture,
                                    ),
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          Container(
                            width: 140,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              _templates[index].name,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    color: Color.fromRGBO(55, 50, 52, 1),
                                  ),
                            ),
                          ),
                          Text(
                            Calc.roundDouble(_templates[index].cost, 2)
                                    .toString() +
                                " ₽",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
