import 'package:flower_user_ui/app/locator.dart';
import 'package:flower_user_ui/app/router.gr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthorizationViewModel extends ChangeNotifier {
  final AppRouter router = locator.get();

  String _login = "";
  String _password = "";

  String get login => _login;
  set login(String newLogin) {
    _login = newLogin;
    notifyListeners();
  }

  String get password => _password;
  set password(String newPassword) {
    _password = newPassword;
    notifyListeners();
  }

  bool validateLogin(String login) {
    return login.isNotEmpty;
  }

  bool validatePassword(String password) {
    return password.length > 6;
  }

  bool get isValid => validateLogin(login) && validatePassword(password);
  bool get isNotValid => !isValid;

  Future<void> signin({required BuildContext context}) async {
    void showUserNotFoundedMessage(BuildContext context) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Пользователь не найден",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          action: SnackBarAction(
            label: "Понятно",
            onPressed: () {},
          ),
        ),
      );
    }

    // if (UserService.signin(login, password)) {
    //   NavigationMenu();
    // } else
    showUserNotFoundedMessage(context);
  }

  void signup() {
    router.push(const RegistrationMainMenuRoute());
  }
}
