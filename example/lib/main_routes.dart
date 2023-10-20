/*
 Created by Thanh Son on 25/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/src/authentication_required/authentication_route.dart';
import 'package:example/src/dynamic_route/dynamic_routes.dart';
import 'package:example/src/multiple_navigator/multiple_navigator_routes.dart';
import 'package:example/src/pages/home_page.dart';
import 'package:example/src/pages/splash_page.dart';
import 'package:example/src/replacement_route/replacement_routes.dart';
import 'package:rowlet/rowlet.dart';

import 'src/items/items_route.dart';

class MainRoute extends OriginRoute {
  MainRoute() : super.stabilityMode();

  final home = MaterialRouteBuilder('/home', pageBuilder: (context, settings) => const HomePage());

  final splash = MaterialRouteBuilder('/', pageBuilder: (context, settings) => const SplashPage());

  final auth = AuthenticationRoute('/auth');

  final items = ListItemRoute('/item');

  final replacementSegments = ReplacementRoutes('/replacement');

  final dynamicRoute = DynamicRoutes('/dynamic');

  final multiple = MultipleNavigatorRoutes('/multiple');

  @override
  List<RouteSegment> get children => [
        auth,
        home,
        splash,
        items,
        replacementSegments,
        dynamicRoute,
        multiple,
      ];
}