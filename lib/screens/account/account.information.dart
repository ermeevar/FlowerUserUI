import 'package:flower_user_ui/entities/user.dart';
import 'package:flower_user_ui/states/image.controller.dart';
import 'package:flower_user_ui/states/profile.manipulation.dart';
import 'package:flower_user_ui/states/web.api.services.dart';
import 'package:flower_user_ui/screens/authorization.widgets/authorization.main.menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountInformation extends StatefulWidget {
  @override
  AccountInformationState createState() => AccountInformationState();
}

class AccountInformationState extends State<AccountInformation>
    with SingleTickerProviderStateMixin {
  User _user = User();
  bool _isTab = false;
  final picker = ImagePicker();

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

  //#region ReadAccountInfo
  Widget _read(context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [Spacer(), getMenuButton()],
          ),
          getProfileImage(),
          getLogin(context),
          getName(context),
        ],
      ),
    );
  }

  Text getName(context) {
    return Text(
        ProfileManipulation.user.name + " " + ProfileManipulation.user.surname,
        style: Theme.of(context).textTheme.body1);
  }

  Text getLogin(context) {
    return Text(
      ProfileManipulation.account != null
          ? ProfileManipulation.account.login
          : "Error",
      style: Theme.of(context)
          .textTheme
          .body1
          .copyWith(height: 2, fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  GestureDetector getProfileImage() {
    return GestureDetector(
      onTap: () async {
        await showOptionsForPhoto(context);
      },
      child: Card(
        elevation: 10,
        shape: CircleBorder(),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 60,
          child: ProfileManipulation.user.picture == null
              ? Icon(
                  Icons.supervisor_account_outlined,
                  color: Colors.black38,
                  size: 50,
                )
              : ClipOval(
                  child: Image(
                    image: MemoryImage(ProfileManipulation.user.picture),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }

  PopupMenuButton<dynamic> getMenuButton() {
    return PopupMenuButton(
      color: Colors.white,
      icon: Icon(Icons.more_horiz, color: Color.fromRGBO(130, 147, 153, 1)),
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
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(color: Color.fromRGBO(130, 147, 153, 1))))
            ],
          ),
        ),
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
                  onPressed: () async {
                    await onAuthorizationPage();
                  },
                  padding: EdgeInsets.only(left: 10),
                  child: new Text("Выйти",
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(color: Color.fromRGBO(130, 147, 153, 1))))
            ],
          ),
        ),
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.delete, size: 25, color: Colors.red),
              new FlatButton(
                  onPressed: () async {
                    await WebApiServices.deleteAccount(
                        ProfileManipulation.account.id);
                    await onAuthorizationPage();
                  },
                  padding: EdgeInsets.only(left: 10),
                  child: new Text("Удалить",
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(color: Colors.red)))
            ],
          ),
        ),
      ],
    );
  }

  Future showOptionsForPhoto(context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              'Выбрать из галереи',
              style: Theme.of(context).textTheme.body1,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              var pickedImage = await ImageController.getImageFromGallery();
              if (pickedImage != null) {
                setState(() async {
                  ProfileManipulation.user.picture = pickedImage;
                  await WebApiServices.putUser(ProfileManipulation.user);
                  await ProfileManipulation.getUser(ProfileManipulation.account);
                });
              }
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Камера',
              style: Theme.of(context).textTheme.body1,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              var pickedImage = await ImageController.getImageFromCamera();
              if (pickedImage != null) {
                setState(() async{
                  ProfileManipulation.user.picture = pickedImage;
                  await WebApiServices.putUser(ProfileManipulation.user);
                  await ProfileManipulation.getUser(ProfileManipulation.account);
                });
              }
            },
          ),
        ],
      ),
    );
  }
  //#endregion

  //#region ChangeAccountInfo
  Widget _change(context) {
    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            getBackButton(),
            getNameField(context),
            getSurnameField(context),
            getPhone(context),
            getSaveButton(context),
          ],
        ),
      ),
    );
  }

  Row getSaveButton(context) {
    return Row(
      children: [
        Spacer(),
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 2),
          child: FlatButton(
            onPressed: () async{
              _taped();
              await WebApiServices.putUser(ProfileManipulation.user);
              await ProfileManipulation.getUser(ProfileManipulation.account);
            },
            padding: EdgeInsets.zero,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(130, 147, 153, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: new Text("Сохранить",
                  style: Theme.of(context).textTheme.body2),
            ),
          ),
        )
      ],
    );
  }

  Container getPhone(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (phone) {
          setState(() {
            ProfileManipulation.user.phone = phone;
          });
        },
        cursorColor: Color.fromRGBO(130, 147, 153, 1),
        initialValue: ProfileManipulation.user.phone != null
            ? ProfileManipulation.user.phone
            : "",
        style: Theme.of(context).textTheme.body1,
        decoration: InputDecoration(
          labelText: "Телефон",
          prefixText: "+7 ",
          focusColor: Color.fromRGBO(130, 147, 153, 1),
        ),
      ),
    );
  }

  Padding getSurnameField(context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        onChanged: (surname) {
          setState(() {
            ProfileManipulation.user.surname = surname;
          });
        },
        cursorColor: Color.fromRGBO(130, 147, 153, 1),
        initialValue: ProfileManipulation.user.surname != null
            ? ProfileManipulation.user.surname
            : "",
        style: Theme.of(context).textTheme.body1,
        decoration: InputDecoration(
          labelText: "Фамилия",
          focusColor: Color.fromRGBO(130, 147, 153, 1),
        ),
      ),
    );
  }

  Padding getNameField(context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        onChanged: (name) {
          setState(() {
            this._user.name = name;
          });
        },
        cursorColor: Color.fromRGBO(130, 147, 153, 1),
        key: Key("name"),
        initialValue: ProfileManipulation.user.name != null
            ? ProfileManipulation.user.name
            : "",
        style: Theme.of(context).textTheme.body1,
        decoration: InputDecoration(
          labelText: "Имя",
          focusColor: Color.fromRGBO(130, 147, 153, 1),
        ),
      ),
    );
  }

  Row getBackButton() {
    return Row(
      children: [
        Spacer(),
        IconButton(
            icon: Icon(Icons.navigate_next, size: 30),
            padding: EdgeInsets.zero,
            color: Color.fromRGBO(130, 147, 153, 1),
            onPressed: () async{
              _taped();
              await ProfileManipulation.getUser(ProfileManipulation.account);
            }),
      ],
    );
  }
  //#endregion

  onAuthorizationPage() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    prefs.setInt("AccountId", 0);
    prefs.setInt("UserId", 0);

    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => AuthorizationMainMenu(),
      ),
    );
  }
}
