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
part 'proxy_route.dart';
part 'route_builder.dart';

///
/// A [RouteBase] class represents a path segment that must start with a slash (/).
/// The parent field of a [RouteBase] instance is lazily updated at runtime when it has been defined in [RouteBase.children].
/// A [RouteBase] instance can only have one parent; attempting to update an existing [RouteBase.parent] property to a new value will result in an error.
class RouteBase extends RouteMixin {
  ///
  /// Create a new route segment by defining its path. The path must begin with a slash (/).
  RouteBase(this.segment)
      : assert(segment.startsWith('/'), 'Segment must be start with / and without parameter or fragment') {
    children.forEach(_apply);
  }

  ///
  /// A root route should be represented by a single slash (/), and its constructor behaves the same as the standard constructor.
  RouteBase.root([this.segment = '/']) {
    children.forEach(_apply);
  }

  ///
  /// This function efficiently locates a [RouteMixin] instance based on its type within the context.
  /// It systematically traverses the route tree and returns the first matching route.
  /// Consequently, the algorithm's worst-case complexity is O(n), where n represents the depth of the route tree.
  ///
  /// If the target route is known to reside within the root route, setting the [useRoot] parameter to true will expedite the search process.
  /// When the [deepSearch] flag is set to false, the search is restricted to the nearest [NavigationService].
  /// Conversely, if [deepSearch] is set to true, the search encompasses all [NavigationService] instances within the context.
  /// In this scenario, the worst-case algorithm complexity becomes O(n * k),
  /// where n represents the average depth of the route tree and k represents the number of [NavigationService] layers.
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

  ///
  /// This function efficiently locates a [RouteMixin] instance based on its type within the context.
  /// It systematically traverses the route tree and returns the first matching route.
  /// Consequently, the algorithm's worst-case complexity is O(n), where n represents the depth of the route tree.
  ///
  /// If the target route is known to reside within the root route, setting the [useRoot] parameter to true will expedite the search process.
  /// When the [deepSearch] flag is set to false, the search is restricted to the nearest [NavigationService].
  /// Conversely, if [deepSearch] is set to true, the search encompasses all [NavigationService] instances within the context.
  /// In this scenario, the worst-case algorithm complexity becomes O(n * k),
  /// where n represents the average depth of the route tree and k represents the number of [NavigationService] layers.
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

  static final _segmentRegex = RegExp(r'^/[^?#]+$');

  @override
  String get path {
    assert(segment == '/' || _segmentRegex.hasMatch(segment),
        '$segment: A route segment must begin with a slash (‘/’) and should not contain any parameters or fragment.');
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
      '$path${mapToQueryParameter(args, encode: encode, fragment: fragment)}';

  void _apply(RouteMixin child) {
    assert(
        child.parent == null || child.parent == this,
        'The $child is already associated with the ${child.parent}.'
        'A child component cannot be associated with multiple parent components.');

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
