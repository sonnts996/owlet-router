// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 27/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/material.dart';

import '../route/route_base.dart';

/// Editing [Route]'s function.
typedef RouteGuard<R> = Future<Route?> Function(BuildContext pushContext, Route<R> route);

/// With ROwletNavigator, when pushes a new route, if the route has route settings is [RouteGuardSettings]
/// the [RouteGuardSettings.routeGuard] will be called before pushing.
/// If  [RouteGuardBuilder.routeGuard] returns null, that means your pushing is canceled, the [cancelledValue] will be returned.
class RouteGuardSettings<T extends Object?> extends RouteSettings {
  /// With ROwletNavigator, when pushes a new route, if the route has route settings is [RouteGuardSettings]
  /// the [RouteGuardSettings.routeGuard] will be called before pushing.
  /// If  [RouteGuardBuilder.routeGuard] returns null, that means your pushing is canceled, the [cancelledValue] will be returned.
  RouteGuardSettings({
    super.arguments,
    super.name,
    this.routeGuard,
    this.cancelledValue,
  });

  /// Return the accepted route. It is called before push and after generated route (in case pushNamed)
  final RouteGuard<T>? routeGuard;

  /// Returned value if [routeGuard] returns null
  final T? cancelledValue;
}

/// ROwletNavigator provides a feature that accepts editing the route before it pushes it.
/// [RouteGuardBuilder.routeGuard] will call before the route is already pushed, the result of this method will apply (or replace) the origin pushing route.
/// If  [RouteGuardBuilder.routeGuard] returns null, that means your pushing is canceled, the [cancelledValue] will be returned.
///
/// Note:
/// This works only with these functions:
/// - [Navigator.push],
/// - [Navigator.pushNamed],
/// - [Navigator.popAndPushNamed],
/// - [Navigator.pushReplacement],
/// - [Navigator.pushReplacementNamed],
/// - [Navigator.pushAndRemoveUntil],
/// - [Navigator.pushNamedAndRemoveUntil]
class RouteGuardBuilder<ARGS extends Object?, T extends Object?> extends RouteBuilder<ARGS, T> {
  /// ROwletNavigator provides a feature that accepts editing the route before it pushes it.
  /// [RouteGuardBuilder.routeGuard] will call before the route is already pushed, the result of this method will apply (or replace) the origin pushing route.
  /// If  [RouteGuardBuilder.routeGuard] returns null, that means your pushing is canceled, the [cancelledValue] will be returned.
  RouteGuardBuilder({
    this.routeGuard,
    required this.routeBuilder,
    this.cancelledValue,
  }) : super(routeBuilder.segmentPath, builder: null);

  /// Return the origin [Route] of this segments.
  final RouteBuilder<ARGS, T> routeBuilder;

  /// Return the accepted route. It is called before push and after generated route (in case pushNamed)
  final RouteGuard? routeGuard;

  /// Returned value if [routeGuard] returns null
  final T? cancelledValue;

  @override
  Route<T>? builder(RouteSettings settings) => routeBuilder.builder(
        RouteGuardSettings<T>(
          arguments: settings.arguments,
          name: settings.name,
          routeGuard: routeGuard,
          cancelledValue: cancelledValue,
        ),
      );
}
