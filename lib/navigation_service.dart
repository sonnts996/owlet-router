/*
 Created by Thanh Son on 26/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of owlet_router;

///
/// The navigation service exposes Owlet Router information.
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
  ///
  /// Create a default [NavigationService]
  factory NavigationService({
    GlobalKey<NavigatorState>? navigationKey,
    List<NavigatorObserver> routeObservers,
    String initialRoute,
    RouteBuilder? unknownRoute,
    required R route,
    RouteFinderDelegate? finder,
    RouteHistory? history,
  }) = NavigationServiceImpl;

  ///
  /// Create a new [NavigationService], it will inject the service into the root route.
  NavigationService.create() {
    route._service = this;
  }

  ///
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

  ///
  /// Get the nearest NavigationService<R> in the [context]. It requires the [OwletNavigator] must be used.
  static NavigationService<R> of<R extends RouteMixin>(BuildContext context, {bool useRoot = false}) {
    final result = maybeOf<R>(context, useRoot: useRoot);
    assert(result != null, 'No ${NavigationService<R>} found in context');
    return result!;
  }

  ///
  /// Global navigation key for this service
  GlobalKey<NavigatorState> get navigationKey;

  ///
  /// Route observers for this service
  List<NavigatorObserver> get routeObservers;

  ///
  /// The first route is generated when the app starts.
  String get initialRoute;

  ///
  /// The current routes list.
  RouteHistory get history;

  ///
  /// returns [RouterConfig]  to use in the [WidgetsApp.router]
  ///
  /// Example:
  /// ```
  ///  MaterialApp.router(routerConfig: navigationService.routerConfig));
  /// ```
  RouterConfig<RouteMixin> get routerConfig;

  ///
  /// Call to construct the custom router config.
  RouterConfig<RouteMixin> buildRouterConfig();

  ///
  /// The route in the root of the router tree.
  R get route;

  ///
  /// Provides the method to find a route in the router that matches to path.
  RouteFinderDelegate get finder;

  ///
  /// Return a route matching the specified path, excluding any query parameters. If no matching route is found, return null.
  RouteMixin? findRoute(String path);

  ///
  /// Mapping to [Navigator.onGenerateRoute], which is invoked when a route name is pushed to generate the corresponding route.
  Route? onGenerateRoute(RouteSettings settings);

  ///
  /// Mapping to [Navigator.onPopPage], [onPopPage] is called when a pop is called.
  bool onPopPage(Route route, dynamic result);

  ///
  /// Mapping to [Navigator.onUnknownRoute], which is called when [onGenerateRoute] returns null or any other factor causes the final route to become null.
  Route<dynamic>? onUnknownRoute(RouteSettings settings);

  ///
  /// This will reset the router finder's cache if the finder maintains a cache.
  void resetCache();

  ///
  /// Mapping to [Navigator.onGenerateInitialRoutes],
  List<Route<dynamic>> Function(
    NavigatorState navigator,
    String initialRouteName,
  ) get onGenerateInitialRoutes => Navigator.defaultGenerateInitialRoutes;

  @override
  String toString() => '$runtimeType(route: $route)';
}
