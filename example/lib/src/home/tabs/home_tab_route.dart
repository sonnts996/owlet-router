/*
 Created by Thanh Son on 06/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/cupertino.dart';
import 'package:owlet_router/router.dart';

import 'profile/home_tab.dart';
import 'profile/profile_tab.dart';

class HomeTabRoute extends RouteBase {
  HomeTabRoute(super.segment);

  static NavigationService<HomeTabRoute> tabService(BuildContext context) =>
      NavigationService.of<HomeTabRoute>(context);

  static Route? openHomeTab(BuildContext context, _) {
    final service = tabService(context);
    if (!service.history.contains(service.root.homeTab.path)) {
      return null;
    } else {
      Navigator.popUntil(context, service.root.homeTab.isRoute);
      return CancelledRoute();
    }
  }

  static Route? openProfileTab(BuildContext context, _) {
    final service = tabService(context);
    if (!service.history.contains(service.root.profileTab.path)) {
      return null;
    } else {
      Navigator.popUntil(context, service.root.profileTab.isRoute);
      return CancelledRoute();
    }
  }

  final homeTab = RouteGuardBuilder(
      routeGuard: openHomeTab,
      routeBuilder: MaterialRouteBuilder('/', pageBuilder: (context, settings) => const HomeTab()));

  final profileTab = RouteGuardBuilder(
      routeGuard: openProfileTab,
      routeBuilder: MaterialRouteBuilder('/profile', pageBuilder: (context, settings) => const ProfileTab()));

  @override
  List<RouteBase> get children => [homeTab, profileTab];
}
