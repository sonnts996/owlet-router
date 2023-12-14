import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:owlet_router/router.dart';

import 'gen/injections.dart';
import 'main_routes.dart';
import 'src/utilities/utilities.dart';
import 'src/widgets/page_not_found.dart';
import 'src/widgets/responsive_layout.dart';

void main() {
  configureDependencies();

  final navigatorServices = NavigationService<MainRoute>(
      navigationKey: GlobalKey<NavigatorState>(),
      routeObservers: [],
      route: MainRoute(),
      initialRoute: '/',
      finder: DefaultRouteFinder.cache(trailingSlash: true),
      unknownRoute: RouteBuilder('/page-route-found',
          builder: (settings) => MaterialPageRoute(
                builder: (context) => PageNotFound(),
              )));

  if (kDebugMode) {
    /// Print all routes in your service.
    navigatorServices.route.printAll();
  }
  runApp(MyApp(service: navigatorServices));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.service});

  final NavigationService service;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Owlet Route Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            useMaterial3: true,
            scaffoldBackgroundColor: const Color(0xFFf5f5f5),
            dividerColor: Color(0xFFaaaaaa),
            appBarTheme: AppBarTheme(
                elevation: 0,
                shadowColor: Colors.black54,
                color: const Color(0xFFf5f5f5),
                surfaceTintColor: Colors.white,
                titleTextStyle: Typography.material2021().black.titleMedium,
                iconTheme: const IconThemeData(color: Color(0xFF424242))),
            listTileTheme: ListTileThemeData(
                titleTextStyle: textTheme.labelMedium,
                dense: isDesktopMode,
                textColor: const Color(0xFF626262),
                iconColor: const Color(0xFF626262),
                selectedColor: Colors.indigoAccent,
                selectedTileColor: Colors.indigo.shade50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigoAccent, foregroundColor: Colors.white)),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    minimumSize: const Size(50, 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)))),
            textTheme: textTheme.apply(
              bodyColor: const Color(0xFF424242),
              displayColor: const Color(0xFF424242),
            ),
            iconTheme: const IconThemeData(color: Color(0xFF424242))),

        /// Inject the service config into your app
        routerConfig: service.buildRouterConfig(reportsRouteUpdateToEngine: true),
        builder: (context, child) => ResponsiveLayoutWatcher(child: child!),
      );
}
