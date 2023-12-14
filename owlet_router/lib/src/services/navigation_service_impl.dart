/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of 'router_services.dart';

///
/// The navigation service exposes Owlet Router information.
class NavigationServiceImpl<R extends RouteMixin> extends NavigationService<R> {
  ///
  /// Construct a [NavigationServiceImpl]
  NavigationServiceImpl({
    required this.route,
    GlobalKey<NavigatorState>? navigationKey,
    this.routeObservers = const [],
    this.initialRoute = Navigator.defaultRouteName,
    RouteBuilder? unknownRoute,
    RouteFinderDelegate? finder,
    RouteHistory? history,
  })  : unknownRoute = unknownRoute ?? owletDefaultUnknownRoute,
        history = history ?? RouteHistoryImpl(),
        navigationKey = navigationKey ?? GlobalKey(),
        finder = finder ?? DefaultRouteFinder.cache(trailingSlash: true),
        super.create();

  ///
  /// If the route is not defined, [unknownRoute] with be returned.
  final RouteBuilder unknownRoute;

  @override
  final RouteFinderDelegate finder;

  @override
  final R route;

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
      routerDelegate: OwletDelegate<R>(service: this),
      routeInformationParser: OwletInformationParser(service: this),
      routeInformationProvider: PlatformRouteInformationProvider(
        initialRouteInformation: RouteInformation(uri: Uri.tryParse(initialRoute)),
      ),
    );
    return _routerConfig!;
  }

  @override
  RouterConfig<RouteMixin> buildRouterConfig({
    TransitionDelegate transitionDelegate = const DefaultTransitionDelegate(),
    Clip clipBehavior = Clip.hardEdge,
    bool reportsRouteUpdateToEngine = false,
    bool requestFocus = true,
    String? restorationScopeId,
    TraversalEdgeBehavior routeTraversalEdgeBehavior = kDefaultRouteTraversalEdgeBehavior,
  }) {
    _routerConfig = RouterConfig(
      routerDelegate: OwletDelegate<R>(
        service: this,
        transitionDelegate: transitionDelegate,
        clipBehavior: clipBehavior,
        reportsRouteUpdateToEngine: reportsRouteUpdateToEngine,
        requestFocus: requestFocus,
        restorationScopeId: restorationScopeId,
        routeTraversalEdgeBehavior: routeTraversalEdgeBehavior,
      ),
      routeInformationParser: OwletInformationParser(service: this),
      routeInformationProvider: PlatformRouteInformationProvider(
        initialRouteInformation: RouteInformation(uri: Uri.tryParse(initialRoute)),
      ),
    );
    return _routerConfig!;
  }

  @override
  RouteMixin? findRoute(String path) => finder.find(route, path);

  @override
  Route? onGenerateRoute(RouteSettings settings) {
    final route = settings.name?.let(findRoute);
    final routeBuilder = route?.let((it) => route is RouteBuilderMixin ? route : null);

    final finalRoute = routeBuilder?.build(settings);

    if (routeBuilder != null && finalRoute == null) {
      debugPrint('"${settings.name}" is a launchable route, but a route cannot be found within it.');
    }
    return finalRoute;
  }

  @override
  // ignore: type_annotate_public_apis
  bool onPopPage(Route route, result) {
    if (!route.didPop(result) || route.isFirst) {
      return false;
    }
    return result;
  }

  @override
  Route? onUnknownRoute(RouteSettings settings) => unknownRoute.build(settings);

  @override
  void resetCache() {
    finder.resetCache(route);
  }
}
