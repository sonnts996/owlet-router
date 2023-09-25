import 'package:example/src/main_routes.dart';
import 'package:flutter/material.dart';
import 'package:rowlet/rowlet.dart';

late final ROwletNavigationService<MainRoute> appNavigatorServices;

void main() {
  appNavigatorServices = ROwletNavigationService<MainRoute>(
      navigationKey: GlobalKey<NavigatorState>(),
      routeBase: MainRoute(),
      initialRoute: '/',
      routeObservers: [],
      routeNotFound: MaterialBuilder(
        '/page-not-found',
        materialBuilder: (context, settings) => const Scaffold(
          body: Center(child: Text('Page Not Found')),
        ),
      ));
  runApp(MyApp(service: appNavigatorServices));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.service});

  final ROwletNavigationService service;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: service.routerConfig,
    );
  }
}
