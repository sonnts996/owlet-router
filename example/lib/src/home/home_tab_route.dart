/*
 Created by Thanh Son on 06/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/src/home/tabs/navigation_tab.dart';
import 'package:example/src/home/tabs/route_tab.dart';
import 'package:flutter/material.dart';
import 'package:owlet_router/router.dart';

import 'tabs/home_tab.dart';

class HomeTabRoute extends RouteBase {
  HomeTabRoute(super.segment);

  final ValueNotifier<RouteSettings?> routeNotifier = ValueNotifier(null);

  final homeTab = RouteGuard.awareExists(
    route: MaterialRouteBuilder(
      '/',
      pageBuilder: (context, settings) => const HomeTab(),
    ),
  );

  late final navigationTab = RouteGuard.awareExists(
      onRouteExists: (context, route) {
        routeNotifier.value = route.settings;
        return null;
      },
      route: NoTransitionRouteBuilder(
        '/navigation-service',
        pageBuilder: (context, settings) => const NavigationTab(),
      ));

  late final routeTab = RouteGuard.awareExists(
      onRouteExists: (context, route) {
        routeNotifier.value = route.settings;
        return null;
      },
      route: NoTransitionRouteBuilder(
        '/route',
        pageBuilder: (context, settings) => const RouteTab(),
      ));

  @override
  List<RouteBase> get children => [homeTab, navigationTab, routeTab];
}
