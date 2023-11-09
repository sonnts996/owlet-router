// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/widgets.dart';

import '../../router.dart';

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
  /// If this route has children, all it's children must be defined in the returned list.¬

  List<RouteMixin> get children;

  /// Return this route's [path] as [Uri]
  Uri get uri;

  /// Return the final route's path, which contains the [parent]'s route and this [segment].
  /// If not have the [parent], only this [segment] is returned.
  String get path;

  @override
  String toString() => '$runtimeType($path)';

  /// Compare this [path] with the [route.settings.name], and return true if the router path is the same.
  bool isRoute(Route route);

  /// Returns true if this route has the path matches to [uri]
  bool match(Uri uri);

  /// Returns true if this route has action such as build a page or call a callback
  bool get canLaunch;

  /// Return false if this route is a callback route, which can not return any PageRoute.
  /// __Note:__ It always returns true in route guard, although it (route guard) can prevent from opening a route.
  bool get isCallback;

  /// Repairs a route tree. If the [deep] flag is false, only its children are repaired. Otherwise, the function will recursively apply the repair to all its branches in the tree.
  void repair({bool deep = false});
}
