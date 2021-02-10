class Template{
  int _id;
  String _name;
  int _templateCategoryId;

  Template();

  int get id => _id;
  String get name => _name;
  int get templateCategoryId => _templateCategoryId;

  set id(int id){
    _id = id;
  }
  set name(String name){
    _name = name;
  }
  set templateCategoryId(int templateCategoryId){
    _templateCategoryId = templateCategoryId;
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["name"] = _name;
    map["templateCategoryId"] = _templateCategoryId;

    return map;
  }

  Template.fromObject(dynamic object){
    this._id = object["id"];
    this._name = object["name"];
    this._templateCategoryId = object["templateCategoryId"];
  }
}