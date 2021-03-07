import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flower_user_ui/models/user.dart';
import 'package:flower_user_ui/models/account.dart';
import 'package:flower_user_ui/models/web.api.services.dart';

class AccountInformation extends StatefulWidget {
  User _user;

  AccountInformation(this._user);

  @override
  AccountInformationState createState() => AccountInformationState(_user);
}

class AccountInformationState extends State<AccountInformation>
    with SingleTickerProviderStateMixin {
  User _user;
  String _name;
  String _surname;
  String _phone;
  bool _isTab = false;
  Account _account;

  AccountInformationState(this._user) {
    _getAccount();
  }

  _getAccount() {
    WebApiServices.fetchAccount().then((response) {
      var accountsData = accountFromJson(response.data);
      setState(() {
        _account = accountsData
            .where((element) => element.id == _user.accountId)
            .first;
      });
    });
  }

  void _taped() {
    setState(() {
      _isTab = !_isTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedContainer(
        child: _isTab ? _change(context) : _read(context),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Widget _read(context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Spacer(),
              PopupMenuButton(
                color: Colors.white,
                icon: Icon(Icons.more_horiz,
                    color: Color.fromRGBO(130, 147, 153, 1)),
                itemBuilder: (context) => [
                  PopupMenuItem(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.edit,
                        size: 25,
                        color: Color.fromRGBO(130, 147, 153, 1),
                      ),
                      FlatButton(
                          onPressed: () {
                            _taped();
                            Navigator.pop(context);
                          },
                          padding: EdgeInsets.only(left: 10),
                          child: new Text("Изменить",
                              style: Theme.of(context).textTheme.body1.copyWith(
                                  color: Color.fromRGBO(130, 147, 153, 1))))
                    ],
                  )),
                  PopupMenuItem(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        size: 25,
                        color: Color.fromRGBO(130, 147, 153, 1),
                      ),
                      FlatButton(
                          onPressed: null,
                          padding: EdgeInsets.only(left: 10),
                          child: new Text("Выйти",
                              style: Theme.of(context).textTheme.body1.copyWith(
                                  color: Color.fromRGBO(130, 147, 153, 1))))
                    ],
                  )),
                  PopupMenuItem(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.delete, size: 25, color: Colors.red),
                      new FlatButton(
                          onPressed: null,
                          padding: EdgeInsets.only(left: 10),
                          child: new Text("Удалить",
                              style: Theme.of(context)
                                  .textTheme
                                  .body1
                                  .copyWith(color: Colors.red)))
                    ],
                  )),
                ],
              )
            ],
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(_user.picture == null
                ? 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
                : _user.picture),
            backgroundColor: Colors.transparent,
          ),
          Text(_account.login,
              style: Theme.of(context).textTheme.body1.copyWith(
                  height: 2, fontWeight: FontWeight.bold, fontSize: 20)),
          Text(_user.name + " " + _user.surname,
              style: Theme.of(context).textTheme.body1)
        ],
      ),
    );
  }

  Widget _change(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              IconButton(
                  icon: Icon(Icons.navigate_next, size: 30),
                  padding: EdgeInsets.zero,
                  color: Color.fromRGBO(130, 147, 153, 1),
                  onPressed: () {
                    _taped();
                  }),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: TextFormField(
                onChanged: (name) {
                  setState(() {
                    this._name = name;
                  });
                },
                cursorColor: Color.fromRGBO(130, 147, 153, 1),
                key: Key("name"),
                initialValue: _user.name != null ? _user.name : "",
                style: Theme.of(context).textTheme.body1,
                decoration: InputDecoration(
                  labelText: "Имя",
                  focusColor: Color.fromRGBO(130, 147, 153, 1),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: TextFormField(
                onChanged: (surname) {
                  setState(() {
                    this._surname = surname;
                  });
                },
                cursorColor: Color.fromRGBO(130, 147, 153, 1),
                initialValue: _user.surname != null ? _user.surname : "",
                style: Theme.of(context).textTheme.body1,
                decoration: InputDecoration(
                  labelText: "Фамилия",
                  focusColor: Color.fromRGBO(130, 147, 153, 1),
                )),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: TextFormField(
                onChanged: (phone) {
                  setState(() {
                    this._phone = phone;
                  });
                },
                cursorColor: Color.fromRGBO(130, 147, 153, 1),
                initialValue: _user.phone != null ? _user.phone : "",
                style: Theme.of(context).textTheme.body1,
                decoration: InputDecoration(
                  labelText: "Телефон",
                  focusColor: Color.fromRGBO(130, 147, 153, 1),
                )),
          ),
          Row(
            children: [
              Spacer(),
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 2),
                child: FlatButton(
                    onPressed: () {
                      _taped();
                    },
                    padding: EdgeInsets.zero,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(130, 147, 153, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: new Text("Сохранить",
                            style: Theme.of(context).textTheme.body2))),
              )
            ],
          )
        ],
      ),
    );
  }
}
