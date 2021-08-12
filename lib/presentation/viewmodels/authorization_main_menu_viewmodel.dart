import 'package:flower_user_ui/data/models/api_modes.dart';
import 'package:flower_user_ui/data/services/services.dart';
import 'package:flutter/widgets.dart';

class AuthorizationMainMenuViewModel extends ChangeNotifier {
  final ProfileService profileService = ProfileService(); // TODO: Inject DI
  final ApiService apiService = ApiService();

  Account? account;

  Future<User?> signIn(Account account) async {
    return ProfileService.getUser(
        account); // TODO : Убрать жесткую привязку к статике
  }
}
