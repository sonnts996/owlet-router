/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of owlet_router;

/// Create [RouterDelegate] of [RouteBase], only one [Navigator] in this delegate.
/// If the route path is not found, a [ROwletNavigationService.routeNotFound] will be returned.
/// If the route is located and can not be built, an exception with the thrown.
class ROwletDelegate extends RouterDelegate<RouteBuilder> with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  /// Required [ROwletNavigationService] to router
  ROwletDelegate({required this.service});

  /// Required [ROwletNavigationService] to router. This provided for router owlet information.
  final ROwletNavigationService service;

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
