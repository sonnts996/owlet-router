import 'package:example/main_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:owlet_router/router.dart';

void main() {
  final NavigationService<MainRoute> navigatorServices =
      NavigationService<MainRoute>(
    navigationKey: GlobalKey<NavigatorState>(),
    routeObservers: [],
    route: MainRoute(),
    initialRoute: '/',
    finder: DefaultRouteFinder.cache(trailingSlash: true),
    unknownRoute: owletDefaultUnknownRoute,
  );

  if (kDebugMode) {
    /// Print all routes in your service.
    print(navigatorServices.route.listAll());
  }
  runApp(MyApp(service: navigatorServices));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.service});

  final NavigationService service;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Owlet Route Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
          // appBarTheme: const AppBarTheme(color: Colors.white),
          listTileTheme: ListTileThemeData(
              titleTextStyle: Typography.material2021().black.labelMedium,
              textColor: const Color(0xFF626262),
              iconColor: const Color(0xFF626262),
              selectedColor: const Color(0xFF626262)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                  foregroundColor: Colors.white)),
          textTheme: Typography.material2021().black.apply(
                bodyColor: const Color(0xFF424242),
                displayColor: const Color(0xFF424242),
              ),
          iconTheme: const IconThemeData(color: Color(0xFF424242))),

      /// Inject the service config into your app
      routerConfig: service.routerConfig,
    );
  }
}
