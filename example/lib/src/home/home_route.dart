/*
 Created by Thanh Son on 06/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/src/home/home_page.dart';
import 'package:example/src/home/home_tab_route.dart';
import 'package:flutter/material.dart';
import 'package:owlet_router/router.dart';

final homeTabService = NavigationService(
  navigationKey: GlobalKey(),
  route: HomeTabRoute('/'),
  initialRoute: '/',
);

class HomeRoute extends MaterialRouteBuilder {
  HomeRoute(super.segment);

  @override
  PageBuilder? get pageBuilder => (context, settings) {
        final initialRoute = settings.arguments as Map<String, dynamic>?;
        return HomePage(
          initialRoute: initialRoute?['initialRoute'] ?? '/',
          service: homeTabService,
        );
      };

  @override
  List<RouteBase> get children => [];
}
