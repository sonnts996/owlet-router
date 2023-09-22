/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of owlet_router;

/// A navigation service is provided for router owlet information.
class ROwletNavigationService<R extends RouteBase> {
  /// Create a service, which is provided for router owlet information.
  ROwletNavigationService({
    required this.navigationKey,
    required this.routeObservers,
    RouteBuilder? initialRoute,
    this.routeNotFound,
    this.routeBase,
    this.trailingSlash = true,
  }) : initialRoute = initialRoute ?? RouteBuilder('/');

  /// Global Navigation Key for this module
  final GlobalKey<NavigatorState> navigationKey;

  /// Route Observers for this module
  final List<NavigatorObserver> routeObservers;

  ///The first route is generated when the app starts.
  final RouteBuilder initialRoute;

  /// If the route is not defined or any error when generated, [routeNotFound] with be returned.
  /// and [PathNotFoundException] if routeNotFound is null when called.
  final RouteBuilder? routeNotFound;

  /// In case [trailingSlash] is true and the URL with a trailing slash,
  /// If the result is not found, a route without a trailing slash is replaced to continue finding.
  /// Finally, if there is nothing to match, [routeNotFound] is the last result.
  /// If the Url is without a trailing slash, a route without a trailing splash is the priority, next is the route with a trailing splash, and finally this [routeNotFound].
  ///
  /// Otherwise, [trailingSlash] is false), an exact URL must be used.
  final bool trailingSlash;

  /// return the top route parent, a route tree must be defined when used owlet_router.
  /// if [routeBase] is null, [initialRoute] will be used to replace it.
  final R? routeBase;

  /// return RouterConfig<RouteBase> for this app.
  ///
  /// Example:
  /// ```
  ///  MaterialApp.router(routerConfig: navigationService.routerConfig));
  /// ```
  ///
  RouterConfig<RouteBase> get routerConfig => RouterConfig(
        routerDelegate: ROwletDelegate(service: this),
        routeInformationParser: ROwletInformationParser(service: this),
        routeInformationProvider:
            PlatformRouteInformationProvider(initialRouteInformation: RouteInformation(uri: initialRoute.uri)),
      );

  RouteBase get _routeBase => routeBase ?? initialRoute;

  /// For Testing, this method returns a list of accepted routes in this [routeBase]
  @visibleForTesting
  List<RouteBase> allRoute() => _routeBase._routes._list;

  RouteBuilder _finalRouteNotFound(String path) =>
      routeNotFound ??
      (throw PathNotFoundException(
        devDescription: 'routeNotFound is null and $path not found',
        error: '$path not found',
      ));

  /// Return a route matching this path (ignore query parameters)
  ///
  /// - In case [trailingSlash] is true and the URL with a trailing slash,
  /// If the result is not found, a route without a trailing slash is replaced to continue finding.
  /// Finally, if there is nothing to match, [routeNotFound] is the last result.
  /// If the Url is without a trailing slash, a route without a trailing splash is the priority, next is the route with a trailing splash, and finally this [routeNotFound].
  ///
  /// - Otherwise, ([trailingSlash] is false), an exact URL must be used.
  ///
  /// - Only one [RouteBuilder] with a determined path in [routeBase]. But the [routeBase] can have multi [RouteBase]
  /// with the same path (an instance of [RouteBase] but not an instance of [RouteBuilder]).
  /// [findRoute] will prioritize to find a [RouteBuilder] matched, if can not, a [RouteBase] will be considered.
  ///   If there are multi [RouteBase] with the same path, the first result will be returned.
  ///
  /// - If [routeNotFound] is null, a [PathNotFoundException] will be thrown
  RouteBase findRoute(String path) {
    final uri = Uri.parse(path);
    RouteBase? route;
    if (uri.path.endsWith('/')) {
      route = _routeBase._routes.routeWhere((element) => element.fullRoute == uri.path);
      if (trailingSlash && route == null) {
        route = _routeBase._routes.routeWhere(
          (element) => element.fullRoute == uri.path.substring(0, uri.path.length - 1),
        );
      }
    } else {
      route = _routeBase._routes.routeWhere((element) => element.fullRoute == uri.path);
      if (trailingSlash && route == null) {
        route = _routeBase._routes.routeWhere((element) => element.fullRoute == '${uri.path}/');
      }
    }

    return route ?? _finalRouteNotFound(path);
  }
}
