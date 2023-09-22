/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of owlet_router;

/// Router exception's interface for owlet_flutter.
class RouterException<T extends Object?> implements Exception {
  /// Create a [RouterException]
  const RouterException({
    this.error,
    this.devDescription,
    this.stackTrace,
  });

  /// The original error or a short error name for a quick look at what happened.
  final T? error;

  /// More descriptions can be printed on the console for more information on this error.
  final Object? devDescription;

  /// The [StackTrace], where the error is thrown.
  final StackTrace? stackTrace;

  String get _consoleString {
    final buffer = StringBuffer();
    buffer.write('$runtimeType:');
    devDescription?.let(buffer.write);
    error?.let(buffer.writeln);
    stackTrace?.let(buffer.writeln);
    return buffer.toString().trim();
  }

  @override
  String toString() => _consoleString;
}

/// A [PathNotFoundException] throws when can not find any [RouteBase] in [ROwletNavigationService] matches the path and no routeNotFound in this [ROwletNavigationService].
class PathNotFoundException extends RouterException<String> {
  /// Create [PathNotFoundException]
  const PathNotFoundException({
    super.devDescription,
    super.error,
    super.stackTrace,
  });
}

/// A [DuplicatePathException] throws when has 2 [RouteBuilder] with the same fullRoute in [ROwletNavigationService.routeBase].
/// - What is this:
/// Only one [RouteBuilder] with a determined path in [ROwletNavigationService.routeBase]. But the [RouteBase] can have
/// the same path (an instance of [RouteBase] but not an instance of [RouteBuilder]).
/// [ROwletNavigationService.findRoute] will prioritize to find a [RouteBuilder] matched, if can not, a [RouteBase] will be considered.
/// If there are multiple [RouteBase] with the same path, the first result will be returned.
class DuplicatePathException extends RouterException<String> {
  /// Create [PathNotFoundException]
  const DuplicatePathException({
    super.devDescription,
    super.error,
    super.stackTrace,
  });
}

/// A [InvalidRouteException] throws when an instance [RouteBase] is defined in two difference parents.
///
/// Example:
///```
/// // duplicate route in one parent
///
/// class RouteBaseImpl extends RouteBase {
///   RouteBaseImpl(super.path);
///
///   final route = RouteBase('/');
///
///   @override
///   List<RouteBase> get routes => [route, route];
/// }
/// // or an instance route in two difference parent
/// final route = RouteBase('/');
///
/// class RouteBaseImpl2 extends RouteBase {
///   RouteBaseImpl2(super.path);
///
///   @override
///   List<RouteBase> get routes => [route];
/// }
///
/// class RouteBaseImpl3 extends RouteBase {
///   RouteBaseImpl3(super.path);
///
///   @override
///   List<RouteBase> get routes => [route];
/// }
///
///```
class InvalidRouteException extends RouterException<String> {
  /// Create [InvalidRouteException]
  const InvalidRouteException({
    super.devDescription,
    super.error,
    super.stackTrace,
  });
}
