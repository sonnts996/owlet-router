/*
 Created by Thanh Son on 27/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:objectx/objectx.dart';

import 'non_route_builder.dart';
import 'route_guard_builder.dart';

/// Implement [Navigator] for advanced features.
///
/// Implement [ROwletNavigator] when using [RouteGuardBuilder]. The [_ROwletNavigatorState]
/// catches when pushing a new route and runs the [RouteGuardBuilder.routeGuard]. The developer
/// can edit the route, redirect, or ignore the pushing.
class ROwletNavigator extends Navigator {
  /// Mapping to the constructor of [Navigator].
  ROwletNavigator({
    super.key,
    super.onGenerateRoute,
    super.initialRoute,
    super.onGenerateInitialRoutes,
    super.onPopPage,
    super.onUnknownRoute,
    super.observers,
    super.clipBehavior,
    super.pages,
    super.reportsRouteUpdateToEngine,
    super.requestFocus,
    super.restorationScopeId,
    super.routeTraversalEdgeBehavior,
    super.transitionDelegate,
  });

  @override
  NavigatorState createState() => _ROwletNavigatorState();
}

class _ROwletNavigatorState extends NavigatorState {
  /// Note that this has an effect with [pushNamed], [popAndPushNamed] too.
  @override
  Future<T?> push<T extends Object?>(Route<T> route) async {
    if (route.settings is NonRouteSettings<T>) {
      final result = await route.settings.castTo<NonRouteSettings<T>?>()?.callback.call(context, route);
      return result;
    }
    final setting = route.settings.castTo<RouteGuardSettings<T>?>();
    if (setting?.routeGuard != null) {
      final finalRoute = await setting?.routeGuard?.call(context, route);
      if (finalRoute == null) {
        return setting?.cancelledValue as T;
      } else {
        if (finalRoute is Route<T>) {
          return super.push<T>(finalRoute);
        } else {
          // Cause by finalRoute returned type is not T.
          super.push(finalRoute);
          return null;
        }
      }
    }
    return super.push(route);
  }

  /// Note that this has an effect with [pushReplacementNamed] too.
  @override
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(Route<T> newRoute, {TO? result}) async {
    final setting = newRoute.settings.castTo<RouteGuardSettings<T>?>();
    if (setting?.routeGuard != null) {
      final finalRoute = await setting?.routeGuard?.call(context, newRoute);
      if (finalRoute == null) {
        return setting?.cancelledValue as T;
      } else {
        if (finalRoute is Route<T>) {
          return super.pushReplacement<T, TO>(finalRoute, result: result);
        } else {
          // Cause by finalRoute returned type is not T.
          super.pushReplacement(finalRoute);
          return null;
        }
      }
    }
    return super.pushReplacement(newRoute, result: result);
  }

  /// Note that this has an effect with [pushNamedAndRemoveUntil] too.
  @override
  Future<T?> pushAndRemoveUntil<T extends Object?>(Route<T> newRoute, RoutePredicate predicate) async {
    final setting = newRoute.settings.castTo<RouteGuardSettings<T>?>();
    if (setting?.routeGuard != null) {
      final finalRoute = await setting?.routeGuard?.call(context, newRoute);
      if (finalRoute == null) {
        return setting?.cancelledValue as T;
      } else {
        if (finalRoute is Route<T>) {
          return super.pushAndRemoveUntil<T>(finalRoute, predicate);
        } else {
          // Cause by finalRoute returned type is not T.
          super.pushAndRemoveUntil(finalRoute, predicate);
          return null;
        }
      }
    }
    return super.pushAndRemoveUntil(newRoute, predicate);
  }
}
