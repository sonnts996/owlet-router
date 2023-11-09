/*
 Created by Thanh Son on 06/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/src/home/home_page.dart';
import 'package:example/src/home/tabs/home_tab_route.dart';
import 'package:objectx/objectx.dart';
import 'package:owlet_router/router.dart';

class HomeRoute extends MaterialRouteBuilder {
  HomeRoute(super.segment);

  @override
  PageBuilder? get pageBuilder => (context, settings) {
        final initialRoute = settings.arguments as Map<String, dynamic>?;
        return HomePage(
          initialRoute: initialRoute?['initialRoute'] ?? '/',
        );
      };

  final homeTab = RouteGuardBuilder(
      routeGuard: (pushContext, route) {
        final service = NavigationService.of(pushContext);
        final homeRoute = RouteBase.of<HomeRoute>(pushContext, depthSearch: true);
        if (!service.history.contains(homeRoute.path)) {
          return homeRoute.toRoute(args: {'initialRoute': '/'});
        } else {
          NavigationService.of<HomeTabRoute>(pushContext).let((it) => it.pushNamed(route: it.root.homeTab));
          return CancelledRoute();
        }
      },
      routeBuilder: PlaceholderRoute('/tab/'));

  final profileTab = RouteGuardBuilder(
      routeGuard: (pushContext, route) {
        final service = NavigationService.of(pushContext);
        final homeRoute = RouteBase.of<HomeRoute>(pushContext, depthSearch: true);
        if (!service.history.contains(homeRoute.path)) {
          return homeRoute.toRoute(args: {'initialRoute': '/profile'});
        } else {
          NavigationService.of<HomeTabRoute>(pushContext).let((it) => it.pushNamed(route: it.root.profileTab));
          return CancelledRoute();
        }
      },
      routeBuilder: PlaceholderRoute('/tab/profile'));

  @override
  List<RouteBase> get children => [profileTab, homeTab];
}
