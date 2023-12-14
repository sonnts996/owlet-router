/*
 Created by Thanh Son on 31/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of 'router_services.dart';

///
/// The finder uses the A* search algorithm to find the route that matches the path.
///
/// If [trailingSlash] is true and the URL has a trailing slash:
///   * If no matching route is found, the search will continue using a URL without a trailing slash.
///   * If no matching route is found after trying both URLs, null will be returned.
///
/// If the URL does not have a trailing slash:
///   * A route without a trailing slash will be prioritized.
///   * If no route without a trailing slash is found, a route with a trailing slash will be considered.
///   * If no matching route is found, null will be returned.
///
/// Otherwise, if [trailingSlash] is false, an exact URL match is required.
///
/// The routes can contain multiple [RouteMixin] instances with the same path, but only one of these instances should be launchable (i.e., have [RouteMixin.canLaunch] set to true).
/// The [find] function will only return a launchable route. If no launchable route is found, null will be returned.
/// If a route segment is found to be a LinkedServiceRoute, it will be returned immediately without further processing of subsequent segments.
class DefaultRouteFinder extends RouteFinderDelegate {
  ///
  /// The [DefaultRouteFinder]'s constructor
  DefaultRouteFinder({
    super.trailingSlash,
  });

  ///
  /// In cache mode, the finder's result will be cached for the next time.
  factory DefaultRouteFinder.cache({
    bool trailingSlash,
  }) = DefaultFinderWithCache;

  @override
  RouteMixin? find(RouteMixin root, String path) {
    final uri = Uri.parse(path);
    final firstPath = uri.path;
    final secondPath = firstPath.endsWith('/') ? firstPath.substring(0, uri.path.length - 1) : '$firstPath/';

    final queue = <RouteMixin>[root];
    while (queue.isNotEmpty) {
      final node = queue.removeAt(0);
      if (node.canLaunch) {
        if (node.path == firstPath || (trailingSlash && node.path == secondPath)) {
          return node;
        }
      }

      for (final e in node.children) {
        if (firstPath.startsWith(e.path) || (trailingSlash && secondPath.startsWith(e.path))) {
          if (e is NestedRoute) {
            return e;
          }
          queue.insert(0, e);
        }
      }
    }
    return null;
  }

  @override
  void resetCache(RouteMixin root) {}
}

///
/// In cache mode, the finder's result will be cached for the next time.
class DefaultFinderWithCache extends DefaultRouteFinder {
  ///
  /// The [DefaultFinderWithCache]'s constructor
  DefaultFinderWithCache({super.trailingSlash});

  final HashMap<String, dynamic> _cache = HashMap();

  @override
  RouteMixin? find(covariant RouteMixin root, String path) {
    if (_cache[path] != null) {
      return _cache[path];
    }
    final result = super.find(root, path);
    _cache[path] = result;
    return result;
  }

  @override
  void resetCache(covariant RouteMixin root) {
    _cache.clear();
  }
}
