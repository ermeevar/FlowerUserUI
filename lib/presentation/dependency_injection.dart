import 'package:flower_user_ui/presentation/services/authorization_service.dart';
import 'package:flower_user_ui/presentation/services/theme_service.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  static void init() {
    GetIt.I.registerSingleton(ThemeService());
    GetIt.I.registerLazySingleton(() => AuthorizationService());
  }
}
