/*
 Created by Thanh Son on 06/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of router_services;

/// Extension for [NavigationService] to shorter method push new page route with it's context.
///
/// Example:
/// ```
/// Navigator.of(context).pushNamed(yourRoot.home.path); // Classic method
/// yourRoot.home.pushNamed(context); // New method
/// ```
extension NavigationServiceExtension on NavigationService {
  /// Return the [service.navigationKey.currentContext] if it has been injected into the Navigator
  BuildContext get context => navigationKey.currentContext.let((it) {
        assert(it != null, "Context not found, maybe this route's service was not injected in Navigator");
        return it!;
      });

  /// Maps to [Navigator.pushNamed] with [T] type of result and the [NavigationService]'s context.
  Future<T?> pushNamed<T extends Object?>(
    String path, {
    Object? args,
  }) =>
      Navigator.of(context).pushNamed<T>(path, arguments: args);

  /// Map to [Navigator.pushReplacementNamed] with [T] type of result the [NavigationService]'s context.
  Future<T?> pushReplacementNamed<T extends Object?, T0 extends Object?>(
    String path, {
    T0? result,
    Object? args,
    RouteBuilder<Object, T>? route,
  }) =>
      Navigator.of(context).pushReplacementNamed<T, T0>(path, arguments: args, result: result);

  /// New [Navigator.pushNamedAndRemoveUntil] with [T] type of result and the [NavigationService]'s context.
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    bool Function(Route<dynamic>) predicate,
    String path, {
    Object? args,
  }) =>
      Navigator.of(context).pushNamedAndRemoveUntil<T>(path, predicate, arguments: args);

  /// New [Navigator.popAndPushNamed] with [T] type of result and the [NavigationService]'s context.
  Future<T?> popAndPushNamed<T extends Object?, T0 extends Object?>(
    String path, {
    Object? args,
    T0? result,
  }) =>
      Navigator.of(context).popAndPushNamed<T, T0>(path, arguments: args, result: result);

  /// New [Navigator.restorablePushNamed] with [T] type of result and the [NavigationService]'s context.
  String restorablePushNamed<T extends Object?>(
    String path, {
    Object? args,
    RouteBuilder<Object, T>? route,
  }) =>
      Navigator.of(context).restorablePushNamed<T>(path, arguments: args);

  /// New [Navigator.restorablePushReplacementNamed] with [T] type of result and the [NavigationService]'s context.
  String restorablePushReplacementNamed<T extends Object?, T0 extends Object?>(
    String path, {
    T0? result,
    Object? args,
  }) =>
      Navigator.of(context).restorablePushReplacementNamed<T, T0>(path, arguments: args, result: result);

  /// New [Navigator.restorablePushNamedAndRemoveUntil] with [T] type of result and the [NavigationService]'s context.
  String restorablePushNamedAndRemoveUntil<T extends Object?>(
    bool Function(Route<dynamic>) predicate,
    String path, {
    Object? args,
  }) =>
      Navigator.of(context).restorablePushNamedAndRemoveUntil<T>(path, predicate, arguments: args);

  /// New [Navigator.restorablePopAndPushNamed] with [T] type of result and the [NavigationService]'s context.
  String restorablePopAndPushNamed<T extends Object?, T0 extends Object?>(
    String path, {
    Object? args,
    T0? result,
  }) =>
      Navigator.of(context).restorablePopAndPushNamed<T, T0>(path, arguments: args, result: result);
}
