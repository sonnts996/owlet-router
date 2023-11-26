// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of owlet_router;

///
/// A [RouteBase] class represents a path segment that must start with a slash (/).
/// The parent field of a [RouteBase] instance is lazily updated at runtime when it has been defined in [RouteBase.children].
/// A [RouteBase] instance can only have one parent; attempting to update an existing [RouteBase.parent] property to a new value will result in an error.
abstract class RouteMixin {
  /// This segment's path.
  String get segment;

  ///
  /// Retrieve the parent route of this segment.
  /// If the result is null, it indicates that the segment may not have a parent or the parent route has not been applied yet.
  RouteMixin? get parent;

  ///
  /// This getter must be overridden. If the route has child routes, all child routes must be defined in the returned list.
  List<RouteMixin> get children;

  ///
  /// This function returns the path of this route as a [Uri] object.
  Uri get uri;

  ///
  /// Return the path of the final route, which includes the parent route's path and this segment's path.
  /// If there is no parent route, only the path of this segment is returned. This path excludes query parameters and fragments for clarity.
  String get path;

  ///
  /// Construct the path, including query parameters and fragments.
  /// If the [encode] flag is set to true, the arguments will be encoded using the URL encoder.
  String argsPath(Map<String, Object?> args,
      {bool encode = false, String? fragment});

  @override
  String toString() => '$runtimeType($path)';

  ///
  /// Compare this [path] to the [route.settings.name] property. Return true if the router path matches the provided path.
  bool isRoute(Route route);

  ///
  /// Determine if this route's path matches the provided name.
  bool match(String name);

  ///
  /// Determines if this route has an associated action, such as building a page or invoking a callback.
  bool get canLaunch;

  ///
  /// Return false if this route is a callback route that does not generate a PageRoute.
  /// In route guards, this function always returns true, but the route guard can still prevent route navigation.
  bool get isCallback;

  ///
  /// Rectifies a route tree. If the deep flag is set to false, only its immediate children are repaired.
  /// Otherwise, the function will traverse the entire tree and repair all descendant routes.
  void repair({bool deep = false});

  NavigationService? _rootService;

  ///
  /// Set service for this route, it should be called once when injecting the root route into [NavigationService]
  // ignore: avoid_setters_without_getters
  set _service(NavigationService service) {
    _rootService = service;
  }

  ///
  /// Return the service that manages this route.
  NavigationService get service {
    final result = parent?.let((it) => it.service) ?? _rootService;
    assert(result != null,
        "No found service in this route, maybe it wasn't initialized properly");
    return result!;
  }

  ///
  /// Return false if this route has no associated service or has not been injected into any Navigator (i.e., navigationKey.currentContext is null)
  bool get hasContext =>
      (parent?.let((it) => it.service) ?? _rootService)
          ?.navigationKey
          .currentContext !=
      null;

  ///
  /// Identify the route that corresponds to the object type. The worst-case time complexity of this operation is O(n).
  T? findType<T extends RouteMixin>();
}

///
/// A route can be built (or called to an action)
mixin RouteBuilderMixin<A extends Object?, T extends Object?> on RouteMixin {
  ///
  /// returns the builder to generate the route.
  Route<T>? build(RouteSettings settings);

  @override
  bool get canLaunch => true;

  @override
  bool get isCallback => false;
}
