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
extension RouterExtension<A, T> on RouteBuilder<A, T> {
  /// Return a [Route] of this [RouteBuilder] to use for the function,
  /// which requires the [Route] such as [Navigator.replace] or [Navigator.removeRoute].
  Route<T>? toRoute({A? args}) => builder(RouteSettings(name: path, arguments: args));

  /// Maps to [Navigator.pushNamed] with [T] type of result and [A] type of arguments.
  Future<T1?> pushNamed<T1 extends T?>(BuildContext context, {A? args, bool rootNavigator = false}) =>
      Navigator.of(context, rootNavigator: rootNavigator).pushNamed<T1>(path, arguments: args);

  /// Map to [Navigator.pushReplacementNamed] with [T] type of result and [A] type of arguments.
  Future<T1?> pushReplacementNamed<T1 extends T?, T0 extends Object?>(BuildContext context,
          {T0? result, A? args, bool rootNavigator = false}) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .pushReplacementNamed<T1, T0>(path, arguments: args, result: result);

  /// New [Navigator.pushNamedAndRemoveUntil] with [T] type of result and [A] type of arguments.
  Future<T1?> pushNamedAndRemoveUntil<T1 extends T?>(BuildContext context, bool Function(Route<dynamic>) predicate,
          {A? args, bool rootNavigator = false}) =>
      Navigator.of(context, rootNavigator: rootNavigator).pushNamedAndRemoveUntil<T1>(
        path,
        predicate,
        arguments: args,
      );

  /// New [Navigator.popAndPushNamed] with [T] type of result and [A] type of arguments.
  Future<T1?> popAndPushNamed<T1 extends T?, T0 extends Object?>(BuildContext context,
          {A? args, T0? result, bool rootNavigator = false}) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .popAndPushNamed<T1, T0>(path, arguments: args, result: result);

  /// New [Navigator.restorablePushNamed] with [T] type of result and [A] type of arguments.
  String restorablePushNamed(BuildContext context, {A? args, bool rootNavigator = false}) =>
      Navigator.of(context, rootNavigator: rootNavigator).restorablePushNamed<T>(path, arguments: args);

  /// New [Navigator.restorablePushReplacementNamed] with [T] type of result and [A] type of arguments.
  String restorablePushReplacementNamed<T1 extends T?, T0 extends Object?>(BuildContext context,
          {T0? result, A? args, bool rootNavigator = false}) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .restorablePushReplacementNamed<T1, T0>(path, arguments: args, result: result);

  /// New [Navigator.restorablePushNamedAndRemoveUntil] with [T] type of result and [A] type of arguments.
  String restorablePushNamedAndRemoveUntil<T1 extends T?>(BuildContext context, bool Function(Route<dynamic>) predicate,
          {A? args, bool rootNavigator = false}) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .restorablePushNamedAndRemoveUntil<T1>(path, predicate, arguments: args);

  /// New [Navigator.restorablePopAndPushNamed] with [T] type of result and [A] type of arguments.
  String restorablePopAndPushNamed<T1 extends T?, T0 extends Object?>(BuildContext context,
          {A? args, T0? result, bool rootNavigator = false}) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .restorablePopAndPushNamed<T1, T0>(path, arguments: args, result: result);
}
