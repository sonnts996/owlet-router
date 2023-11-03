/*
 Created by Thanh Son on 25/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:owlet_router/router.dart';

import 'pages/detail_page.dart';
import 'pages/list_item_page.dart';

class ListItemRoute extends RouteBase {
  ListItemRoute(super.segment);

  final list = MaterialRouteBuilder('/list', pageBuilder: (context, settings) => const ListItemPage());

  late final detail = RouteGuardBuilder(
    routeBuilder: RouteBuilder<String, dynamic>(
      '/detail',
      builder: (settings) {
        if (settings.arguments is String) {
          return MaterialPageRoute(
              settings: settings, builder: (context) => DetailPage(item: settings.arguments as String));
        }
        return CancelledRoute(false);
      },
    ),
    routeGuard: (pushContext, route) async {
      if (!navigatorServices.history.contains(list.path)) {
        Navigator.push(pushContext, list.noAnimationBuilder()!);
      }
      return route;
    },
  );

  @override
  List<RouteBase> get children => [detail, list];
}
