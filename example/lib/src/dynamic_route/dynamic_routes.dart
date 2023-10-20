/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/main.dart';
import 'package:example/src/dynamic_route/pages/premium_page.dart';
import 'package:example/src/dynamic_route/pages/premium_upgrade_page.dart';
import 'package:rowlet/rowlet.dart';

class DynamicRoutes extends RouteSegment {
  DynamicRoutes(super.segmentPath);

  RouteBuilder premiumPage = MaterialRouteBuilder('/premiumPage');

  void upgradeToPremium() {
    // In default, [premiumPage] was not mapped to any page.
    // After call [upgradeToPremium], premiumPage will be mapped to PremiumPage();
    premiumPage = MaterialRouteBuilder(
      '/premiumPage',
      pageBuilder: (context, settings) => const PremiumPage(),
    );
    // If your origin route is in stability mode, must be called commit(); to apply the change.
    navigatorServices.routeBase.commit();
  }

  void downgradeToPremium() {
    // In default, [premiumPage] was not mapped to any page.
    // After call [downgradeToPremium], premiumPage will be remove the mapper;
    premiumPage = MaterialRouteBuilder(
      '/premiumPage',
      pageBuilder: null,
    );
    // If your origin route is in stability mode, must be called commit(); to apply the change.
    navigatorServices.routeBase.commit();
  }

  final upgrade = MaterialRouteBuilder(
    '/upgrade_premium',
    pageBuilder: (context, settings) => const PremiumUpgradePage(),
  );

  @override
  List<RouteSegment> get children => [upgrade, premiumPage];
}
