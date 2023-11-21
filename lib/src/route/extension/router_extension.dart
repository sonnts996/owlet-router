/*
 Created by Thanh Son on 06/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of route_base;

/// Extension for [RouteBuilder] to shorter method push new page route.
/// The [A] defines the argument type for this route.
///
/// Example:
/// ```
/// Navigator.of(context).pushNamed(yourRoot.home.path); // Classic method
/// yourRoot.home.pushNamed(context); // New method
/// ```
extension RouterExtension<A, T> on BuildableRouteMixin<A, T> {
  /// Return a [Route] of this [RouteBuilder] to use for the function,
  /// which requires the [Route] such as [Navigator.replace] or [Navigator.removeRoute].
  Route<T>? toRoute({A? args, Map<String, dynamic>? params, String? fragment, bool encode = false}) =>
      build(RouteSettings(
        name: _finalPath(params, fragment, encode: encode),
        arguments: args,
      ));

  /// Return the [service.navigationKey.currentContext] if it has been injected into the Navigator
  BuildContext get context => service.context;

  String _finalPath(Map<String, dynamic>? params, String? fragment, {bool encode = false}) {
    if (params != null || fragment != null) {
      return argsPath(params ?? {}, fragment: fragment, encode: encode);
    }
    return path;
  }

  /// Maps to [Navigator.pushNamed] with [T] type of result and [A] type of arguments.
  Future<T1?> pushNamed<T1 extends T?>({
    A? args,
    Map<String, dynamic>? params,
    String? fragment,
    bool encode = false,
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .pushNamed<T1>(_finalPath(params, fragment, encode: encode), arguments: args);

  /// Map to [Navigator.pushReplacementNamed] with [T] type of result and [A] type of arguments.
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

  /// New [Navigator.pushNamedAndRemoveUntil] with [T] type of result and [A] type of arguments.
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

  /// New [Navigator.popAndPushNamed] with [T] type of result and [A] type of arguments.
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

  /// New [Navigator.restorablePushNamed] with [T] type of result and [A] type of arguments.
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

  /// New [Navigator.restorablePushReplacementNamed] with [T] type of result and [A] type of arguments.
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

  /// New [Navigator.restorablePushNamedAndRemoveUntil] with [T] type of result and [A] type of arguments.
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

  /// New [Navigator.restorablePopAndPushNamed] with [T] type of result and [A] type of arguments.
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
