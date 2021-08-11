import 'package:auto_route/auto_route.dart';
import 'package:flower_user_ui/presentation/screens/authorization_widgets/authorization_main_menu.dart';
import 'package:flower_user_ui/presentation/screens/navigation_menu.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: NavigationMenu, initial: true),
  MaterialRoute(page: AuthorizationMainMenu),
])
class $Router {}
