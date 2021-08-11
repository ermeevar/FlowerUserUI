import 'package:collection/collection.dart' show IterableExtension;
import 'package:crypt/crypt.dart';
import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';

@singleton
class ProfileService {
  static Account? account;
  static late User user;

  static Future<Account?> getAccount(Account? account) async {
    Account? accountBD;

    await ApiService.fetchAccounts().then((response) {
      final accountData = accountFromJson(response.data as String);
      accountBD = accountData.firstWhereOrNull((element) =>
          element.login == account!.login && element.role == "user");
    });
    if (accountBD == null) return null;

    final crypto =
        Crypt.sha256(account!.passwordHash!, salt: accountBD!.salt.toString());

    if (accountBD!.passwordHash == crypto.hash) {
      return accountBD;
    } else {
      return null;
    }
  }

  static Future<User?> getUser(Account? account) async {
    final Account? accountBD = await getAccount(account);

    if (accountBD == null) return null;

    User? user;
    await ApiService.fetchUsers().then((response) {
      final userData = userFromJson(response.data as String);
      user =
          userData.firstWhere((element) => element.accountId == accountBD.id);
    });

    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    prefs.setInt("AccountId", accountBD.id!);
    prefs.setInt("UserId", user!.id!);

    return user;
  }

  static Future<bool> addUser(Account account, User user) async {
    final crypto = Crypt.sha256(account.passwordHash!);
    account.passwordHash = crypto.hash;
    account.salt = crypto.salt;
    account.role = "user";
    List<Account> _accounts = [];

    await ApiService.fetchAccounts().then((response) {
      final accountData = accountFromJson(response.data as String);
      _accounts = accountData.toList();
    });

    for (final item in _accounts) {
      if (item.login == account.login) return false;
    }

    await ApiService.postAccount(account);
    await ApiService.fetchAccounts().then((response) {
      final accountData = accountFromJson(response.data as String);
      _accounts = accountData.toList();
    });

    user.accountId = _accounts.toList().last.id;
    await ApiService.postUser(user);
    return true;
  }
}
