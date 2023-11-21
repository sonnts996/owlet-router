/*
 Created by Thanh Son on 26/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of owlet_router;

/// Provides the necessary method for a new [Navigator]:
///
/// Example:
///
///```
///  Navigator(
//         key: service.navigationKey,
//         initialRoute: service.initialRoute,
//         observers: <NavigatorObserver>[service.history, ...service.routeObservers],
//         onGenerateRoute: service.onGenerateRoute,
//         onPopPage: service.onPopPage,
//         onUnknownRoute: service.onUnknownRoute,
//       );
///```
abstract class NavigationService<R extends RouteMixin> {
  /// Create a default [NavigationServiceImpl]
  factory NavigationService({
    GlobalKey<NavigatorState>? navigationKey,
    List<NavigatorObserver> routeObservers,
    String initialRoute,
    RouteBuilder? unknownRoute,
    required R route,
    RouteFinderDelegate? finder,
    RouteHistory? history,
  }) = NavigationServiceImpl;

  /// Create a new [NavigationService], it will inject the service into the root route.
  NavigationService.create() {
    route._service = this;
  }

  /// Get the nearest NavigationService<R> in the [context]. It requires the [OwletNavigator] must be used.
  static NavigationService<R>? maybeOf<R extends RouteMixin>(BuildContext context, {bool useRoot = false}) {
    final root = context.findRootAncestorStateOfType<NavigatorState>();

    if (useRoot) {
      if (root is OwletNavigatorState && root.service is NavigationService<R>) {
        return root.service.castTo<NavigationService<R>?>();
      }
    } else {
      var findContext = context;
      do {
        final navigator = findContext.findAncestorStateOfType<OwletNavigatorState>();
        if (navigator?.service is NavigationService<R>) {
          return navigator!.service.castTo<NavigationService<R>?>();
        } else if (navigator != null && navigator != root) {
          findContext = navigator.context;
        } else {
          break;
        }
      } while (true);
    }
    return null;
  }

  /// Get the nearest NavigationService<R> in the [context]. It requires the [OwletNavigator] must be used.
  static NavigationService<R> of<R extends RouteMixin>(BuildContext context, {bool useRoot = false}) {
    final result = maybeOf<R>(context, useRoot: useRoot);
    assert(result != null, 'No ${NavigationService<R>} found in context');
    return result!;
  }

  /// Global Navigation Key for this module
  GlobalKey<NavigatorState> get navigationKey;

  /// Route Observers for this module
  List<NavigatorObserver> get routeObservers;

  /// The first route is generated when the app starts.
  String get initialRoute;

  /// The current routes list.
  RouteHistory get history;

  /// returns RouterConfig<RouteSegment> for this app.
  ///
  /// Example:
  /// ```
  ///  MaterialApp.router(routerConfig: navigationService.routerConfig));
  /// ```
  ///
  RouterConfig<RouteMixin> get routerConfig;

  /// returns the origin route. The route in the root of the router tree.
  R get route;

  /// The router uses this as a [RouteMixin] finder, which matches the input path.
  RouteFinderDelegate get finder;

  /// Return a route matching this path (ignore query parameters).
  /// Return null if can not found the route.
  RouteMixin? findRoute(String path);

  /// Mapping to [Navigator.onGenerateRoute], when a route name is pushed, [onGenerateRoute] is called to generate a new route.
  Route? onGenerateRoute(RouteSettings settings);

  /// Mapping to [Navigator.onPopPage], [onPopPage] is called when a pop is called.
  bool onPopPage(Route route, dynamic result);

  ///  Mapping to [Navigator.onUnknownRoute], [onUnknownRoute] is called when the [onGenerateRoute] returns null, or anything makes the final route null.
  Route<dynamic>? onUnknownRoute(RouteSettings settings);

  /// Call to scan and build router in the route tree
  void resetCache();

  @override
  String toString() => '$runtimeType(route: $route)';
}
