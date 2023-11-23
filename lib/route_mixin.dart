// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of owlet_router;

/// Create a route wrapper with it's route path.
/// The [parent] field is a lazy update after running.
/// The parent is the object, which defines this in [RouteBase.children].
///
/// __Note:__ A route can have only one parent,
/// which means, an error will be thrown if update a non-null [RouteBase.parent] to a new value.
abstract class RouteMixin {
  /// This segment's path.
  String get segment;

  /// Return this parent route of this segment.
  /// If null, this may not have a parent or not have applied the parent route yet.
  RouteMixin? get parent;

  /// Must be overridden this getter.
  /// If this route has children, all it's children must be defined in the returned list.
  List<RouteMixin> get children;

  /// Return this route's [path] as [Uri]
  Uri get uri;

  /// Return the final route's path, which contains the [parent]'s route and this [segment].
  /// If not have the [parent], only this [segment] is returned.
  /// This path is clear with out query parameter and fragment
  String get path;

  /// Return the path with the query parameters and fragment
  /// If [encode] is true, the args with be encoded with URL encoder
  String argsPath(Map<String, Object?> args, {bool encode = false, String? fragment});

  @override
  String toString() => '$runtimeType($path)';

  /// Compare this [path] with the [route.settings.name], and return true if the router path is the same.
  bool isRoute(Route route);

  /// Returns true if this route has the path matches to [name]
  bool match(String name);

  /// Returns true if this route has action such as build a page or call a callback
  bool get canLaunch;

  /// Return false if this route is a callback route, which can not return any PageRoute.
  /// __Note:__ It always returns true in route guard, although it (route guard) can prevent from opening a route.
  bool get isCallback;

  /// Repairs a route tree. If the [deep] flag is false, only its children are repaired.
  /// Otherwise, the function will recursively apply the repair to all its branches in the tree.
  void repair({bool deep = false});

  NavigationService? _rootService;

  /// Set service for this route, it should be called once when injecting the root route into [NavigationService]
  // ignore: avoid_setters_without_getters
  set _service(NavigationService service) {
    _rootService = service;
  }

  /// Return the service that manages this route.
  NavigationService get service {
    final result = parent?.let((it) => it.service) ?? _rootService;
    assert(result != null, "No found service in this route, maybe it wasn't initialized properly");
    return result!;
  }

  /// False if this route has not service or not injected into any Navigator (navigationKey.currentContext == null)
  bool get hasContext => (parent?.let((it) => it.service) ?? _rootService)?.navigationKey.currentContext != null;

  /// Return if it or its children have matched this type.
  T? findType<T extends RouteMixin>();
}

/// A route can be built (or called to an action)
mixin RouteBuilderMixin<A extends Object?, T extends Object?> on RouteMixin {
  /// returns the builder to generate the route.
  Route<T>? build(RouteSettings settings);

  @override
  bool get canLaunch => true;

  @override
  bool get isCallback => false;
}
