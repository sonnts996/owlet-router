/*
 Created by Thanh Son on 26/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/cupertino.dart';

import '../src/route/route_base.dart';
import 'history_base.dart';

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
abstract class NavigationServiceBase {

  /// The [NavigationServiceBase]'s constructor.
  NavigationServiceBase({
    required this.navigationKey,
    this.routeObservers = const [],
    this.initialRoute = Navigator.defaultRouteName,
    required this.history,
  });

  /// Global Navigation Key for this module
  final GlobalKey<NavigatorState> navigationKey;

  /// Route Observers for this module
  final List<NavigatorObserver> routeObservers;

  /// The first route is generated when the app starts.
  final String initialRoute;

  /// The current routes list.
  final HistoryBase history;

  /// Return a route matching this path (ignore query parameters).
  /// Return null if can not found the route.
  RouteSegment? findRoute(String path);

  /// Mapping to [Navigator.onGenerateRoute], when a route name is pushed, [onGenerateRoute] is called to generate a new route.
  Route? onGenerateRoute(RouteSettings settings);

  /// Mapping to [Navigator.onPopPage], [onPopPage] is called when a pop is called.
  bool onPopPage(Route route, dynamic result);

  ///  Mapping to [Navigator.onUnknownRoute], [onUnknownRoute] is called when the [onGenerateRoute] returns null, or anything makes the final route null.
  Route<dynamic>? onUnknownRoute(RouteSettings settings);
}
