/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of router_service;

/// A navigation service is provided for router owlet information.
class NavigationServiceImpl<R extends RouteBase> implements NavigationService<R> {
  /// Create a service, which is provided for router owlet information.
  NavigationServiceImpl({
    GlobalKey<NavigatorState>? navigationKey,
    this.routeObservers = const [],
    required this.root,
    this.initialRoute = Navigator.defaultRouteName,
    RouteBuilder? unknownRoute,
    RouteFinderDelegate? finder,
    RouteHistory? history,
  })  : unknownRoute = unknownRoute ?? owletDefaultUnknownRoute,
        history = history ?? RouteHistoryImpl(),
        navigationKey = navigationKey ?? GlobalKey(),
        finder = finder ?? DefaultRouteFinder.cache(trailingSlash: true);

  /// If the route is not defined, [unknownRoute] with be returned.
  final RouteBuilder unknownRoute;

  @override
  final RouteFinderDelegate finder;

  @override
  final R root;

  @override
  final String initialRoute;

  @override
  final List<NavigatorObserver> routeObservers;

  @override
  final RouteHistory history;

  @override
  final GlobalKey<NavigatorState> navigationKey;

  RouterConfig<RouteMixin>? _routerConfig;

  @override
  RouterConfig<RouteMixin> get routerConfig {
    _routerConfig ??= RouterConfig(
      routerDelegate: OwletDelegate(service: this),
      routeInformationParser: OwletInformationParser(service: this),
      routeInformationProvider:
          PlatformRouteInformationProvider(initialRouteInformation: RouteInformation(uri: Uri.tryParse(initialRoute))),
    );
    return _routerConfig!;
  }

  @override
  RouteMixin? findRoute(String path) => finder.find(root, path);

  @override
  Route? onGenerateRoute(RouteSettings settings) {
    final route = settings.name?.let(findRoute);
    final routeBuilder = route?.let((it) => route is RouteBuilder ? route : null);

    return routeBuilder?.builder(settings);
  }

  @override
  bool onPopPage(Route route, dynamic result) {
    if (!route.didPop(result) || route.isFirst) {
      return false;
    }
    return result;
  }

  @override
  Route? onUnknownRoute(RouteSettings settings) => unknownRoute.builder(settings);

  @override
  void resetCache() {
    finder.resetCache(root);
  }
}
