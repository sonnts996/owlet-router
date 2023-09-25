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
      expect(() => RouteBase('home').fullRoute, throwsAssertionError);
      expect(RouteBase('/home').fullRoute, '/home');
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
    final mainRoute = MainRoute('/');
    final navigationService = ROwletNavigationService(
        navigationKey: GlobalKey(),
        routeObservers: [],
        initialRoute: '/',
        routeBase: mainRoute,
        routeNotFound: mainRoute.routeNotFound);

    /// Print all accepted routes
    navigationService.allRoute().print();

    test('route parser', () {
      expect(mainRoute.splash.fullRoute, '/');
      expect(mainRoute.home.fullRoute, '/home');
      expect(mainRoute.home.page1.fullRoute, '/home/page1');
      expect(mainRoute.home.page2.fullRoute, '/home/page2');
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
    final mainRoute = MainRoute('/');
    final navigationService = ROwletNavigationService(
        navigationKey: GlobalKey(),
        routeObservers: [],
        initialRoute: '/',
        routeBase: mainRoute,
        trailingSlash: false,
        routeNotFound: mainRoute.routeNotFound);

    test('find route', () {
      expect(navigationService.findRoute('/'), mainRoute.splash);
      expect(navigationService.findRoute('/home'), mainRoute.home);
      expect(navigationService.findRoute('/home/'), mainRoute.routeNotFound);
      expect(navigationService.findRoute('/home/page1'), mainRoute.home.page1);
      expect(navigationService.findRoute('/home/page2'), mainRoute.home.page2);
    });
  });

  group('Navigator Test', () {
    final mockObserver = MockNavigatorObserver();
    final navigator = GlobalKey<NavigatorState>();
    final mainRoute = MainRoute('/');
    final navigationService = ROwletNavigationService(
        navigationKey: navigator,
        routeObservers: [mockObserver],
        initialRoute: '/',
        routeBase: mainRoute,
        routeNotFound: mainRoute.routeNotFound);

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
            navigator.currentContext!,
            RouteSettings(name: mainRoute.home.page1.fullRoute),
          ),
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
            navigator.currentContext!,
            RouteSettings(name: mainRoute.home.page2.fullRoute),
          ),
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
  MainRoute(super.path);

  final routeNotFound = MaterialBuilder('/routeNotFound');
  final home = HomeRoute('/home');
  final splash = MaterialBuilder(
    '/',
    materialBuilder: (context, settings) => TestApp(content: 'Splash'),
  );

  @override
  List<RouteBase> get routes => [home, splash];
}

class HomeRoute extends RouteBase {
  HomeRoute(super.path);

  late final page1 = RouteBuilder(
    '/page1',
    builder: (context, settings) => MaterialPageRoute(
      builder: (context) => TestApp(
        content: 'Page 1',
        onTab: () {
          page2.pushNamed(context, args: 'Hello, this page is opened by page 1');
        },
      ),
    ),
  );

  final page2 = RouteBuilder<String>(
    '/page2',
    builder: (context, settings) {
      final greeting = settings.arguments.castTo<String>() ?? 'Page 2';
      return MaterialPageRoute(
        builder: (context) => TestApp(content: greeting),
      );
    },
  );

  @override
  List<RouteBase> get routes => [page1, page2];
}

R executor<R>(R Function() func) => func();
