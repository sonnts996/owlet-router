/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of owlet_router;

class ROwletDelegate extends RouterDelegate<RouteBuilder> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  ROwletDelegate({required this.service});

  final NavigationService service;
  RouteBuilder<Object>? _currentConfiguration;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => service.navigationKey;

  @override
  Widget build(BuildContext context) => Navigator(
        key: service.navigationKey,
        initialRoute: service.initialRoute.path,
        observers: service.routeObservers,
        onGenerateRoute: (settings) {
          final route = settings.name?.let(service.findRoute);
          final routeBuilder = route?.let((it) => route is RouteBuilder ? route : null) ??
              service._finalRouteNotFound(settings.name ?? 'null');

          return routeBuilder.builder(context, settings);
        },
        onPopPage: (route, result) {
          if (!route.didPop(result) || route.isFirst) {
            return false;
          }
          return result;
        },
      );

  @override
  RouteBuilder<Object>? get currentConfiguration => _currentConfiguration;

  @override
  Future<void> setNewRoutePath(RouteBuilder<Object> configuration) async {
    _currentConfiguration = configuration;
    notifyListeners();
  }
}
