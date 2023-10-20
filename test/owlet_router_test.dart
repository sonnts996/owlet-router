import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:objectx/objectx.dart';
import 'package:rowlet/rowlet.dart';

import 'navigator_mock.dart';

void main() {
  group('Route assert', () {
    late RouteSet sets;

    setUp(() {
      sets = RouteSet();
    });

    test('route path', () {
      expect(() => RouteSegment('home').path, throwsAssertionError);
      expect(RouteSegment('/home').path, '/home');
    });

    test('Duplicate Base Path', () {
      expect((() {
        sets.add(RouteSegment('/'));
        sets.add(RouteSegment('/'));
        sets.add(RouteBuilder('/'));
        return sets.length;
      })(), 3);
    });

    test('Duplicate Builder Path', () {
      expect(() {
        sets.add(RouteSegment('/'));
        sets.add(RouteBuilder('/'));
        sets.add(RouteBuilder('/'));
        return sets.length;
      }, throwsException);
    });
  });
  group('Navigation', () {
    final mainRoute = MainRoute();
    final navigationService = ROwletNavigationService(
        navigationKey: GlobalKey(),
        routeObservers: [],
        initialRoute: '/',
        routeBase: mainRoute,
        unknownRoute: mainRoute.routeNotFound);

    /// Print all accepted routes
    navigationService.allRoute().print();

    test('route parser', () {
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
  });

  group('Navigation without trailing splash', () {
    final mainRoute = MainRoute();
    final navigationService = ROwletNavigationService(
        navigationKey: GlobalKey(),
        routeObservers: [],
        initialRoute: '/',
        routeBase: mainRoute,
        trailingSlash: false,
        unknownRoute: mainRoute.routeNotFound);

    test('find route', () {
      expect(navigationService.findRoute('/'), mainRoute.splash);
      expect(navigationService.findRoute('/home'), mainRoute.home);
      expect(navigationService.findRoute('/home/'), null);
      expect(navigationService.findRoute('/home/page1'), mainRoute.home.page1);
      expect(navigationService.findRoute('/home/page2'), mainRoute.home.page2);
    });
  });

  group('Navigator Test', () {
    final mockObserver = MockNavigatorObserver();
    final navigator = GlobalKey<NavigatorState>();
    final mainRoute = MainRoute();
    final navigationService = ROwletNavigationService(
        navigationKey: navigator,
        routeObservers: <NavigatorObserver>[mockObserver],
        initialRoute: '/',
        routeBase: mainRoute,
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

      mainRoute.home.page1.pushNamed(navigator.currentContext!);
      verifyNever(mockObserver.didPush(
          mainRoute.home.page1.builder(
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
          mainRoute.home.page2.builder(
            RouteSettings(name: mainRoute.home.page2.path),
          )!,
          any));
      await widgetTester.pumpAndSettle();

      expect(executor(() async {
        final text = find.byType(Text).evaluate().single.widget as Text;
        return text.data;
      }), completion('Hello, this page is opened by page 1'));
    });
  });
}

class TestApp extends StatelessWidget {
  const TestApp({super.key, this.content = 'TestApp', this.onTab});

  final String content;
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) =>
      onTab?.let((it) => Placeholder(
            child: ElevatedButton(
              onPressed: it,
              child: Text(content),
            ),
          )) ??
      Placeholder(
        child: Text(content),
      );
}

class MainRoute extends OriginRoute {
  MainRoute();

  final routeNotFound = MaterialRouteBuilder('/routeNotFound');
  final home = HomeRoute('/home');
  final splash = MaterialRouteBuilder(
    '/',
    pageBuilder: (context, settings) => TestApp(content: 'Splash'),
  );

  @override
  List<RouteSegment> get children => [home, splash];
}

class HomeRoute extends RouteSegment {
  HomeRoute(super.segmentPath);

  late final page1 = RouteBuilder(
    '/page1',
    builder: (settings) => MaterialPageRoute(
      builder: (context) => TestApp(
        content: 'Page 1',
        onTab: () {
          page2.pushNamed(context, args: 'Hello, this page is opened by page 1');
        },
      ),
    ),
  );

  final page2 = RouteBuilder<String, dynamic>(
    '/page2',
    builder: (settings) {
      final greeting = settings.arguments.castTo<String>() ?? 'Page 2';
      return MaterialPageRoute(
        builder: (context) => TestApp(content: greeting),
      );
    },
  );

  @override
  List<RouteSegment> get children => [page1, page2];
}

R executor<R>(R Function() func) => func();
