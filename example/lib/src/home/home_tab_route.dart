/*
 Created by Thanh Son on 06/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/cupertino.dart';
import 'package:objectx/objectx.dart';
import 'package:owlet_router/router.dart';

import 'domain/interfaces/metadata_interface.dart';
import 'presentations/tabs/tab_widget.dart';

final homeTabService = NavigationService(
  navigationKey: GlobalKey(),
  route: HomeTabRoute('/'),
  initialRoute: '/',
);

class BreadCrumbItem {
  BreadCrumbItem({
    required this.route,
    required this.label,
    required this.onTab,
  });

  final Route route;
  final String label;
  final VoidCallback onTab;
}

class HomeTabRoute extends RouteBase {
  HomeTabRoute(super.segment);

  final ValueNotifier<Set<BreadCrumbItem>> breadCrumbNotifier = ValueNotifier({});

  late final homePage = RouteGuard.awareExists<PageInterface, Object?>(
    route: NoTransitionRouteBuilder(
      '/',
      pageBuilder: (context, settings) => TabWidget(page: null),
    ),
  );

  late final tabPage = NestedRoute(
    awareExists: false,
    route: RouteGuard<PageInterface, Object?>(
      routeGuard: (context, it, route) {
        if (!service.history.isCurrentByName(route.settings.name ?? '')) {
          Navigator.popUntil(context, (route) => route.isFirst);
          return route;
        }
        return CancelledRoute();
      },
      route: NoTransitionRouteBuilder(
        '/t',
        pageBuilder: (context, settings) => TabWidget(page: settings.arguments.castTo<PageInterface?>()),
      ),
    ),
  );

  @override
  List<RouteBase> get children => [homePage, tabPage];
}
