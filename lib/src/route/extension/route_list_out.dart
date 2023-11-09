/*
 Created by Thanh Son on 31/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of route_base;

/// List out this route and its children. It has no role except to allow Developers to preview router information.
@visibleForTesting
extension RouteListOut on RouteMixin {
  /// List out this route and its children. It has no role except to allow Developers to preview router information.
  @visibleForTesting
  RouteSet listAll() {
    final set = RouteSet();

    set.add(this);
    for (var i in children) {
      set.addAll(i.listAll());
    }
    set.sorted();
    return set;
  }
}
