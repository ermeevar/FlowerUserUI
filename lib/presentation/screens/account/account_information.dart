import 'dart:typed_data';

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
  final User _user = User();
  bool _isTab = false;
  final picker = ImagePicker();

  void _taped() {
    setState(() {
      _isTab = !_isTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      child: _isTab ? _change(context) : _read(context),
    );
  }

  //#region ReadAccountInfo
  Widget _read(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            children: [const Spacer(), getMenuButton()],
          ),
          getProfileImage(),
          getLogin(context),
          getName(context),
        ],
      ),
    );
  }

  Text getName(BuildContext context) {
    return Text("${ProfileService.user.name!} ${ProfileService.user.surname!}",
        style: Theme.of(context).textTheme.bodyText1);
  }

  Text getLogin(BuildContext context) {
    return Text(
      ProfileService.account != null ? ProfileService.account!.login! : "Error",
      style: Theme.of(context)
          .textTheme
          .bodyText1!
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
        shape: const CircleBorder(),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 60,
          child: ProfileService.user.picture == null
              ? const Icon(
                  Icons.supervisor_account_outlined,
                  color: Colors.black38,
                  size: 50,
                )
              : ClipOval(
                  child: Image(
                    image:
                        MemoryImage(ProfileService.user.picture as Uint8List),
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
      icon:
          const Icon(Icons.more_horiz, color: Color.fromRGBO(130, 147, 153, 1)),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Row(
            children: [
              const Icon(
                Icons.edit,
                size: 25,
                color: Color.fromRGBO(130, 147, 153, 1),
              ),
              TextButton(
                onPressed: () {
                  _taped();
                  Navigator.pop(context);
                },
                child: Text(
                  "Изменить",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: const Color.fromRGBO(130, 147, 153, 1),
                      ),
                ),
              )
            ],
          ),
        ),
        PopupMenuItem(
          child: Row(
            children: [
              const Icon(
                Icons.exit_to_app,
                size: 25,
                color: Color.fromRGBO(130, 147, 153, 1),
              ),
              TextButton(
                onPressed: () async {
                  await onAuthorizationPage();
                },
                child: Text(
                  "Выйти",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: const Color.fromRGBO(130, 147, 153, 1),
                      ),
                ),
              )
            ],
          ),
        ),
        PopupMenuItem(
          child: Row(
            children: [
              const Icon(Icons.delete, size: 25, color: Colors.red),
              TextButton(
                  onPressed: () async {
                    await ApiService.deleteAccount(ProfileService.account!.id);
                    await onAuthorizationPage();
                  },
                  child: Text("Удалить",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.red)))
            ],
          ),
        ),
      ],
    );
  }

  Future showOptionsForPhoto(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.of(context).pop();
              final pickedImage = await ImageController.getImageFromGallery();
              if (pickedImage != null) {
                setState(() async {
                  ProfileService.user.picture = pickedImage;
                  await ApiService.putUser(ProfileService.user);
                  await ProfileService.getUser(ProfileService.account);
                });
              }
            },
            child: Text(
              'Выбрать из галереи',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.of(context).pop();
              final pickedImage = await ImageController.getImageFromCamera();
              if (pickedImage != null) {
                setState(() async {
                  ProfileService.user.picture = pickedImage;
                  await ApiService.putUser(ProfileService.user);
                  await ProfileService.getUser(ProfileService.account);
                });
              }
            },
            child: Text(
              'Камера',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
  //#endregion

  //#region ChangeAccountInfo
  Widget _change(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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

  Row getSaveButton(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 2),
          child: TextButton(
            onPressed: () async {
              _taped();
              await ApiService.putUser(ProfileService.user);
              await ProfileService.getUser(ProfileService.account);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(130, 147, 153, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Text("Сохранить",
                  style: Theme.of(context).textTheme.bodyText2),
            ),
          ),
        )
      ],
    );
  }

  Container getPhone(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
        cursorColor: const Color.fromRGBO(130, 147, 153, 1),
        initialValue: ProfileService.user.phone ?? "",
        style: Theme.of(context).textTheme.bodyText1,
        decoration: const InputDecoration(
          labelText: "Телефон",
          prefixText: "+7 ",
          focusColor: Color.fromRGBO(130, 147, 153, 1),
        ),
      ),
    );
  }

  Padding getSurnameField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        onChanged: (surname) {
          setState(() {
            ProfileService.user.surname = surname;
          });
        },
        cursorColor: const Color.fromRGBO(130, 147, 153, 1),
        initialValue: ProfileService.user.surname ?? "",
        style: Theme.of(context).textTheme.bodyText1,
        decoration: const InputDecoration(
          labelText: "Фамилия",
          focusColor: Color.fromRGBO(130, 147, 153, 1),
        ),
      ),
    );
  }

  Padding getNameField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        onChanged: (name) {
          setState(() {
            _user.name = name;
          });
        },
        cursorColor: const Color.fromRGBO(130, 147, 153, 1),
        key: const Key("name"),
        initialValue: ProfileService.user.name ?? "",
        style: Theme.of(context).textTheme.bodyText1,
        decoration: const InputDecoration(
          labelText: "Имя",
          focusColor: Color.fromRGBO(130, 147, 153, 1),
        ),
      ),
    );
  }

  Row getBackButton() {
    return Row(
      children: [
        const Spacer(),
        IconButton(
            icon: const Icon(Icons.navigate_next, size: 30),
            padding: EdgeInsets.zero,
            color: const Color.fromRGBO(130, 147, 153, 1),
            onPressed: () async {
              _taped();
              await ProfileService.getUser(ProfileService.account);
            }),
      ],
    );
  }
  //#endregion

  Future<void> onAuthorizationPage() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
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
