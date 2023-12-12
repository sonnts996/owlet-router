/*
 Created by Thanh Son on 06/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of router_services;

///
/// Extension for [NavigationService] to push a route with its context.
///
/// Example:
/// ```
/// Navigator.of(context).pushNamed(yourRoot.home.path); // Classic method
/// yourRoot.home.pushNamed(); // New method
/// ```
extension NavigationServiceExtension on NavigationService {
  ///
  /// Return the [service.navigationKey.currentContext] if it has been injected into the Navigator
  BuildContext get context => navigationKey.currentContext.let((it) {
        assert(it != null, "Context not found, maybe this route's service was not injected in Navigator");
        return it!;
      });

  ///
  /// Map to [Navigator.pushNamed] using the [NavigationService]'s context and a result type of [T].
  Future<T?> pushNamed<T extends Object?>(
    String path, {
    Object? args,
  }) =>
      Navigator.of(context).pushNamed<T>(path, arguments: args);

  ///
  /// Map to [Navigator.pushReplacementNamed] using the [NavigationService]'s context and a result type of [T].
  Future<T?> pushReplacementNamed<T extends Object?, T0 extends Object?>(
    String path, {
    T0? result,
    Object? args,
    RouteBuilder<Object, T>? route,
  }) =>
      Navigator.of(context).pushReplacementNamed<T, T0>(path, arguments: args, result: result);

  ///
  /// Map to [Navigator.pushNamedAndRemoveUntil] using the [NavigationService]'s context and a result type of [T].
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    bool Function(Route<dynamic>) predicate,
    String path, {
    Object? args,
  }) =>
      Navigator.of(context).pushNamedAndRemoveUntil<T>(path, predicate, arguments: args);

  ///
  /// Map to [Navigator.popAndPushNamed] using the [NavigationService]'s context and a result type of [T].
  Future<T?> popAndPushNamed<T extends Object?, T0 extends Object?>(
    String path, {
    Object? args,
    T0? result,
  }) =>
      Navigator.of(context).popAndPushNamed<T, T0>(path, arguments: args, result: result);

  ///
  /// Map to [Navigator.restorablePushNamed] using the [NavigationService]'s context and a result type of [T].
  String restorablePushNamed<T extends Object?>(
    String path, {
    Object? args,
    RouteBuilder<Object, T>? route,
  }) =>
      Navigator.of(context).restorablePushNamed<T>(path, arguments: args);

  ///
  /// Map to [Navigator.restorablePushReplacementNamed] using the [NavigationService]'s context and a result type of [T].
  String restorablePushReplacementNamed<T extends Object?, T0 extends Object?>(
    String path, {
    T0? result,
    Object? args,
  }) =>
      Navigator.of(context).restorablePushReplacementNamed<T, T0>(path, arguments: args, result: result);

  ///
  /// Map to [Navigator.restorablePushNamedAndRemoveUntil] using the [NavigationService]'s context and a result type of [T].
  String restorablePushNamedAndRemoveUntil<T extends Object?>(
    bool Function(Route<dynamic>) predicate,
    String path, {
    Object? args,
  }) =>
      Navigator.of(context).restorablePushNamedAndRemoveUntil<T>(path, predicate, arguments: args);

  ///
  /// Map to [Navigator.restorablePopAndPushNamed] using the [NavigationService]'s context and a result type of [T].
  String restorablePopAndPushNamed<T extends Object?, T0 extends Object?>(
    String path, {
    Object? args,
    T0? result,
  }) =>
      Navigator.of(context).restorablePopAndPushNamed<T, T0>(path, arguments: args, result: result);

  ///
  /// Map to [Navigator.pop] using the [NavigationService]'s context and a result type of [T].
  void pop<T extends Object?>([T? result]) => Navigator.of(context).pop(result);

  ///
  /// Map to [Navigator.popUntil] using the [NavigationService]'s context.
  void popUntil(RoutePredicate predicate) => Navigator.of(context).popUntil(predicate);

  ///
  /// Map to [Navigator.canPop] using the [NavigationService]'s context.
  bool canPop() => Navigator.of(context).canPop();

  ///
  /// Map to [Navigator.maybePop] using the [NavigationService]'s context and a result type of [T].
  void maybePop<T extends Object?>([T? result]) => Navigator.of(context).maybePop(result);
}
