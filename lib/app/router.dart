import 'package:auto_route/auto_route.dart';
import 'package:flower_user_ui/presentation/screens/authorization_widgets/authorization_main_menu.dart';
import 'package:flower_user_ui/presentation/screens/bouquet/bouquet_main.dart';
import 'package:flower_user_ui/presentation/screens/navigation_menu.dart';
import 'package:auto_route/annotations.dart' as auto_route;
import 'package:flower_user_ui/presentation/screens/order/bouquet_order.dart';
import 'package:flower_user_ui/presentation/screens/order/random_bouquet_order.dart';
import 'package:flower_user_ui/presentation/screens/registration_widgets/registration_main_menu.dart';
import 'package:flower_user_ui/presentation/screens/template/template_category_selection.dart';
import 'package:flower_user_ui/presentation/screens/template/template_selection.dart';

@MaterialAutoRouter(routes: [
  auto_route.MaterialRoute(page: NavigationMenu, initial: true),
  auto_route.MaterialRoute(page: AuthorizationMainMenuView),
  auto_route.MaterialRoute(page: RegistrationMainMenu),
  auto_route.MaterialRoute(page: BouquetOrder),
  auto_route.MaterialRoute(page: TemplateCategorySelection),
  auto_route.MaterialRoute(page: BouquetMainMenu),
  auto_route.MaterialRoute(page: RandomBouquetOrder),
  auto_route.MaterialRoute(page: TemplateSelection),
])
class $AppRouter {}
