/*
 Created by Thanh Son on 30/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/widgets.dart';

import 'route_history.dart';

/// The [RouteHistory.nearest]'s result contains a [route] and position of it. If [position] == 0, the [route] is current.
class RouteIndex {
  /// The [RouteIndex]'s constructor
  const RouteIndex(this.route, this.position);

  /// The route which found.
  final Route route;

  /// The position of [route] from the current, if [position] == 0, the [route] is current
  final int position;
}
