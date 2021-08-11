// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../presentation/screens/authorization_widgets/authorization_main_menu.dart'
    as _i4;
import '../presentation/screens/navigation_menu.dart' as _i3;

class Router extends _i1.RootStackRouter {
  Router([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
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
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(NavigationMenuRoute.name, path: '/'),
        _i1.RouteConfig(AuthorizationMainMenuRoute.name,
            path: '/authorization-main-menu')
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
