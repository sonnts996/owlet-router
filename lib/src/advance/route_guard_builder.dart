// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 27/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'dart:async';

import 'package:flutter/material.dart';

import '../../router.dart';

/// The function is called before pushing the [route].
typedef RouteGuard<R extends Object?> = FutureOr<Route?> Function(BuildContext pushContext, Route<R> route);

/// In the [OwletNavigator], when a new route is pushed, if the route has settings as [RouteGuardSettings],
class RouteGuardSettings<T extends Object?> extends RouteSettings {
  /// The [RouteGuardSettings]'s constructor
  RouteGuardSettings({
    super.arguments,
    super.name,
    this.routeGuard,
  });

  /// the function will be called before pushing.
  final RouteGuard<T>? routeGuard;
}

/// In [RouteGuard], returns [CancelledRoute] to cancel the pushing.
class CancelledRoute<T extends Object?> extends Route<T> {
  /// The [CancelledRoute]'s constructor
  CancelledRoute([this.value]);

  /// The returned value when the pushing has been cancelled
  final T? value;
}

/// In [RouteGuard], returns [RedirectRoute] to redirect the pushing to another route's name
class RedirectRoute<T extends Object?> extends Route<T> {
  /// The [RouteSettings.name] is required to redirect
  RedirectRoute(String redirectTo, {Object? arguments})
      : super(
            settings: RouteSettings(
          name: redirectTo,
          arguments: arguments,
        ));
}

/// In the [OwletNavigator], when a new route is pushed, if the route has settings as [RouteGuardSettings],
/// the [RouteGuardSettings.routeGuard] will be called before pushing.
///
/// The route guard function result has a bearing on the pushing.
/// If the result is a [Route], that route will be pushed on.
/// The route's setting also can be rewritten at this function.
/// This can be seen as a redirection feature.
///
/// Another way to redirect is to return a [RedirectRoute] with a special [RouteSettings] name.
///
/// If the returned value is null, the origin route will be pushed.
///
/// To cancel pushing, let's return a [CancelledRoute] value. Then, if the [CancelledRoute.value] is special and matches the result type, it will be the resulting push result.
///
/// __Note:__ If returns [CancelledRoute] but the  [CancelledRoute.value] is not matched to the result type. The origin route will be pushed.
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
class RouteGuardBuilder<A extends Object?, T extends Object?> extends RouteBuilder<A, T> {
  /// The [RouteGuardBuilder]'s constructor
  RouteGuardBuilder({
    this.routeGuard,
    required this.routeBuilder,
  }) : super(routeBuilder.segment, builder: null);

  /// Return the origin [Route] of this segments.
  /// This route will be passed into the [routeGuard]'s params. If the [routeGuard] returns null, it will be the final route to be pushed.
  final RouteBuilder<A, T> routeBuilder;

  /// The function will be called before pushing.
  ///
  /// The route guard function result has a bearing on the pushing.
  /// If the result is a [Route], that route will be pushed on.
  /// The route's setting also can be rewritten at this function.
  /// This can be seen as a redirection feature.
  ///
  /// Another way to redirect is to return a [RedirectRoute] with a special [RouteSettings] name.
  ///
  /// If the returned value is null, the origin route will be pushed.
  ///
  /// To cancel pushing, let's return a [CancelledRoute] value. Then, if the [CancelledRoute.value] is special and matches the result type, it will be the resulting push result.
  ///
  /// __Note:__ If returns [CancelledRoute] but the  [CancelledRoute.value] is not matched to the result type. The origin route will be pushed.
  final RouteGuard? routeGuard;

  @override
  Route<T>? builder(RouteSettings settings) => routeBuilder.builder(
        RouteGuardSettings<T>(
          arguments: settings.arguments,
          name: settings.name,
          routeGuard: routeGuard,
        ),
      );
}

/// At times, the [RouteGuardBuilder] solely relies on the route within the [RouteGuardBuilder.routeGuard] result.
/// For such cases, the [PlaceholderRoute] provides a way to map this situation when the routeBuilder doesn't need to specify anything else
class PlaceholderRoute<A extends Object?, T extends Object?> extends NoTransitionRouteBuilder<A, T> {
  /// The [NoTransitionRouteBuilder] without required [pageBuilder]
  PlaceholderRoute(
    super.segment, {
    PageBuilder? pageBuilder,
    super.maintainState,
    super.allowSnapshotting,
    super.fullscreenDialog,
  }) : super(pageBuilder: pageBuilder ?? owletDefaultUnknownRoute.pageBuilder);
}
