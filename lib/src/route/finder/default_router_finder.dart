/*
 Created by Thanh Son on 31/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import '../../../router.dart';
import '../../exceptions.dart';
import '../route_base.dart';

/// By default, the finder will be scanned in the route tree to find the route, which matches the path.
/// It may take some time, the algorithm complexity is O(n) with n as the number of the route tree level.
class DefaultRouteFinder extends RouteFinderDelegate {
  /// The [DefaultRouteFinder]'s constructor
  DefaultRouteFinder({
    super.trailingSlash,
  });

  /// In cache mode, the finder's result will be cached for the next time.
  factory DefaultRouteFinder.cache({
    bool trailingSlash,
  }) = DefaultFinderWithCache;

  @override
  RouteMixin? find(RouteBase root, String path) {
    final uri = Uri.parse(path);
    if (root.match(uri)) {
      if (root is RouteBuilder) {
        return root;
      }
    }

    var routes = _routeSelector(root, uri.path);
    if (trailingSlash && routes.isEmpty) {
      final nextUri = (uri.path.endsWith('/')) ? uri.path.substring(0, uri.path.length - 1) : '${uri.path}/';
      routes = _routeSelector(root, nextUri);
    }
    if (routes.isEmpty) return null;
    if (routes.length == 1) return routes.first;
    final builders = routes.whereType<RouteBuilder>();
    if (builders.length > 1) {
      throw DuplicatePathException(error: 'Duplicate route found with $path:\n${RouteSet(builders.toList())}');
    }
    return builders.firstOrNull ?? routes.first;
  }

  List<RouteMixin> _routeSelector(RouteBase base, String path) {
    final result = <RouteMixin>[];

    if (base.path == path) {
      result.add(base);
    }
    for (var e in base.children) {
      if (e.path == path) {
        result.add(e);
      } else if (path.startsWith(e.path)) {
        result.addAll(_routeSelector(e, path));
      }
    }
    return result;
  }

  @override
  void resetCache(RouteBase root) {}
}

/// In cache mode, the finder's result will be cached for the next time.
class DefaultFinderWithCache extends DefaultRouteFinder {
  /// The [DefaultFinderWithCache]'s constructor
  DefaultFinderWithCache({super.trailingSlash});

  final Map<String, dynamic> _cache = {};

  @override
  RouteMixin? find(covariant RouteBase root, String path) {
    if (_cache[path] != null) {
      return _cache[path];
    }
    final result = super.find(root, path);
    _cache[path] = result;
    return result;
  }

  @override
  void resetCache(covariant RouteBase root) {
    _cache.clear();
  }
}
