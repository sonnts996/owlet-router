import 'package:example/main_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:owlet_router/router.dart';

late final NavigationService<MainRoute> navigatorServices;

void main() {
  navigatorServices = NavigationService<MainRoute>(
    navigationKey: GlobalKey<NavigatorState>(),
    routeObservers: [],
    root: MainRoute(),
    initialRoute: '/',
    finder: DefaultRouteFinder.cache(trailingSlash: true),
    unknownRoute: owletDefaultUnknownRoute,
  )..history.addListener(() {
      /// Listen when routes change.
      if (kDebugMode) {
        print(navigatorServices.history);
      }
    });

  if (kDebugMode) {
    print(navigatorServices.root.listOut());
  }
  runApp(MyApp(service: navigatorServices));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.service});

  final NavigationService service;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  // minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.indigoAccent,
                  foregroundColor: Colors.white)),
          dividerTheme: DividerThemeData(
            color: Colors.grey.shade300,
            thickness: 1,
            space: 16,
            indent: 16,
            endIndent: 16,
          )),
      routerConfig: service.routerConfig,
    );
  }
}
