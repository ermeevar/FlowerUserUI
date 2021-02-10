class BouquetProduct{
  int _id;
  int _shopProductId;
  int _bouquetId;

  BouquetProduct();

  int get id => _id;
  int get shopProductId => _shopProductId;
  int get bouquetId => _bouquetId;

  set id(int id){
    _id = id;
  }
  set shopProductId(int shopProductId){
    _shopProductId = shopProductId;
  }
  set bouquetId(int bouquetId){
    _bouquetId = bouquetId;
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["shopProductId"] = _shopProductId;
    map["bouquetId"] = _bouquetId;

    return map;
  }

  BouquetProduct.fromObject(dynamic object){
    this._id = object["id"];
    this._shopProductId = object["shopProductId"];
    this._bouquetId = object["bouquetId"];
  }
}