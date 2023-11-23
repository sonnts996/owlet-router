/*
 Created by Thanh Son on 06/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of route_base;

///
/// RouteBuilder extension to push a route.
/// The [A] argument defines the route's argument type, and the [T] argument defines the route's result type.
///
/// Example:
///
/// ```
/// Navigator.of(context).pushNamed(yourRoot.home.path); // Classic method
/// yourRoot.home.pushNamed(); // New method
/// ```
extension RouterExtension<A, T> on RouteBuilderMixin<A, T> {
  ///
  /// This function generates a [Route] from this [RouteBuilder] for use with functions like [Navigator.replace] or [Navigator.removeRoute].
  Route<T>? toRoute({A? args, Map<String, dynamic>? params, String? fragment, bool encode = false}) =>
      build(RouteSettings(
        name: _finalPath(params, fragment, encode: encode),
        arguments: args,
      ));

  ///
  /// Return the [service.navigationKey.currentContext] if it has been injected into the Navigator
  BuildContext get context => service.context;

  String _finalPath(Map<String, dynamic>? params, String? fragment, {bool encode = false}) {
    if (params != null || fragment != null) {
      return argsPath(params ?? {}, fragment: fragment, encode: encode);
    }
    return path;
  }

  ///
  /// Map to [Navigator.pushNamed] with a result type of [T] and an argument type of [A].
  Future<T1?> pushNamed<T1 extends T?>({
    A? args,
    Map<String, dynamic>? params,
    String? fragment,
    bool encode = false,
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .pushNamed<T1>(_finalPath(params, fragment, encode: encode), arguments: args);

  ///
  /// Map to [Navigator.pushReplacementNamed] with a result type of [T] and an argument type of [A].
  Future<T1?> pushReplacementNamed<T1 extends T?, T0 extends Object?>({
    T0? result,
    A? args,
    Map<String, dynamic>? params,
    String? fragment,
    bool encode = false,
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator).pushReplacementNamed<T1, T0>(
        _finalPath(params, fragment, encode: encode),
        arguments: args,
        result: result,
      );

  ///
  /// Map to [Navigator.pushNamedAndRemoveUntil] with a result type of [T] and an argument type of [A].
  Future<T1?> pushNamedAndRemoveUntil<T1 extends T?>(
    bool Function(Route<dynamic>) predicate, {
    A? args,
    Map<String, dynamic>? params,
    String? fragment,
    bool encode = false,
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator).pushNamedAndRemoveUntil<T1>(
        path,
        predicate,
        arguments: args,
      );

  ///
  /// Map to [Navigator.popAndPushNamed] with a result type of [T] and an argument type of [A].
  Future<T1?> popAndPushNamed<T1 extends T?, T0 extends Object?>({
    A? args,
    Map<String, dynamic>? params,
    String? fragment,
    bool encode = false,
    T0? result,
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator).popAndPushNamed<T1, T0>(
        _finalPath(params, fragment, encode: encode),
        arguments: args,
        result: result,
      );

  ///
  /// Map to [Navigator.restorablePushNamed] with a result type of [T] and an argument type of [A].
  String restorablePushNamed({
    A? args,
    Map<String, dynamic>? params,
    String? fragment,
    bool encode = false,
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator).restorablePushNamed<T>(
        _finalPath(params, fragment, encode: encode),
        arguments: args,
      );

  ///
  /// Map to [Navigator.restorablePushReplacementNamed] with a result type of [T] and an argument type of [A].
  String restorablePushReplacementNamed<T1 extends T?, T0 extends Object?>({
    T0? result,
    A? args,
    Map<String, dynamic>? params,
    String? fragment,
    bool encode = false,
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator).restorablePushReplacementNamed<T1, T0>(
        _finalPath(params, fragment, encode: encode),
        arguments: args,
        result: result,
      );

  ///
  /// Map to [Navigator.restorablePushNamedAndRemoveUntil] with a result type of [T] and an argument type of [A].
  String restorablePushNamedAndRemoveUntil<T1 extends T?>(
    bool Function(Route<dynamic>) predicate, {
    A? args,
    Map<String, dynamic>? params,
    String? fragment,
    bool encode = false,
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator).restorablePushNamedAndRemoveUntil<T1>(
        _finalPath(params, fragment, encode: encode),
        predicate,
        arguments: args,
      );

  ///
  /// Map to [Navigator.restorablePopAndPushNamed] with a result type of [T] and an argument type of [A].
  String restorablePopAndPushNamed<T1 extends T?, T0 extends Object?>({
    A? args,
    Map<String, dynamic>? params,
    String? fragment,
    bool encode = false,
    T0? result,
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator).restorablePopAndPushNamed<T1, T0>(
        _finalPath(params, fragment, encode: encode),
        arguments: args,
        result: result,
      );
}
