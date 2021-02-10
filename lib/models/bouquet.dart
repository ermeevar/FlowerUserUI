class Bouquet{
  int _id;
  String _name;
  double _cost;
  int _storeId;
  int _userId;

  Bouquet();

  int get id => _id;
  String get name => _name;
  double get cost => _cost;
  int get storeId => _storeId;
  int get userId => _userId;

  set id(int id){
    _id = id;
  }
  set name(String name){
    _name = name;
  }
  set cost(double cost){
    _cost = cost;
  }
  set storeId(int storeId){
    _storeId = storeId;
  }
  set userId(int userId){
    _userId = userId;
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["name"] = _name;
    map["cost"] = _cost;
    map["storeId"] = _storeId;
    map["userId"] = _userId;

    return map;
  }

  Bouquet.fromObject(dynamic object){
    this._id = object["id"];
    this._name = object["name"];
    this._cost = object["cost"];
    this._storeId = object["storeId"];
    this._userId = object["userId"];
  }
}