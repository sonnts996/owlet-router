/*
 Created by Thanh Son on 26/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/widgets.dart';
import 'package:objectx/objectx.dart';

import 'route_index.dart';

/// Logging the current routes as list.
/// The last route in the list is the top route.
mixin RouteHistory on NavigatorObserver implements Listenable {
  /// Logging the current routes as list.
  List<Route> get routes;

  /// The top of routes.
  Route get current => routes.last;

  /// Return true if any route in the list has a name which is [routeName]. It does not include the parameters.
  bool contains(String routeName) =>
      routes.any((element) => element.settings.name?.let((it) => Uri.tryParse(it)?.path == routeName) ?? false);

  /// Return the nearest route from the [current].
  /// Return null if it can not be found.
  /// [skipCurrent] will ignore the current route if it is a match.
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
