import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:objectx/objectx.dart';
import 'package:owlet_router/router.dart';

import 'router.dart';

void main() {
  group('Route Test', () {
    test('segment verify', () {
      expect(RouteBase('/this-is-a-route').path, '/this-is-a-route');
      expect(() => RouteBase('/this-is-a-route?id=123'), throwsAssertionError);
      expect(() => RouteBase('/this-is-a-route#fragment'), throwsAssertionError);
      expect(() => RouteBase('this-is-a-route'), throwsAssertionError);
    });
  });

  group('Navigation', () {
    final mainRoute = MainRoute();

    test('Route parser', () {
      expect(mainRoute.splash.path, '/');
      expect(mainRoute.home.path, '/home');
      expect(mainRoute.home.page1.path, '/home/page1');
      expect(mainRoute.home.page2.path, '/home/page2');
    });

    final navigationService = NavigationService(
        navigationKey: GlobalKey(),
        routeObservers: [],
        initialRoute: '/',
        route: mainRoute,
        unknownRoute: mainRoute.routeNotFound);

    /// Print all accepted routes
    navigationService.route.listAll().print();

    test('find route', () {
      expect(navigationService.findRoute('/'), mainRoute.splash);
      expect(navigationService.findRoute('/home'), mainRoute.home.home);
      expect(navigationService.findRoute('/home/'), mainRoute.home.home);
      expect(navigationService.findRoute('/home/page1'), mainRoute.home.page1);
      expect(navigationService.findRoute('/home/page2'), mainRoute.home.page2);
    });

    test("Route's Flag", () {
      expect(navigationService.route.canLaunch, false);
      expect(navigationService.route.isCallback, false);
      expect(navigationService.findRoute('/')?.canLaunch, true);
      expect(navigationService.findRoute('/home')?.canLaunch, true);
      expect(navigationService.findRoute('/home/')?.canLaunch, true);
      expect(navigationService.findRoute('/home/action')?.canLaunch, true);
      expect(navigationService.findRoute('/home/action')?.isCallback, true);
      expect(navigationService.findRoute('/home/guard')?.canLaunch, true);
      expect(navigationService.findRoute('/home/guard')?.isCallback, false);
    });
  });

  group('Navigation without trailing splash', () {
    final mainRoute = MainRoute();
    final navigationService = NavigationService(
        navigationKey: GlobalKey(),
        routeObservers: [],
        initialRoute: '/',
        finder: DefaultRouteFinder(trailingSlash: false),
        route: mainRoute,
        unknownRoute: mainRoute.routeNotFound);

    test('find route', () {
      expect(navigationService.findRoute('/'), mainRoute.splash);
      expect(navigationService.findRoute('/home'), null);
      expect(navigationService.findRoute('/home/'), mainRoute.home.home);
      expect(navigationService.findRoute('/home/page1'), mainRoute.home.page1);
      expect(navigationService.findRoute('/home/page2'), mainRoute.home.page2);
    });
  });
}
