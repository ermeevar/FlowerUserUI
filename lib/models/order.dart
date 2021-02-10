class Order{
  int _id;
  DateTime _start;
  DateTime _finish;
  bool _isRandom;
  int _orderStatusId;
  int _bouquetId;
  int _templateId;

  Order();

  int get id => _id;
  DateTime get start => _start;
  DateTime get finish => _finish;
  bool get isRandom => _isRandom;
  int get orderStatusId => _orderStatusId;
  int get bouquetId => _bouquetId;
  int get templateId => _templateId;

  set id(int id){
    _id = id;
  }
  set start(DateTime start){
    _start = start;
  }
  set finish(DateTime finish){
    _finish = finish;
  }
  set isRandom(bool isRandom){
    _isRandom = isRandom;
  }
  set orderStatusId(int orderStatusId){
    _orderStatusId = orderStatusId;
  }
  set bouquetId(int bouquetId){
    _bouquetId = bouquetId;
  }
  set templateId(int templateId){
    _templateId = templateId;
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["start"] = _start;
    map["finish"] = _finish;
    map["isRandom"] = _isRandom;
    map["orderStatusId"] = _orderStatusId;
    map["bouquetId"] = _bouquetId;
    map["templateId"] = _templateId;

    return map;
  }

  Order.fromObject(dynamic object){
    this._id = object["id"];
    this._start = object["start"];
    this._finish = object["finish"];
    this._isRandom = object["isRandom"];
    this._orderStatusId = object["orderStatusId"];
    this._bouquetId = object["bouquetId"];
    this._templateId = object["templateId"];
  }
}