/*
 Created by Thanh Son on 26/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of owlet_router;

/// The result of [RouteHistory.nearest] includes a route and its corresponding position.
/// When the position is equal to 0, the route is the current route.
class RouteIndex {
  ///
  /// The [RouteIndex]'s constructor
  const RouteIndex(this.route, this.position);

  ///
  /// The route which found.
  final Route route;

  ///
  /// The position of the [route] relative to the current route. If the position is equal to 0, the route is the current route.
  final int position;
}

///
/// Log the current route stack as a list, with the last route in the list being the top-most route.
mixin RouteHistory on NavigatorObserver implements Listenable {
  ///
  /// The current routes.
  List<Route> get routes;

  ///
  /// The top of routes.
  Route get current => routes.last;

  /// Return true if the [current] route has the path which is [routeName]
  bool isCurrentByName(String routeName) => compareName(current.settings.name, routeName);

  /// Determine if any route in the list has a name matching [routeName]. This check excludes route parameters.
  bool containsName(String routeName) => routes.any((element) => compareName(element.settings.name, routeName));

  ///
  /// Find the route closest to the current route. If no matching route is found, return null.
  /// The [skipCurrent] parameter, when set to true, will exclude the current route from the search, even if it matches the specified criteria.
  RouteIndex? nearest(bool Function(Route e) condition, {bool skipCurrent = false}) {
    var i = 0;
    for (var r in routes.reversed) {
      if (skipCurrent && r == current) break;
      if (condition(r)) {
        return RouteIndex(r, i);
      }
      i++;
    }
    return null;
  }

  @override
  String toString() => '$runtimeType: ${routes.length} \n${routes.map((e) => '- ${e.settings}').join('\n')}';
}
