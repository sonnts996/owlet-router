// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 27/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of route_builder;

/// The function is called before pushing the [route].
typedef RouteGuardFunction<R extends Object?> = FutureOr<Route?> Function(BuildContext pushContext, Route<R> route);

/// In the [OwletNavigator], when a new route is pushed, if the route has settings as [RouteGuardSettings],
class RouteGuardSettings<T extends Object?> extends RouteSettings {
  /// The [RouteGuardSettings]'s constructor
  RouteGuardSettings({
    super.arguments,
    super.name,
    this.routeGuard,
  });

  /// the function will be called before pushing.
  final RouteGuardFunction<T>? routeGuard;
}

/// In [RouteGuardFunction], returns [CancelledRoute] to cancel the pushing.
class CancelledRoute<T extends Object?> extends Route<T> {
  /// The [CancelledRoute]'s constructor
  CancelledRoute([this.value]);

  /// The returned value when the pushing has been cancelled
  final T? value;
}

/// In [RouteGuardFunction], returns [RedirectRoute] to redirect the pushing to another route's name
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
class RouteGuard<A extends Object?, T extends Object?> extends NestedRoute<RouteBuilder<A, T>> {
  /// The [RouteGuard]'s constructor
  RouteGuard({
    this.routeGuard,
    required super.route,
  });

  /// This route will be ignored by default if it already exists in the Navigator.
  /// Override [onRouteExisted] to modify or to do something when it happened.
  factory RouteGuard.awareExisted({
    required RouteBuilder<A, T> route,
    RouteGuardFunction? onRouteExisted,
  }) = _AwareExistedRoute;

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
  final RouteGuardFunction? routeGuard;

  @override
  Route<Object?>? build(RouteSettings settings) => route.build(
        RouteGuardSettings<Object?>(
          arguments: settings.arguments,
          name: settings.name,
          routeGuard: routeGuard,
        ),
      );
}

class _AwareExistedRoute<A extends Object?, T extends Object?> extends RouteGuard<A, T> {
  _AwareExistedRoute({required super.route, this.onRouteExisted});

  final RouteGuardFunction? onRouteExisted;

  @override
  RouteGuardFunction<Object?>? get routeGuard => (pushContext, route) async {
        if (service.history.contains(path)) {
          final result = await onRouteExisted?.call(pushContext, route);
          return result ?? CancelledRoute();
        }
        return null;
      };
}
