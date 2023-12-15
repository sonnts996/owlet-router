/*
 Created by Thanh Son on 27/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of 'router_services.dart';

///
/// Implementation of advanced navigation features for the [Navigator], including route guards and named route builders.
/// These features, such as [RouteGuard] and [NamedFunctionRouteBuilder], are only active when used within the [OwletNavigator].
///
/// **Note:** Certain advanced navigation features are limited to specific [Navigator] push functions.
/// Refer to the features documentation for detailed information.
class OwletNavigator extends Navigator {
  ///
  /// Create a new [OwletNavigator] with a [NavigationService].
  ///
  /// Example:
  ///
  /// ```dart
  /// final service = NavigationService( //... );
  /// Navigator(
  ///   key: service.navigationKey,
  ///   initialRoute: service.initialRoute,
  ///   observers: <NavigatorObserver>[service.history, ...service.routeObservers],
  ///   onGenerateRoute: service.onGenerateRoute,
  ///   onPopPage: service.onPopPage,
  ///   onUnknownRoute: service.onUnknownRoute,
  ///   onGenerateInitialRoutes: service.onGenerateInitialRoutes,
  /// )
  /// ```
  OwletNavigator(
    this.service, {
    super.transitionDelegate = const DefaultTransitionDelegate(),
    super.clipBehavior = Clip.hardEdge,
    super.reportsRouteUpdateToEngine = false,
    super.requestFocus = true,
    super.restorationScopeId,
    super.routeTraversalEdgeBehavior = kDefaultRouteTraversalEdgeBehavior,
  }) : super(
          key: service.navigationKey,
          initialRoute: service.initialRoute,
          observers: <NavigatorObserver>[
            service.history,
            ...service.routeObservers
          ],
          onGenerateRoute: service.onGenerateRoute,
          onPopPage: service.onPopPage,
          onUnknownRoute: service.onUnknownRoute,
          onGenerateInitialRoutes: service.onGenerateInitialRoutes,
        );

  ///
  /// This [Navigator]'s service
  final NavigationService service;

  @override
  NavigatorState createState() => OwletNavigatorState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<NavigationService<RouteMixin>>('service', service));
  }
}

///
/// This is the state of [OwletNavigator]
class OwletNavigatorState extends NavigatorState {
  ///
  /// return this [Navigator]'s service
  NavigationService get service => (widget as OwletNavigator).service;

  Future<T?> _namedFunction<T extends Object?>(Route<T> route) async =>
      route.settings
          .castTo<NamedFunctionRouteSettings<T>?>()
          ?.callback
          .call(context, route);

  Future<T?> _routeGuard<T extends Object?>(
    Route<T> route,
    Future<Object?> Function(Route<Object?> finalRoute) callback,
    Future<Object?> Function(RouteSettings settings) redirect,
  ) async {
    final setting = route.settings.castTo<RouteGuardSettings?>();
    if (setting?.routeGuard != null) {
      final finalRoute =
          await setting?.routeGuard?.call(context, route) ?? route;
      if (finalRoute is CancelledRoute<T>) {
        return finalRoute.value;
      } else if (finalRoute is RedirectRoute &&
          finalRoute.settings.name != null) {
        final result = await redirect(finalRoute.settings);
        return result.castTo<T?>();
      } else {
        final result = await callback(finalRoute);
        return result.castTo<T?>();
      }
    }
    final result = await callback(route);
    return result.castTo<T?>();
  }

  bool _isSameRoute(Route originRoute, Route finalRoute) =>
      finalRoute == originRoute ||
      (finalRoute.settings.name?.let((it) => it == originRoute.settings.name) ??
          false);

  bool _isSameName(Route originRoute, String name) =>
      originRoute.settings.name?.let((it) => it == name) ?? false;

  ///
  /// This function also works with [pushNamed], [popAndPushNamed].
  @override
  Future<T?> push<T extends Object?>(Route<T> route) async {
    if (route.settings is NamedFunctionRouteSettings<T>) {
      return _namedFunction(route);
    }
    if (route.settings is RouteGuardSettings) {
      return _routeGuard(route, (finalRoute) {
        if (_isSameRoute(route, finalRoute)) {
          return super.push<Object?>(finalRoute);
        } else {
          return push<Object?>(finalRoute);
        }
      }, (settings) {
        if (_isSameName(route, settings.name!)) {
          return super.pushNamed(settings.name!, arguments: settings.arguments);
        } else {
          return pushNamed(settings.name!, arguments: settings.arguments);
        }
      });
    }
    return super.push(route);
  }

  ///
  /// This function also works with [pushReplacementNamed].
  @override
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
      Route<T> newRoute,
      {TO? result}) async {
    if (newRoute.settings is RouteGuardSettings) {
      return _routeGuard(
        newRoute,
        (finalRoute) {
          if (_isSameRoute(newRoute, finalRoute)) {
            return super
                .pushReplacement<Object?, Object?>(finalRoute, result: result);
          } else {
            return pushReplacement<Object?, Object?>(finalRoute,
                result: result);
          }
        },
        (settings) {
          if (_isSameName(newRoute, settings.name!)) {
            return super.pushReplacementNamed(settings.name!,
                arguments: settings.arguments, result: result);
          } else {
            return pushReplacementNamed(settings.name!,
                arguments: settings.arguments, result: result);
          }
        },
      );
    }
    return super.pushReplacement(newRoute, result: result);
  }

  ///
  /// This function also works with [pushNamedAndRemoveUntil].
  @override
  Future<T?> pushAndRemoveUntil<T extends Object?>(
      Route<T> newRoute, RoutePredicate predicate) async {
    if (newRoute.settings is RouteGuardSettings) {
      return _routeGuard(
        newRoute,
        (finalRoute) {
          if (_isSameRoute(newRoute, finalRoute)) {
            return super.pushAndRemoveUntil<Object?>(finalRoute, predicate);
          } else {
            return pushAndRemoveUntil<Object?>(finalRoute, predicate);
          }
        },
        (settings) {
          if (_isSameName(newRoute, settings.name!)) {
            return super.pushNamedAndRemoveUntil(settings.name!, predicate);
          } else {
            return pushNamedAndRemoveUntil(settings.name!, predicate);
          }
        },
      );
    }
    return super.pushAndRemoveUntil(newRoute, predicate);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<NavigationService<RouteMixin>>('service', service));
  }
}
