// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 30/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
library route_base;

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:objectx/objectx.dart';

import '../../router.dart';

part 'extension/route_list_out.dart';
part 'extension/router_extension.dart';
part 'nested_route.dart';
part 'route_builder.dart';

/// Create a route wrapper with it's route path.
/// The [parent] field is a lazy update after running.
/// The parent is the object, which defines this in [RouteBase.children].
///
/// __Note:__ A route can have only one parent,
/// which means, an error will be thrown if update a non-null [RouteBase.parent] to a new value.
class RouteBase extends RouteMixin {
  /// Create new route segment with it's path.
  ///
  /// __Note:__ The the path must be started with '/'.
  RouteBase(this.segment)
      : assert(segment.startsWith('/'), 'Segment must be start with / and without parameter or fragment') {
    children.forEach(_apply);
  }

  /// The root route's path should be '/'.
  RouteBase.root([this.segment = '/']) {
    children.forEach(_apply);
  }

  /// Returns the [RouteMixin] if it have been injected in the Navigator.
  /// It may take some time, the algorithm complexity is O(n) with n as the number of the route tree level.
  static R? maybeOf<R extends RouteMixin>(BuildContext context, {bool useRoot = false, bool deepSearch = false}) {
    final root = context.findRootAncestorStateOfType<NavigatorState>();

    if (useRoot) {
      if (root is OwletNavigatorState) {
        return root.service.route.findType<R>();
      }
    } else if (!deepSearch) {
      final navigator = context.findAncestorStateOfType<OwletNavigatorState>();
      return navigator?.service.route.findType<R>();
    } else {
      var findContext = context;
      do {
        final navigator = findContext.findAncestorStateOfType<OwletNavigatorState>();
        final result = navigator?.service.route.findType<R>();
        if (result != null) {
          return result;
        } else if (navigator != null && navigator != root) {
          findContext = navigator.context;
        } else {
          break;
        }
      } while (true);
    }
    return null;
  }

  /// Returns the [RouteMixin] if it have been injected in the Navigator. But it will be thrown an error if the [NavigationService] not found.
  /// It may take some time, the algorithm complexity is O(n) with n as the number of the route tree level.
  static R of<R extends RouteMixin>(BuildContext context, {bool useRoot = false, bool deepSearch = false}) {
    final result = maybeOf<R>(context, useRoot: useRoot, deepSearch: deepSearch);
    assert(result != null, 'No $R found, maybe it has not been injected in the Navigator');
    return result!;
  }

  @override
  final String segment;

  RouteMixin? _parent;

  @override
  RouteMixin? get parent => _parent;

  @override
  String get path {
    assert(segment.startsWith('/'), 'Segment must be start with / and without parameter or fragment');
    return parent.letOrNull(
      (it) {
        if (it.segment == '/') return segment;
        return '${it.path}$segment';
      },
      onNull: () => segment,
    );
  }

  @override
  String argsPath(Map<String, Object?> args, {bool encode = false, String? fragment}) =>
      '$path?${mapToQueryParameter(args, encode: encode, fragment: fragment)}';

  /// Set the parent for this route.
  /// If the [parent] is this route's parent, nothing happens.
  /// If this route's parent is null, the parent will be applied.
  /// Otherwise, an exception will be thrown, cause the route had a parent.
  void _apply(RouteMixin child) {
    assert(
        child.parent == null || child.parent == this,
        '${child.toString()} already has a parent (${child.parent.toString()}.'
        "Can not use an instance route in more than a parent route. Let's create another instance of this.");

    child.castTo<RouteBase?>()?.let((it) {
      it._parent = this;
    });
  }

  @override
  @mustBeOverridden
  List<RouteMixin> get children => [];

  @override
  bool isRoute(Route route) => route.settings.name?.let(Uri.tryParse)?.path == path;

  @override
  Uri get uri => Uri.parse(path);

  @override
  bool match(String name) {
    final uri = Uri.tryParse(name);
    if (uri == null) return false;
    return uri.path == path;
  }

  @override
  bool get canLaunch => false;

  @override
  bool get isCallback => false;

  @override
  void repair({bool deep = false}) {
    if (deep) {
      for (final e in children) {
        _apply(e);
        e.repair(deep: deep);
      }
    } else {
      children.forEach(_apply);
    }
  }

  @override
  T? findType<T extends RouteMixin>() {
    final queue = <RouteMixin>[this];
    while (queue.isNotEmpty) {
      final route = queue.removeAt(0);
      if (route is T) {
        return route;
      } else {
        queue.addAll(route.children);
      }
    }
    return null;
  }
}
