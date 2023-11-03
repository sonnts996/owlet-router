/*
 Created by Thanh Son on 26/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/cupertino.dart';

import '../../router.dart';
import '../advance/navigation_service_provider.dart';
import '../services/owlet_router.dart';

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
abstract class NavigationService<R extends RouteBase> {
  /// Create a [NavigationService]
  /// ===================================
  ///
  /// ### Find a route by path:
  /// - Only one launch-able [Route] with a determined path in [root]. But the [root] can have multi [RouteMixin]
  /// with the same path (an instance of [RouteMixin] with [RouteMixin.canLaunch] is false).
  /// [findRoute] will prioritize to find a launch-able [Route] matched, if can not found, a non-launch-able [Route] will be considered.
  /// - If there are multi non-launch-able [Route] with the same path, the first result will be returned.
  /// - If the route is not defined, [unknownRoute] with be returned.
  factory NavigationService({
    GlobalKey<NavigatorState>? navigationKey,
    List<NavigatorObserver> routeObservers,
    String initialRoute,
    RouteBuilder? unknownRoute,
    required R root,
    RouteFinderDelegate? finder,
    RouteHistory? history,
  }) = NavigationServiceImpl;

  /// Returns the [NavigationService] if it exists in the [context].
  static NavigationService? maybeOf(BuildContext context) => NavigationServiceProvider.maybeOf(context)?.service;

  /// Returns the [NavigationService] if it exists in the [context]. But it will be thrown an error if the [NavigationService] not found.
  static NavigationService of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No NavigationService found in context');
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

  /// returns the origin route. The route in the root of the tree router.
  R get root;

  /// The router uses this as a [RouteBase] finder, which matches the input path.
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
  void buildRouter();
}
