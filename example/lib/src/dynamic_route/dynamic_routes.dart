/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/main.dart';
import 'package:example/src/dynamic_route/pages/premium_page.dart';
import 'package:owlet_router/router.dart';

class DynamicRoutes extends RouteBase {
  DynamicRoutes(super.segment);

  RouteBuilder? premiumPage;

  void upgradeToPremium() {
    // In default, [premiumPage] was not mapped to any page.
    // After call [upgradeToPremium], premiumPage will be mapped to PremiumPage();
    premiumPage = MaterialRouteBuilder(
      '/premiumPage',
      pageBuilder: (context, settings) => const PremiumPage(),
    );
    // If your origin route is in stability mode, must be called commit(); to apply the change.
    navigatorServices.resetCache();
    // repair();
    print(navigatorServices.root.listOut());
  }

  void downgradeToPremium() {
    // In default, [premiumPage] was not mapped to any page.
    // After call [downgradeToPremium], premiumPage will be remove the mapper;
    premiumPage = MaterialRouteBuilder(
      '/premiumPage',
      pageBuilder: null,
    );
    // If your origin route is in stability mode, must be called commit(); to apply the change.
    navigatorServices.resetCache();
  }

  @override
  List<RouteBase> get children => premiumPage != null ? [premiumPage!] : [];
}
