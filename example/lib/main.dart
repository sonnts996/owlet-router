import 'package:example/main_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rowlet/rowlet.dart';

late final ROwletNavigationService<MainRoute> navigatorServices;

void main() {
  navigatorServices = ROwletNavigationService<MainRoute>(
      navigationKey: GlobalKey<NavigatorState>(),
      routeBase: MainRoute(),
      initialRoute: '/',
      routeObservers: [],
      unknownRoute: MaterialRouteBuilder(
        '/page-not-found',
        pageBuilder: (context, settings) => Scaffold(
          appBar: AppBar(title: const Text('Page Not Found:')),
          body: Center(child: Text('Page Not Found: ${settings.name}')),
        ),
      ))
    ..history.addListener(() {
      /// Listen when routes change.
      if (kDebugMode) {
        print(navigatorServices.history);
      }
    });
  runApp(MyApp(service: navigatorServices));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.service});

  final ROwletNavigationService service;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
          elevatedButtonTheme:
              ElevatedButtonThemeData(style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50))),
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
