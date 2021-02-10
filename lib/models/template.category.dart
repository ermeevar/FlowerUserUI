class TemplateCategory{
  int _id;
  String _name;

  TemplateCategory();

  int get id => _id;
  String get name => _name;

  set id(int id){
    _id = id;
  }
  set name(String name){
    _name = name;
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["name"] = _name;

    return map;
  }

  TemplateCategory.fromObject(dynamic object){
    this._id = object["id"];
    this._name = object["name"];
  }
}