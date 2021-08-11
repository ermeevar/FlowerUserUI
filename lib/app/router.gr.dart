// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../data/models/api_modes.dart' as _i11;
import '../presentation/screens/authorization_widgets/authorization_main_menu.dart'
    as _i4;
import '../presentation/screens/bouquet/bouquet_main.dart' as _i8;
import '../presentation/screens/navigation_menu.dart' as _i3;
import '../presentation/screens/order/bouquet_order.dart' as _i6;
import '../presentation/screens/order/random_bouquet_order.dart' as _i9;
import '../presentation/screens/registration_widgets/registration_main_menu.dart'
    as _i5;
import '../presentation/screens/template/template_category_selection.dart'
    as _i7;
import '../presentation/screens/template/template_selection.dart' as _i10;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    NavigationMenuRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.NavigationMenu();
        }),
    AuthorizationMainMenuRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.AuthorizationMainMenu();
        }),
    RegistrationMainMenuRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.RegistrationMainMenu();
        }),
    BouquetOrderRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<BouquetOrderRouteArgs>();
          return _i6.BouquetOrder(args.bouquet);
        }),
    TemplateCategorySelectionRoute.name: (routeData) =>
        _i1.MaterialPageX<dynamic>(
            routeData: routeData,
            builder: (_) {
              return _i7.TemplateCategorySelection();
            }),
    BouquetMainMenuRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i8.BouquetMainMenu();
        }),
    RandomBouquetOrderRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<RandomBouquetOrderRouteArgs>();
          return _i9.RandomBouquetOrder(args.cost);
        }),
    TemplateSelectionRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<TemplateSelectionRouteArgs>();
          return _i10.TemplateSelection(args.templateCategory);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(NavigationMenuRoute.name, path: '/'),
        _i1.RouteConfig(AuthorizationMainMenuRoute.name,
            path: '/authorization-main-menu'),
        _i1.RouteConfig(RegistrationMainMenuRoute.name,
            path: '/registration-main-menu'),
        _i1.RouteConfig(BouquetOrderRoute.name, path: '/bouquet-order'),
        _i1.RouteConfig(TemplateCategorySelectionRoute.name,
            path: '/template-category-selection'),
        _i1.RouteConfig(BouquetMainMenuRoute.name, path: '/bouquet-main-menu'),
        _i1.RouteConfig(RandomBouquetOrderRoute.name,
            path: '/random-bouquet-order'),
        _i1.RouteConfig(TemplateSelectionRoute.name,
            path: '/template-selection')
      ];
}

class NavigationMenuRoute extends _i1.PageRouteInfo {
  const NavigationMenuRoute() : super(name, path: '/');

  static const String name = 'NavigationMenuRoute';
}

class AuthorizationMainMenuRoute extends _i1.PageRouteInfo {
  const AuthorizationMainMenuRoute()
      : super(name, path: '/authorization-main-menu');

  static const String name = 'AuthorizationMainMenuRoute';
}

class RegistrationMainMenuRoute extends _i1.PageRouteInfo {
  const RegistrationMainMenuRoute()
      : super(name, path: '/registration-main-menu');

  static const String name = 'RegistrationMainMenuRoute';
}

class BouquetOrderRoute extends _i1.PageRouteInfo<BouquetOrderRouteArgs> {
  BouquetOrderRoute({required _i11.Bouquet? bouquet})
      : super(name,
            path: '/bouquet-order',
            args: BouquetOrderRouteArgs(bouquet: bouquet));

  static const String name = 'BouquetOrderRoute';
}

class BouquetOrderRouteArgs {
  const BouquetOrderRouteArgs({required this.bouquet});

  final _i11.Bouquet? bouquet;
}

class TemplateCategorySelectionRoute extends _i1.PageRouteInfo {
  const TemplateCategorySelectionRoute()
      : super(name, path: '/template-category-selection');

  static const String name = 'TemplateCategorySelectionRoute';
}

class BouquetMainMenuRoute extends _i1.PageRouteInfo {
  const BouquetMainMenuRoute() : super(name, path: '/bouquet-main-menu');

  static const String name = 'BouquetMainMenuRoute';
}

class RandomBouquetOrderRoute
    extends _i1.PageRouteInfo<RandomBouquetOrderRouteArgs> {
  RandomBouquetOrderRoute({required double cost})
      : super(name,
            path: '/random-bouquet-order',
            args: RandomBouquetOrderRouteArgs(cost: cost));

  static const String name = 'RandomBouquetOrderRoute';
}

class RandomBouquetOrderRouteArgs {
  const RandomBouquetOrderRouteArgs({required this.cost});

  final double cost;
}

class TemplateSelectionRoute
    extends _i1.PageRouteInfo<TemplateSelectionRouteArgs> {
  TemplateSelectionRoute({required _i11.TemplateCategory templateCategory})
      : super(name,
            path: '/template-selection',
            args:
                TemplateSelectionRouteArgs(templateCategory: templateCategory));

  static const String name = 'TemplateSelectionRoute';
}

class TemplateSelectionRouteArgs {
  const TemplateSelectionRouteArgs({required this.templateCategory});

  final _i11.TemplateCategory templateCategory;
}
