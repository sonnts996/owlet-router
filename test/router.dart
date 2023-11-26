/*
 Created by Thanh Son on 01/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:objectx/objectx.dart';
import 'package:owlet_router/router.dart';

import 'test_app.dart';

class MainRoute extends RouteBase {
  MainRoute() : super.root();

  final routeNotFound = MaterialRouteBuilder('/routeNotFound');
  final home = HomeRoute('/home');
  final splash = MaterialRouteBuilder(
    '/',
    pageBuilder: (context, settings) => TestApp(content: 'Splash'),
  );

  @override
  List<RouteBase> get children => [home, splash];
}

class HomeRoute extends RouteBase {
  HomeRoute(super.segmentPath);

  late final home = RouteBuilder(
    '/',
    builder: (settings) => MaterialPageRoute(
      builder: (context) => TestApp(content: 'Home Page'),
    ),
  );

  late final page1 = RouteBuilder(
    '/page1',
    builder: (settings) => MaterialPageRoute(
      builder: (context) => TestApp(
        content: 'Page 1',
        onTab: () {
          page2.pushNamed(args: 'Hello, this page is opened by page 1');
        },
      ),
    ),
  );

  final page2 = RouteBuilder<String, int>(
    '/page2',
    builder: (settings) {
      final greeting = settings.arguments?.castTo<String?>() ?? 'Page 2';
      return MaterialPageRoute(
        builder: (context) => TestApp(content: greeting),
      );
    },
  );

  final action = NamedFunctionRouteBuilder(
    '/action',
    callback: (context, route) => print('Hello World'),
  );

  final guard = RouteGuard(
      routeGuard: (context, route) {
        if (route.settings.arguments is String) {
          if (route.settings.arguments == 'cancelled') {
            print('cancelled');
            return CancelledRoute();
          } else if (route.settings.arguments == 'redirect_named') {
            return RedirectRoute('/home/page1');
          } else if (route.settings.arguments == 'redirect_itself') {
            return RedirectRoute('/home/guard');
          } else if (route.settings.arguments == 'redirect_route') {
            return MaterialPageRoute(
              builder: (context) => TestApp(content: 'Redirected'),
            );
          }
        }
        return route;
      },
      route: MaterialRouteBuilder('/guard',
          pageBuilder: (context, settings) => TestApp(content: 'RouteGuard')));

  @override
  List<RouteBase> get children => [home, page1, page2, action, guard];
}
