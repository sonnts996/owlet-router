/*
 Created by Thanh Son on 06/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of router_service;

/// Extension for [NavigationService] to shorter method push new page route with it's context.
///
/// Example:
/// ```
/// Navigator.of(context).pushNamed(yourRoot.home.path); // Classic method
/// yourRoot.home.pushNamed(context); // New method
/// ```
extension NavigationServiceExtension on NavigationService {
  /// Returns the navigationKey.currentContext of this service.
  BuildContext? get context => navigationKey.currentContext;

  /// Maps to [Navigator.pushNamed] with [T] type of result and the [NavigationService]'s context.
  Future<T?> pushNamed<T extends Object?>({Object? args, String path = '/', RouteBuilder<Object?, T>? route}) {
    final finalPath = route?.path ?? path;
    return Navigator.of(context!).pushNamed<T>(finalPath, arguments: args);
  }

  /// Map to [Navigator.pushReplacementNamed] with [T] type of result the [NavigationService]'s context.
  Future<T?> pushReplacementNamed<T extends Object?, T0 extends Object?>(
      {T0? result, Object? args, String path = '/', RouteBuilder<Object, T>? route}) {
    final finalPath = route?.path ?? path;
    return Navigator.of(context!).pushReplacementNamed<T, T0>(finalPath, arguments: args, result: result);
  }

  /// New [Navigator.pushNamedAndRemoveUntil] with [T] type of result and the [NavigationService]'s context.
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(bool Function(Route<dynamic>) predicate,
      {Object? args, String path = '/', RouteBuilder<Object?, T>? route}) {
    final finalPath = route?.path ?? path;
    return Navigator.of(context!).pushNamedAndRemoveUntil<T>(finalPath, predicate, arguments: args);
  }

  /// New [Navigator.popAndPushNamed] with [T] type of result and the [NavigationService]'s context.
  Future<T?> popAndPushNamed<T extends Object?, T0 extends Object?>(
      {Object? args, T0? result, String path = '/', RouteBuilder<Object?, T>? route}) {
    final finalPath = route?.path ?? path;
    return Navigator.of(context!).popAndPushNamed<T, T0>(finalPath, arguments: args, result: result);
  }

  /// New [Navigator.restorablePushNamed] with [T] type of result and the [NavigationService]'s context.
  String restorablePushNamed<T extends Object?>({Object? args, String path = '/', RouteBuilder<Object, T>? route}) {
    final finalPath = route?.path ?? path;
    return Navigator.of(context!).restorablePushNamed<T>(finalPath, arguments: args);
  }

  /// New [Navigator.restorablePushReplacementNamed] with [T] type of result and the [NavigationService]'s context.
  String restorablePushReplacementNamed<T extends Object?, T0 extends Object?>(
      {T0? result, Object? args, String path = '/', RouteBuilder<Object?, T>? route}) {
    final finalPath = route?.path ?? path;
    return Navigator.of(context!).restorablePushReplacementNamed<T, T0>(finalPath, arguments: args, result: result);
  }

  /// New [Navigator.restorablePushNamedAndRemoveUntil] with [T] type of result and the [NavigationService]'s context.
  String restorablePushNamedAndRemoveUntil<T extends Object?>(bool Function(Route<dynamic>) predicate,
      {Object? args, String path = '/', RouteBuilder<Object?, T>? route}) {
    final finalPath = route?.path ?? path;
    return Navigator.of(context!).restorablePushNamedAndRemoveUntil<T>(finalPath, predicate, arguments: args);
  }

  /// New [Navigator.restorablePopAndPushNamed] with [T] type of result and the [NavigationService]'s context.
  String restorablePopAndPushNamed<T extends Object?, T0 extends Object?>(
      {Object? args, T0? result, String path = '/', RouteBuilder<Object?, T>? route}) {
    final finalPath = route?.path ?? path;
    return Navigator.of(context!).restorablePopAndPushNamed<T, T0>(finalPath, arguments: args, result: result);
  }
}
