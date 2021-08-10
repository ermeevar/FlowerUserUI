import 'package:crypt/crypt.dart';
import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/internal/utils/web.api.services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileManipulation {
  static Account account;
  static User user;

  static Future<Account> getAccount(Account account) async {
    Account accountBD;

    await WebApiServices.fetchAccounts().then((response) {
      var accountData = accountFromJson(response.data);
      accountBD = accountData.firstWhere(
          (element) => element.login == account.login && element.role == "user",
          orElse: () => null);
    });
    if (accountBD == null) return null;

    final crypto = Crypt.sha256(account.passwordHash, salt: accountBD.salt);

    if (accountBD.passwordHash == crypto.hash) {
      return accountBD;
    } else
      return null;
  }

  static Future<User> getUser(Account account) async {
    Account accountBD = await getAccount(account);

    if (accountBD == null) return null;

    User user;
    await WebApiServices.fetchUsers().then((response) {
      var userData = userFromJson(response.data);
      user =
          userData.firstWhere((element) => element.accountId == accountBD.id);
    });

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    prefs.setInt("AccountId", accountBD.id);
    prefs.setInt("UserId", user.id);

    return user;
  }

  static Future<bool> addUser(Account account, User user) async {
    final crypto = Crypt.sha256(account.passwordHash);
    account.passwordHash = crypto.hash;
    account.salt = crypto.salt;
    account.role = "user";
    List<Account> _accounts = [];

    await WebApiServices.fetchAccounts().then((response) {
      var accountData = accountFromJson(response.data);
      _accounts = accountData.toList();
    });

    for (var item in _accounts) {
      if (item.login == account.login) return false;
    }

    await WebApiServices.postAccount(account);
    await WebApiServices.fetchAccounts().then((response) {
      var accountData = accountFromJson(response.data);
      _accounts = accountData.toList();
    });

    user.accountId = _accounts.toList().last.id;
    await WebApiServices.postUser(user);
    return true;
  }
}
