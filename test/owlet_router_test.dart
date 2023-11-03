import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:objectx/objectx.dart';
import 'package:owlet_router/router.dart';
import 'package:owlet_router/src/route/route_base.dart';

import 'router.dart';

void main() {
  group('Route assert', () {
    late RouteSet sets;

    setUp(() {
      sets = RouteSet();
    });

    test('Route path', () {
      expect(() => RouteBase('home').path, throwsAssertionError);
      expect(RouteBase('/home').path, '/home');
    });

    test('Duplicate Base Path', () {
      expect((() {
        sets.add(RouteBase('/'));
        sets.add(RouteBase('/'));
        sets.add(RouteBuilder('/'));
        return sets.length;
      })(), 3);
    });

    test('Duplicate Builder Path', () {
      expect(() {
        sets.add(RouteBase('/'));
        sets.add(RouteBuilder('/'));
        sets.add(RouteBuilder('/'));
        return sets.length;
      }, throwsException);
    });
  });
  group('Navigation', () {
    final mainRoute = MainRoute();
    final navigationService = NavigationService(
        navigationKey: GlobalKey(),
        routeObservers: [],
        initialRoute: '/',
        root: mainRoute,
        unknownRoute: mainRoute.routeNotFound);

    /// Print all accepted routes
    navigationService.root.listOut().print();

    test('Route parser', () {
      expect(mainRoute.splash.path, '/');
      expect(mainRoute.home.path, '/home');
      expect(mainRoute.home.page1.path, '/home/page1');
      expect(mainRoute.home.page2.path, '/home/page2');
    });

    test('find route', () {
      expect(navigationService.findRoute('/'), mainRoute.splash);
      expect(navigationService.findRoute('/home'), mainRoute.home);
      expect(navigationService.findRoute('/home/'), mainRoute.home);
      expect(navigationService.findRoute('/home/page1'), mainRoute.home.page1);
      expect(navigationService.findRoute('/home/page2'), mainRoute.home.page2);
    });

    test("Route's Flag", () {
      expect(navigationService.root.canLaunch, false);
      expect(navigationService.root.isCallback, false);
      expect(navigationService.findRoute('/')?.canLaunch, true);
      expect(navigationService.findRoute('/home')?.canLaunch, false);
      expect(navigationService.findRoute('/home')?.isCallback, false);
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
        root: mainRoute,
        unknownRoute: mainRoute.routeNotFound);

    test('find route', () {
      expect(navigationService.findRoute('/'), mainRoute.splash);
      expect(navigationService.findRoute('/home'), mainRoute.home);
      expect(navigationService.findRoute('/home/'), null);
      expect(navigationService.findRoute('/home/page1'), mainRoute.home.page1);
      expect(navigationService.findRoute('/home/page2'), mainRoute.home.page2);
    });
  });
}
