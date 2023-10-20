/*
 Created by Thanh Son on 27/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of owlet_router;

/// Data processing for [Navigator]
mixin NavigationServiceMixin on NavigationServiceBase {
  /// - In case [trailingSlash] is true and the URL with a trailing slash:
  ///   If the result is not found, a route without a trailing slash is replaced to continue finding.
  ///   Finally, if there is nothing to match, the null value will be returned.
  /// - If the Url is without a trailing slash:
  ///   A route without a trailing splash is the priority,
  ///   next is the route with a trailing splash, and finally this null value.
  /// - Otherwise, ([trailingSlash] is false), an exact URL must be used.
  bool get trailingSlash;

  /// If the route is not defined, [unknownRoute] with be returned.
  RouteBuilder? get unknownRoute;

  /// returns the origin route. The route in the root of the tree router.
  OriginRoute get routeBase;

  /// Returns a route matching this path (ignore query parameters)
  ///
  /// - In case [trailingSlash] is true and the URL with a trailing slash:
  ///   If the result is not found, a route without a trailing slash is replaced to continue finding.
  ///   Finally, if there is nothing to match, the null value will be returned.
  /// - If the Url is without a trailing slash:
  ///   A route without a trailing splash is the priority,
  ///   next is the route with a trailing splash, and finally this null value.
  /// - Otherwise, ([trailingSlash] is false), an exact URL must be used.
  ///
  /// - Only one [RouteBuilder] with a determined path in [routeBase]. But the [routeBase] can have multi [RouteSegment]
  /// with the same path (an instance of [RouteSegment] but not an instance of [RouteBuilder]).
  /// [findRoute] will prioritize to find a [RouteBuilder] matched, if can not, a [RouteSegment] will be considered.
  ///   If there are multi [RouteSegment] with the same path, the first result will be returned.
  @override
  RouteSegment? findRoute(String path) {
    final uri = Uri.parse(path);
    RouteSegment? route;
    if (uri.path.endsWith('/')) {
      route = routeBase.routes.routeWhere((element) => element.path == uri.path);
      if (trailingSlash && route == null) {
        route = routeBase.routes.routeWhere(
          (element) => element.path == uri.path.substring(0, uri.path.length - 1),
        );
      }
    } else {
      route = routeBase.routes.routeWhere((element) => element.path == uri.path);
      if (trailingSlash && route == null) {
        route = routeBase.routes.routeWhere((element) => element.path == '${uri.path}/');
      }
    }

    return route;
  }

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
  Route? onUnknownRoute(RouteSettings settings) => unknownRoute?.builder(settings);
}
