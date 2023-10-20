/*
 Created by Thanh Son on 26/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:objectx/objectx.dart';

/// Logging the current routes list with the last route in the list is the top route.
mixin HistoryBase on NavigatorObserver implements Listenable {

  /// Logging the current routes list with the last route in the list is the top route.
  List<Route> get routes;

  /// The top of routes.
  Route get current => routes.last;

  /// Return true if any route in list have the [routeName]. It ignores the path parameters.
  bool contains(String routeName) =>
      routes.any((element) => element.settings.name?.let((it) => Uri.tryParse(it)?.path == routeName) ?? false);

  /// Return the nearest route from the [current].
  /// Return null if it can not be found.
  /// [skipCurrent] will ignore the current route if it is a match.
  RouteFinder? nearest(bool Function(Route e) condition, {bool skipCurrent = false}) {
    var i = 0;
    for (var r in routes.reversed) {
      if (skipCurrent && r == current) break;
      if (condition(r)) {
        return RouteFinder(r, i);
      }
      i++;
    }
    return null;
  }

  @override
  String toString() => '$runtimeType: ${routes.length} \n${routes.map((e) => '- ${e.settings}').join('\n')}';
}

/// The finder's route result contains a [route] and position of it. If [position] == 0, the [route] is current.
class RouteFinder {

  /// The finder's route result contains a [route] and position of it. If [position] == 0, the [route] is current.
  const RouteFinder(this.route, this.position);

  /// The route result, which found.
  final Route route;

  /// The position of [route] from the current, if [position] == 0, the [route] is current
  final int position;
}
