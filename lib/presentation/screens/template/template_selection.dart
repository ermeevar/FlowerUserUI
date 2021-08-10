import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/data/services/services.dart';
import 'package:flower_user_ui/presentation/screens/order/template_bouquet_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flower_user_ui/internal/extensions/double_extensions.dart';

class TemplateSelection extends StatefulWidget {
  final TemplateCategory _templateCategory;
  const TemplateSelection(this._templateCategory);

  @override
  TemplateSelectionState createState() => TemplateSelectionState();
}

class TemplateSelectionState extends State<TemplateSelection> {
  late final TemplateCategory _templateCategory;
  List<Template> _templates = [];

  TemplateSelectionState() {
    _templateCategory = widget._templateCategory;
    _getTemplates();
  }

  Future<void> _getTemplates() async {
    await ApiService.fetchTemplates().then((response) {
      final templateData = templateFromJson(response.data as String);
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      margin: const EdgeInsets.only(
                          bottom: 20, right: 10, left: 10, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_templates[index].picture == null)
                            Container(
                              width: 140,
                              height: 140,
                              color: Colors.black12,
                              child: const Icon(
                                Icons.image_outlined,
                                color: Colors.black38,
                                size: 50,
                              ),
                            ),
                          // else
                          // ClipOval(
                          //   child: Image(
                          //     image: MemoryImage(
                          //       _templates[index].picture as Uint8List,
                          // TODO: выше используется значение которое null, что то тут не так
                          //     ),
                          //     width: 120,
                          //     height: 120,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          Container(
                            width: 140,
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              _templates[index].name!,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: const Color.fromRGBO(55, 50, 52, 1),
                                  ),
                            ),
                          ),
                          Text(
                            "${_templates[index].cost!.roundDouble(2)} ₽",
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
