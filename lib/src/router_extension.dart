/*
 Created by Thanh Son on 06/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of owlet_router;

/// Extension for [RouteBuilder] to faster method push new page route. The [E] is define the parameter Class type for this route.
///
/// Example:
/// ```
/// Navigator.of(context).pushNamed(AppRoutes.home.fullRoute); // Classic method
/// AppRoutes.home.pushNamed(context); // New method
/// ```
extension RouterExtension<E extends Object> on RouteBuilder<E> {

  /// New [Navigator.pushNamed] with [T] result and [E] argument.
  /// Note that the argument may not be null required
  Future<T?> pushNamed<T extends Object?>(
    BuildContext context, {
    bool forRoot = false,
    E? args,
  }) =>
      Navigator.pushNamed<T>(
        context,
        fullRoute,
        arguments: args,
      );

  /// New [Navigator.pushReplacementNamed] with [T] result and [E] argument.
  /// Note that the argument may not be null required
  Future<T?> pushReplacementNamed<T extends Object?, T0 extends Object?>(
    BuildContext context, {
    bool forRoot = false,
    T0? result,
    E? args,
  }) =>
      Navigator.pushReplacementNamed<T, T0>(
        context,
        fullRoute,
        arguments: args,
        result: result,
      );

  /// New [Navigator.pushNamedAndRemoveUntil] with [T] result and [E] argument.
  /// Note that the argument may not be null required
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    BuildContext context,
    bool Function(Route<dynamic>) predicate, {
    E? args,
    bool forRoot = false,
  }) =>
      Navigator.pushNamedAndRemoveUntil<T>(
        context,
        fullRoute,
        predicate,
        arguments: args,
      );

  /// New [Navigator.popAndPushNamed] with [T] result and [E] argument.
  /// Note that the argument may not be null required
  Future<T?> popAndPushNamed<T extends Object?, T0 extends Object?>(
    BuildContext context, {
    bool forRoot = false,
    E? args,
    T0? result,
  }) =>
      Navigator.popAndPushNamed<T, T0>(
        context,
        fullRoute,
        arguments: args,
        result: result,
      );
}
