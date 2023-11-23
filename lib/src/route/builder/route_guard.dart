// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 27/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of route_builder;

///
/// The pre-push function's return value determines the route pushing behavior.
typedef RouteGuardFunction<R extends Object?> = FutureOr<Route?> Function(BuildContext context, Route<R> route);

///
/// Within the [OwletNavigator], when a route is pushed, the [RouteGuardSettings.routeGuard] function is invoked if the route has settings as [RouteGuardSettings] type.
class RouteGuardSettings<T extends Object?> extends RouteSettings {
  ///
  /// The [RouteGuardSettings]'s constructor
  RouteGuardSettings({
    super.arguments,
    super.name,
    this.routeGuard,
  });

  ///
  /// The pre-push function's return value determines the route pushing behavior.
  final RouteGuardFunction<T>? routeGuard;
}

///
/// In [RouteGuardFunction], returns [CancelledRoute] to cancel the pushing.
class CancelledRoute<T extends Object?> extends Route<T> {
  ///
  /// The [CancelledRoute]'s constructor
  CancelledRoute([this.value]);

  ///
  /// The returned value when the pushing has been cancelled
  final T? value;
}

///
/// In [RouteGuardFunction], returns [RedirectRoute] to redirect the pushing to another route's name
class RedirectRoute<T extends Object?> extends Route<T> {
  ///
  /// The [RouteSettings.name] is required to redirect
  RedirectRoute(String redirectTo, {Object? arguments})
      : super(
            settings: RouteSettings(
          name: redirectTo,
          arguments: arguments,
        ));
}

///
/// Within the [OwletNavigator], when a route is pushed, the [RouteGuardSettings.routeGuard] function is invoked if the route has settings as [RouteGuardSettings] type.
/// This function's returned value determines the pushing behavior.
///
/// If the result is a [Route], it will be pushed. Its settings can also be modified within the function, serving as a redirection mechanism.
///
/// Alternatively, returning a [RedirectRoute] with a route's name can achieve redirection.
///
/// A null return value results in pushing the original route.
///
/// To cancel pushing, return a [CancelledRoute] object. If its [CancelledRoute.value] matches the expected result type, it becomes the final push result.
///
/// **Note:** The [CancelledRoute.value] can be ignored if it does not match the route's result type.
///
///
/// **Compatibility:**
///
/// This functionality applies to the following functions:
///
/// - [Navigator.push],
/// - [Navigator.pushNamed],
/// - [Navigator.popAndPushNamed],
/// - [Navigator.pushReplacement],
/// - [Navigator.pushReplacementNamed],
/// - [Navigator.pushAndRemoveUntil],
/// - [Navigator.pushNamedAndRemoveUntil]
class RouteGuard<A extends Object?, T extends Object?> extends ProxyRoute<RouteBuilder<A, T>> {
  /// The [RouteGuard]'s constructor
  RouteGuard({
    this.routeGuard,
    required super.route,
  });

  ///
  /// This route will be automatically skipped if it already exists in the navigator.
  /// Override [onRouteExists] to handle this scenario or perform custom actions.
  factory RouteGuard.awareExists({
    required RouteBuilder<A, T> route,
    RouteGuardFunction? onRouteExists,
  }) = _AwareExistsRoute;

  ///
  /// The pre-push function's return value determines the route pushing behavior.
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

class _AwareExistsRoute<A extends Object?, T extends Object?> extends RouteGuard<A, T> {
  _AwareExistsRoute({required super.route, this.onRouteExists});

  final RouteGuardFunction? onRouteExists;

  @override
  RouteGuardFunction<Object?>? get routeGuard => (context, route) async {
        if (service.history.contains(path)) {
          final result = await onRouteExists?.call(context, route);
          return result ?? CancelledRoute();
        }
        return null;
      };
}
