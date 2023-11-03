/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:objectx/objectx.dart';

import '../router.dart';

/// Router exception's interface.
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
    devDescription?.let(buffer.writeln);
    error?.let(buffer.writeln);
    stackTrace?.let(buffer.writeln);
    return buffer.toString().trim();
  }

  @override
  String toString() => _consoleString;
}

/// A [DuplicatePathException] throws when has 2 launch-able route with the same [RouteMixin.path] in [NavigationService.root].
///
/// **What is this:**
/// - A launch-able route is a destination route.
///   That means its path is mapped to a determination page. So, can not have a route's path mapped to 2 different pages.
///
/// [NavigationService.findRoute] will prioritize to find a launch-able route matched.
/// If can not found, a non-launch-able route will be considered.
/// If there are multiple non-launch-able routes with the same path, the first result will be returned.
class DuplicatePathException extends RouterException<String> {
  /// Create [DuplicatePathException]
  const DuplicatePathException({
    super.devDescription,
    super.error,
    super.stackTrace,
  });
}

/// A [InvalidRouteException] throws when an instance [RouteMixin] is defined in two difference parents.
///
/// Example:
///```
/// // duplicate route in one parent
///
/// class RouteBaseImpl extends RouteSegment {
///   RouteBaseImpl(super.segmentPath);
///
///   final route = RouteSegment('/');
///
///   @override
///   List<RouteSegment> get routes => [route, route];
/// }
/// // or an instance route in two difference parent
/// final route = RouteSegment('/');
///
/// class RouteBaseImpl2 extends RouteSegment {
///   RouteBaseImpl2(super.segmentPath);
///
///   @override
///   List<RouteSegment> get routes => [route];
/// }
///
/// class RouteBaseImpl3 extends RouteSegment {
///   RouteBaseImpl3(super.segmentPath);
///
///   @override
///   List<RouteSegment> get routes => [route];
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
