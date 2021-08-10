import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/domain/services/api_service.dart';
import 'package:flower_user_ui/domain/services/profile_service.dart';
import 'package:flower_user_ui/internal/utils/image_controller.dart';
import 'package:flower_user_ui/presentation/screens/authorization_widgets/authorization_main_menu.dart';
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
    return Text(ProfileService.user.name + " " + ProfileService.user.surname,
        style: Theme.of(context).textTheme.bodyText1);
  }

  Text getLogin(context) {
    return Text(
      ProfileService.account != null ? ProfileService.account.login : "Error",
      style: Theme.of(context)
          .textTheme
          .bodyText1
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
          child: ProfileService.user.picture == null
              ? Icon(
                  Icons.supervisor_account_outlined,
                  color: Colors.black38,
                  size: 50,
                )
              : ClipOval(
                  child: Image(
                    image: MemoryImage(ProfileService.user.picture),
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
              TextButton(
                onPressed: () {
                  _taped();
                  Navigator.pop(context);
                },
                child: new Text(
                  "Изменить",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Color.fromRGBO(130, 147, 153, 1),
                      ),
                ),
              )
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
              TextButton(
                  onPressed: () async {
                    await onAuthorizationPage();
                  },
                  child: new Text("Выйти",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Color.fromRGBO(130, 147, 153, 1))))
            ],
          ),
        ),
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.delete, size: 25, color: Colors.red),
              new TextButton(
                  onPressed: () async {
                    await ApiService.deleteAccount(ProfileService.account.id);
                    await onAuthorizationPage();
                  },
                  child: new Text("Удалить",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
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
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              var pickedImage = await ImageController.getImageFromGallery();
              if (pickedImage != null) {
                setState(() async {
                  ProfileService.user.picture = pickedImage;
                  await ApiService.putUser(ProfileService.user);
                  await ProfileService.getUser(ProfileService.account);
                });
              }
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Камера',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              var pickedImage = await ImageController.getImageFromCamera();
              if (pickedImage != null) {
                setState(() async {
                  ProfileService.user.picture = pickedImage;
                  await ApiService.putUser(ProfileService.user);
                  await ProfileService.getUser(ProfileService.account);
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
          child: TextButton(
            onPressed: () async {
              _taped();
              await ApiService.putUser(ProfileService.user);
              await ProfileService.getUser(ProfileService.account);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(130, 147, 153, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: new Text("Сохранить",
                  style: Theme.of(context).textTheme.bodyText2),
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
            ProfileService.user.phone = phone;
          });
        },
        cursorColor: Color.fromRGBO(130, 147, 153, 1),
        initialValue:
            ProfileService.user.phone != null ? ProfileService.user.phone : "",
        style: Theme.of(context).textTheme.bodyText1,
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
            ProfileService.user.surname = surname;
          });
        },
        cursorColor: Color.fromRGBO(130, 147, 153, 1),
        initialValue: ProfileService.user.surname != null
            ? ProfileService.user.surname
            : "",
        style: Theme.of(context).textTheme.bodyText1,
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
        initialValue:
            ProfileService.user.name != null ? ProfileService.user.name : "",
        style: Theme.of(context).textTheme.bodyText1,
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
            onPressed: () async {
              _taped();
              await ProfileService.getUser(ProfileService.account);
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
