// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 27/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of nested_route;

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
class RouteGuard<A extends Object?, T extends Object?> extends GuardProxyRoute<RouteBuilderMixin<A, T>> {
  /// The [RouteGuard]'s constructor
  RouteGuard({
    super.routeGuard,
    required super.route,
  });

  ///
  /// This route will be automatically skipped if it already exists in the navigator.
  /// Override [onRouteExists] to handle this scenario or perform custom actions.
  static AwareExistsRoute<A, T> awareExists<A extends Object?, T extends Object?>({
    required RouteBuilderMixin<A, T> route,
    RouteGuardFunction? onRouteExists,
  }) =>
      AwareExistsRoute<A, T>(
        route: route,
        onRouteExists: onRouteExists,
      );
}

///
/// This route will be automatically skipped if it already exists in the navigator.
/// Override [onRouteExists] to handle this scenario or perform custom actions.
class AwareExistsRoute<A extends Object?, T extends Object?> extends RouteGuard<A, T> with RouteNotifier {
  /// The [AwareExistsRoute]'s constructor
  AwareExistsRoute({
    required super.route,
    this.onRouteExists,
  });

  ///
  /// This function handles scenarios where the route already exists in the navigator.
  /// If the provided route result is valid and not a cancellation, it will be pushed onto the navigation stack.
  /// Otherwise, the pushing action is ignored.
  final RouteGuardFunction? onRouteExists;

  @override
  RouteGuardFunction? get routeGuard => (context, it, route) async {
        updateRouteSettings(route.settings);
        if (service.history.containsName(path)) {
          final result = await onRouteExists?.call(context, this, route);
          return result ?? CancelledRoute();
        }
        return null;
      };
}
