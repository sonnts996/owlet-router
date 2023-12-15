// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 04/12/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of 'nested.dart';

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
          ),
        );
}

///
/// The pre-push function's return value determines the route pushing behavior.
typedef RouteGuardFunction = FutureOr<Route?> Function(
    BuildContext context, RouteBuilderMixin it, Route route);

///
/// The pre-push function's return value determines the route pushing behavior.
/// The [RouteGuardFunctionIntl] is called in the navigator and nested route guard,
/// caused by can not to determine the route that contains the routeGuard (use for parameter **RouteBuilderMixin it**) outside its context.
@internal
typedef RouteGuardFunctionIntl = FutureOr<Route?> Function(
    BuildContext context, Route<Object?> route);

///
/// Within the [OwletNavigator], when a route is pushed, the [RouteGuardSettings.routeGuard] function is invoked if the route has settings as [RouteGuardSettings] type.
class RouteGuardSettings extends RouteSettings {
  ///
  /// The [RouteGuardSettings]'s constructor
  const RouteGuardSettings({
    super.arguments,
    super.name,
    this.routeGuard,
  });

  ///
  /// The pre-push function's return value determines the route pushing behavior.
  final RouteGuardFunctionIntl? routeGuard;
}

///
/// Implement the build function of the route guard in a way that combines all the guard methods in case of a nested route.
/// The execution order should follow a top-down approach, starting from the outermost route and progressing inwards.
/// The result of each outer guard method should be passed as a parameter to the next inner guard method.
abstract class GuardProxyRoute<R extends RouteBuilderMixin>
    extends ProxyRoute<R> {
  ///
  /// The [GuardProxyRoute]'s constructor
  GuardProxyRoute({required super.route, this.routeGuard});

  ///
  /// The pre-push function's return value determines the route pushing behavior.
  final RouteGuardFunction? routeGuard;

  ///
  /// If the [parentGuard] is special, it will be executed first.
  /// If so, its result will be used as the value of the route parameter for the [routeGuard].
  /// If the [routeGuard] is null, the result of the [parentGuard] will be returned.
  FutureOr<Route?> runGuard(
    BuildContext context,
    Route route,
    RouteGuardFunctionIntl? parentGuard,
  ) async {
    Route? resultRoute;
    if (parentGuard != null) {
      resultRoute = await parentGuard.call(context, route);
      if (resultRoute is CancelledRoute || resultRoute is RedirectRoute) {
        return resultRoute;
      }
    }
    if (routeGuard != null) {
      return routeGuard!.call(context, this, resultRoute ?? route);
    }
    return resultRoute;
  }

  @override
  Route<Object?>? build(RouteSettings settings) {
    RouteGuardFunctionIntl? parentGuard;
    if (settings is RouteGuardSettings) {
      parentGuard = settings.routeGuard;
    }
    return route.build(
      RouteGuardSettings(
        arguments: settings.arguments,
        name: settings.name,
        routeGuard: (context, route) async =>
            runGuard(context, route, parentGuard),
      ),
    );
  }
}
