import 'package:flower_user_ui/domain/models/user.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/standard.dart';

@injectable
class AuthService {
  User? user;

  bool signin({required String login, required String password}) {
    throw NotImplementedException();
  }

  void logout() {
    throw NotImplementedException();
  }
}
