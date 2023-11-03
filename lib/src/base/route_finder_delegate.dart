/*
 Created by Thanh Son on 31/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/widgets.dart';

import '../../router.dart';

/// Provides the method to find a route in the router that matches to path.
abstract class RouteFinderDelegate {
  /// Provides the method to find a route in the router that matches to path.
  RouteFinderDelegate({
    this.trailingSlash = true,
  });

  /// - In case [trailingSlash] is true and the URL with a trailing slash:
  ///   If the result is not found, a route without a trailing slash is replaced to continue finding.
  ///   Finally, if there is nothing to match, the null value will be returned.
  /// - If the Url is without a trailing slash:
  ///   A route without a trailing splash is the priority,
  ///   next is the route with a trailing splash, and finally this null value.
  /// - Otherwise, ([trailingSlash] is false), an exact URL must be used.
  final bool trailingSlash;

  /// Returns root which matches to path.
  ///
  /// Returns a route matching this path (ignore query parameters)
  ///
  /// - In case [trailingSlash] is true and the URL with a trailing slash:
  ///   If the result is not found, a route without a trailing slash is replaced to continue finding.
  ///   Finally, if there is nothing to match, the null value will be returned.
  /// - If the Url is without a trailing slash:
  ///   A route without a trailing splash is the priority,
  ///   next is the route with a trailing splash, and finally this null value.
  /// - Otherwise, ([trailingSlash] is false), an exact URL must be used.
  ///
  /// - Only one launch-able [Route] with a determined path in [root]. But the [root] can have multi [RouteMixin]
  /// with the same path (an instance of [RouteMixin] with [RouteMixin.canLaunch] is false).
  /// [find] will prioritize to find a launch-able [Route] matched, if can not found, a non-launch-able [Route] will be considered.
  /// - If there are multi non-launch-able [Route] with the same path, the first result will be returned.
  RouteMixin? find(covariant RouteMixin root, String path);

  /// Call to scan and build router in the route tree
  void apply(covariant RouteMixin root);
}
