/*
 Created by Thanh Son on 01/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:owlet_router/router.dart';

import 'navigator_mock.dart';
import 'router.dart';

void main() {
  group('Navigator Test', () {
    final mockObserver = MockNavigatorObserver();
    final navigator = GlobalKey<NavigatorState>();
    final mainRoute = MainRoute();
    final navigationService = NavigationService(
        navigationKey: navigator,
        routeObservers: <NavigatorObserver>[mockObserver],
        initialRoute: '/',
        route: mainRoute,
        unknownRoute: mainRoute.routeNotFound);

    testWidgets('Test Navigator', (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp.router(routerConfig: navigationService.routerConfig),
      );

      await widgetTester.pumpAndSettle();

      expect(executor(
        () {
          final text = find.byType(Text).evaluate().single.widget as Text;
          return text.data;
        },
      ), 'Splash');

      mainRoute.home.page1.pushNamed();
      verifyNever(mockObserver.didPush(
          mainRoute.home.page1.build(
            RouteSettings(name: mainRoute.home.page1.path),
          )!,
          any));
      await widgetTester.pumpAndSettle();

      expect(executor(() async {
        final text = find.byType(Text).evaluate().single.widget as Text;
        return text.data;
      }), completion('Page 1'));

      final button = find.byType(ElevatedButton);
      await widgetTester.tap(button);
      verifyNever(mockObserver.didPush(
          mainRoute.home.page2.build(
            RouteSettings(name: mainRoute.home.page2.path),
          )!,
          any));
      await widgetTester.pumpAndSettle();

      expect(executor(() async {
        final text = find.byType(Text).evaluate().single.widget as Text;
        return text.data;
      }), completion('Hello, this page is opened by page 1'));
    });

    testWidgets('Test Action', (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp.router(routerConfig: navigationService.routerConfig),
      );

      await widgetTester.pumpAndSettle();

      // ignore: unnecessary_lambdas
      expect(() => mainRoute.home.action.pushNamed(), prints('Hello World\n'));
    });

    testWidgets('Test Guard', (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp.router(routerConfig: navigationService.routerConfig),
      );

      await widgetTester.pumpAndSettle();

      expect(() => mainRoute.home.guard.pushNamed(args: 'cancelled'), prints('cancelled\n'),
          reason: 'Check the route guard is running');

      mainRoute.home.guard.pushNamed(args: 'cancelled');
      verifyNever(mockObserver.didPush(
          mainRoute.home.guard.build(
            RouteSettings(name: mainRoute.home.guard.path),
          )!,
          any));
      await widgetTester.pumpAndSettle();

      expect(executor(() async {
        final text = find.byType(Text).evaluate().single.widget as Text;
        return text.data;
      }), completion('Splash'), reason: 'The route is cancelled by route guard');

      mainRoute.home.guard.pushNamed();
      verifyNever(mockObserver.didPush(
          mainRoute.home.guard.build(
            RouteSettings(name: mainRoute.home.guard.path),
          )!,
          any));
      await widgetTester.pumpAndSettle();

      expect(executor(() async {
        final text = find.byType(Text).evaluate().single.widget as Text;
        return text.data;
      }), completion('RouteGuard'), reason: 'The route is allowed by route guard');

      mainRoute.home.guard.pushNamed(args: 'redirect_named');
      verifyNever(mockObserver.didPush(
          mainRoute.home.guard.build(
            RouteSettings(name: mainRoute.home.guard.path),
          )!,
          any));
      await widgetTester.pumpAndSettle();

      expect(executor(() async {
        final text = find.byType(Text).evaluate().single.widget as Text;
        return text.data;
      }), completion('Page 1'), reason: 'The route is redirected by route guard');

      mainRoute.home.guard.pushNamed(args: 'redirect_itself');
      verifyNever(mockObserver.didPush(
          mainRoute.home.guard.build(
            RouteSettings(name: mainRoute.home.guard.path),
          )!,
          any));
      await widgetTester.pumpAndSettle();

      expect(executor(() async {
        final text = find.byType(Text).evaluate().single.widget as Text;
        return text.data;
      }), completion('RouteGuard'), reason: 'The route is redirected by route guard');

      mainRoute.home.guard.pushNamed(args: 'redirect_route');
      verifyNever(mockObserver.didPush(
          mainRoute.home.guard.build(
            RouteSettings(name: mainRoute.home.guard.path),
          )!,
          any));
      await widgetTester.pumpAndSettle();

      expect(executor(() async {
        final text = find.byType(Text).evaluate().single.widget as Text;
        return text.data;
      }), completion('Redirected'), reason: 'The route is redirected by route guard');
    });
  });
}

R executor<R>(R Function() func) => func();
