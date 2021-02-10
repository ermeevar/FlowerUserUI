class Account{
  int _id;
  String _login;
  String _password;
  String _role;

  Account();

  int get id => _id;
  String get login => _login;
  String get password => _password;
  String get role => _role;

  set id(int id){
    _id = id;
  }
  set login(String login){
    _login = login;
  }
  set password(String password){
    _password = password;
  }
  set role(String role){
    _role = role;
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["login"] = _login;
    map["password"] = _password;
    map["role"] = _role;

    return map;
  }

  Account.fromObject(dynamic object){
    this._id = object["id"];
    this._login = object["login"];
    this._password = object["password"];
    this._role = object["role"];
  }
}