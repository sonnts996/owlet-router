/*
 Created by Thanh Son on 31/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import '../../base/route_finder_delegate.dart';
import '../../base/route_mixin.dart';
import '../route_base.dart';

/// When init Router, the finder will be scanned in the route tree.
/// The [StabilityRouteFinder] will record this scan's result and use it to find the route by a path.
class StabilityRouteFinder extends RouteFinderDelegate {
  /// The [StabilityRouteFinder]'s constructor
  StabilityRouteFinder(RouteBase root, {super.trailingSlash}) {
    resetCache(root);
  }

  late RouteSet _routesCache;

  RouteSet _scan(RouteBase root) {
    final result = RouteSet();

    void listOut(RouteBase base) {
      for (var e in base.children) {
        result.add(e);
        listOut(e);
      }
    }

    result.add(root);
    listOut(root);
    return result;
  }

  @override
  void resetCache(RouteBase root) {
    _routesCache = _scan(root);
  }

  @override
  RouteMixin? find(RouteBase root, String path) {
    final uri = Uri.parse(path);
    var route = _routesCache.routeWhere((element) => element.path == uri.path);
    if (route != null) return route;
    if (trailingSlash) {
      final nextPath = (uri.path.endsWith('/')) ? uri.path.substring(0, uri.path.length - 1) : '${uri.path}/';
      route = _routesCache.routeWhere((element) => element.path == nextPath);
    }

    return route;
  }
}
