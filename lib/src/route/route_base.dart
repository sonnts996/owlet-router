// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/
library route_base;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:objectx/objectx.dart';

import '../../rowlet.dart';

part 'route_builder.dart';

part 'route_set.dart';

part 'router_extension.dart';

/// Create a route wrapper with it's route path.
/// The [parent] field is a lazy update after running.
/// The parent is the object, which defines this in [RouteSegment.children].
///
/// Note that a route can have only one parent,
/// which means, an error will be thrown if update a  non-null [RouteSegment.parent] to a new value.
abstract class _RouteBase {
  /// Create new route segment with it's path.
  ///
  /// Note the the path should be started with '/'.
  _RouteBase(this.segmentPath);

  /// This segment's path.
  final String segmentPath;

  /// Return this parent route of this segment.
  /// If null, this may not have a parent or not have applied the parent route yet.
  RouteSegment? get parent;

  /// Must be overridden this getter.
  /// If this route has children, all it's children must be defined in the returned list.¬
  @mustBeOverridden
  List<RouteSegment> get children => [];

  /// Return this route's [path] as [Uri]
  Uri get uri => Uri.parse(path);

  /// Return the final route's path, which contains the [parent]'s route and this [segmentPath].
  /// If not have the [parent], only this [segmentPath] is returned.
  String get path;

  @override
  String toString() => '$runtimeType($path)';

  /// Set the parent for this route.
  /// If the parent is this route's parent, nothing happens.
  /// If this route's parent is null, the parent will be applied.
  /// Otherwise, an exception will be thrown, cause the route had a parent.
  void apply(RouteSegment? parent);

  /// Compare this [path] with the [route.settings.name], and return true if the router path is the same.
  bool isRoute(Route route) => route.settings.name?.let(Uri.tryParse)?.path == path;
}

/// Create a route wrapper with it's route path.
/// The [parent] field is a lazy update after running.
/// The parent is the object, which defines this in [RouteSegment.children].
///
/// Note that a route can have only one parent,
/// which means, an error will be thrown if update a  non-null [RouteSegment.parent] to a new value.
class RouteSegment extends _RouteBase {
  /// Create new route segment with it's path.
  ///
  /// Note the the path should be started with '/'.
  RouteSegment(super.segmentPath) : assert(segmentPath.startsWith('/'), 'Path must be start with /');

  RouteSegment? _parent;

  @override
  RouteSegment? get parent => _parent;

  @override

  /// Return the final route's path, which contains the [parent]'s route and this [segmentPath].
  /// If not have the [parent], only this [segmentPath] is returned.
  String get path {
    assert(segmentPath.startsWith('/'), 'Path must be start with /');
    return parent.letOrNull(
      (it) {
        if (it.segmentPath == '/') return segmentPath;
        return '${it.path}$segmentPath';
      },
      onNull: () => segmentPath,
    );
  }

  /// Set the parent for this route.
  /// If the parent is this route's parent, nothing happens.
  /// If this route's parent is null, the parent will be applied.
  /// Otherwise, an exception will be thrown, cause the route had a parent.
  @override
  void apply(RouteSegment? parent) {
    if (this.parent != null && this.parent != parent) {
      throw InvalidRouteException(
          error: '${toString()} already has a parent (${this.parent.toString()}.'
              "Can not use an instance route in more than a parent route. Let's create another instance of this.");
    }

    _parent = parent;
  }
}

/// The top-level parent of routes. Using the Origin Route to apply the router to all of the route's members.
///  [OriginRoute] provides the [routes] getter, which returns a list of routes in the router.
///
///  There are two modes in the origin route:
///  - In normal mode, every time a new route is pushed, the router generator will be recalled.
///  - Otherwise, in stability mode, the routes will be called once to increase performance when pushing a new route.
class OriginRoute extends RouteSegment {
  /// The Origin route's path should be '/'.
  OriginRoute([String path = '/'])
      : _stability = false,
        super(path) {
    _routesSet = _routes;
  }

  /// Create an origin route with stability mode.
  /// In this mode, the router will be initiated once,
  /// which increases performance when pushing a new page.
  /// Call [commit] if any changes happen to update the router.
  OriginRoute.stabilityMode([String path = '/'])
      : _stability = true,
        super(path) {
    _routesSet = _routes;
  }

  late RouteSet _routesSet;
  final bool _stability;

  /// returns the list of routes in the router.
  RouteSet get routes => _stability ? _routesSet : _routes;

  /// In the stability mode, [routes] returns a singleton of [RouteSet].
  /// which makes all of the changes after initiation be ignored.
  /// Call [commit] method to update new changes.
  void commit() {
    _routesSet = _routes;
  }
}

extension _RouteGenerator on RouteSegment {
  RouteSet get _routes {
    final sets = RouteSet();
    sets.add(this);
    if (children.isNotEmpty) {
      for (final i in children) {
        i.apply(this);
        sets.addAll(i._routes);
      }
    }
    return sets;
  }
}
