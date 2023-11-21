// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 21/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of route_base;

/// This object enables the nesting of one route within another.
/// In some cases, a route (such as RouteGuard or NestedService) will not directly construct a route.
/// Instead, it will perform intermediary steps before constructing the final route.
/// The [NestedRoute] component can facilitate the management of nested routes, including preventing excessively deep nesting.
///
abstract class NestedRoute<R extends RouteMixin> extends RouteBase with BuildableRouteMixin {
  /// The [NestedRoute]'s constructor
  NestedRoute({required this.route}) : super(route.segment);

  /// The nested route
  R route;
}
