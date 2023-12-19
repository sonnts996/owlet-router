/*
 Created by Thanh Son on 18/12/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter_test/flutter_test.dart';
import 'package:owlet_router/router.dart';

void main() {
  test(
    'Trailing slash',
    () => () {
      final appRoute = AppRoute('/');
      final finder = DefaultRouteFinder(trailingSlash: true);
      expect(finder.find(appRoute, '/')?.canLaunch, true);
      expect(finder.find(appRoute, '/home')?.canLaunch, true);
      expect(finder.find(appRoute, '/home/')?.canLaunch, true);
      expect(finder.find(appRoute, '/splash')?.canLaunch, true);
      expect(finder.find(appRoute, '/home/splash')?.canLaunch, true);
    },
  );

  test(
    'Without Trailing slash',
    () => () {
      final appRoute = AppRoute('/');
      final finder = DefaultRouteFinder(trailingSlash: false);
      expect(finder.find(appRoute, '/')?.canLaunch, false);
      expect(finder.find(appRoute, '/home')?.canLaunch, false);
      expect(finder.find(appRoute, '/home/')?.canLaunch, false);
      expect(finder.find(appRoute, '/splash')?.canLaunch, false);
      expect(finder.find(appRoute, '/home/splash')?.canLaunch, false);

      expect(finder.find(appRoute, '/home')?.canLaunch, true);
      expect(finder.find(appRoute, '/home/splash')?.canLaunch, true);
    },
  );
}

class AppRoute extends RouteBase {
  AppRoute(super.segment);

  final lvl1 = RouteLvl1('/');

  @override
  List<RouteMixin> get children => [lvl1];
}

class RouteLvl1 extends RouteBase {
  RouteLvl1(super.segment);

  final lvl2 = RouteLvl2('/');
  final home = RouteLvl2('/home');

  @override
  List<RouteMixin> get children => [lvl2, home];
}

class RouteLvl2 extends RouteBase {
  RouteLvl2(super.segment);

  final lvl3 = RouteBuilder('/');
  final splash = RouteBuilder('/splash');

  @override
  List<RouteMixin> get children => [lvl3, splash];
}
