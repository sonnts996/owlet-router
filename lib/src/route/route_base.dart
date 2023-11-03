// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 30/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
library route_base;

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:objectx/objectx.dart';

import '../advance/navigation_service_provider.dart';
import '../base/navigation_service.dart';
import '../base/route_mixin.dart';
import '../exceptions.dart';

part 'extension/route_list_out.dart';
part 'extension/router_extension.dart';
part 'route_builder.dart';
part 'route_set.dart';

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
  RouteBase(this.segment) : assert(segment.startsWith('/'), 'Path must be start with /');

  /// The root route's path should be '/'.
  RouteBase.root([this.segment = '/']);

  /// Returns the [RouteBase] if it exists in the [context].
  /// The [depthSearch] allows the finder deep search within a tree model to find the first branch that matches the [R] data type
  static R? maybeOf<R extends RouteBase>(BuildContext context, {bool depthSearch = false}) {
    final root = NavigationServiceProvider.maybeOf(context)?.root;
    if (!depthSearch) return root.castTo<R?>();
    if (root == null) return null;
    if (root is R) return root;

    R? find(RouteMixin base) {
      R? result;
      for (var e in base.children) {
        if (e is R) {
          result = e;
          break;
        }
        result = find(e);
      }
      return result;
    }

    return find(root);
  }

  /// Returns the [RouteBase] if it exists in the [context]. But it will be thrown an error if the [NavigationService] not found.
  /// The [depthSearch] allows the finder deep search within a tree model to find the first branch that matches the [R] data type
  static R of<R extends RouteBase>(BuildContext context, {bool depthSearch = false}) {
    final result = maybeOf<R>(context, depthSearch: depthSearch);
    assert(result != null, 'No $R found in context');
    return result!;
  }

  @override
  final String segment;

  RouteBase? _parent;

  @override
  RouteBase? get parent => _parent;

  @override
  String get path {
    assert(segment.startsWith('/'), 'Path must be start with /');
    return parent.letOrNull(
      (it) {
        if (it.segment == '/') return segment;
        return '${it.path}$segment';
      },
      onNull: () => segment,
    );
  }

  /// Set the parent for this route.
  /// If the [parent] is this route's parent, nothing happens.
  /// If this route's parent is null, the parent will be applied.
  /// Otherwise, an exception will be thrown, cause the route had a parent.
  void apply(RouteBase? parent) {
    if (this.parent != null && this.parent != parent) {
      throw InvalidRouteException(
          error: '${toString()} already has a parent (${this.parent.toString()}.'
              "Can not use an instance route in more than a parent route. Let's create another instance of this.");
    }
    _parent = parent;
  }

  @override
  List<RouteBase> get children => [];

  @override
  bool isRoute(Route route) => route.settings.name?.let(Uri.tryParse)?.path == path;

  @override
  Uri get uri => Uri.parse(path);

  @override
  bool match(Uri uri) => uri.path == path;

  @override
  bool get canLaunch => false;

  @override
  bool get isCallback => false;
}
