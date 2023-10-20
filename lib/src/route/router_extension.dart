/*
 Created by Thanh Son on 06/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of route_base;

/// Extension for [RouteBuilder] to shorter method push new page route.
/// The [ARGS] is define the arguments type for this route.
///
/// Example:
/// ```
/// Navigator.of(context).pushNamed(AppRoutes.home.fullRoute); // Classic method
/// AppRoutes.home.pushNamed(context); // New method
/// ```
extension RouterExtension<ARGS, T> on RouteBuilder<ARGS, T> {
  /// Return a [Route] of this [RouteBuilder] to use for the function,
  /// which requires the [Route] such as [Navigator.replace] or [Navigator.removeRoute].
  Route<T>? toRoute({ARGS? args}) => builder(RouteSettings(name: path, arguments: args));

  /// Maps to [Navigator.pushNamed] with [T] type of result and [ARGS] type of arguments.
  Future<T?> pushNamed<T1 extends T?>(
    BuildContext context, {
    ARGS? args,
  }) =>
      Navigator.pushNamed<T>(
        context,
        path,
        arguments: args,
      );

  /// Map to [Navigator.pushReplacementNamed] with [T] type of result and [ARGS] type of arguments.
  Future<T?> pushReplacementNamed<T1 extends T?, T0 extends Object?>(
    BuildContext context, {
    T0? result,
    ARGS? args,
  }) =>
      Navigator.pushReplacementNamed<T1, T0>(
        context,
        path,
        arguments: args,
        result: result,
      );

  /// New [Navigator.pushNamedAndRemoveUntil] with [T] type of result and [ARGS] type of arguments.
  Future<T?> pushNamedAndRemoveUntil<T1 extends T?>(
    BuildContext context,
    bool Function(Route<dynamic>) predicate, {
    ARGS? args,
  }) =>
      Navigator.pushNamedAndRemoveUntil<T1>(
        context,
        path,
        predicate,
        arguments: args,
      );

  /// New [Navigator.popAndPushNamed] with [T] type of result and [ARGS] type of arguments.
  Future<T?> popAndPushNamed<T1 extends T?, T0 extends Object?>(
    BuildContext context, {
    ARGS? args,
    T0? result,
  }) =>
      Navigator.popAndPushNamed<T1, T0>(
        context,
        path,
        arguments: args,
        result: result,
      );

  /// New [Navigator.restorablePushNamed] with [T] type of result and [ARGS] type of arguments.
  String restorablePushNamed<T1 extends T?>(
    BuildContext context, {
    ARGS? args,
  }) =>
      Navigator.restorablePushNamed<T1>(
        context,
        path,
        arguments: args,
      );

  /// New [Navigator.restorablePushReplacementNamed] with [T] type of result and [ARGS] type of arguments.
  String restorablePushReplacementNamed<T1 extends T?, T0 extends Object?>(
    BuildContext context, {
    T0? result,
    ARGS? args,
  }) =>
      Navigator.restorablePushReplacementNamed<T1, T0>(
        context,
        path,
        arguments: args,
        result: result,
      );

  /// New [Navigator.restorablePushNamedAndRemoveUntil] with [T] type of result and [ARGS] type of arguments.
  String restorablePushNamedAndRemoveUntil<T1 extends T?>(
    BuildContext context,
    bool Function(Route<dynamic>) predicate, {
    ARGS? args,
  }) =>
      Navigator.restorablePushNamedAndRemoveUntil<T1>(
        context,
        path,
        predicate,
        arguments: args,
      );

  /// New [Navigator.restorablePopAndPushNamed] with [T] type of result and [ARGS] type of arguments.
  String restorablePopAndPushNamed<T1 extends T?, T0 extends Object?>(
    BuildContext context, {
    ARGS? args,
    T0? result,
  }) =>
      Navigator.restorablePopAndPushNamed<T1, T0>(
        context,
        path,
        arguments: args,
        result: result,
      );
}
