/*
 Created by Thanh Son on 31/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of route_base;

///
/// The function lists all the routes and their children, which are solely intended for the developer preview of router information.
@visibleForTesting
extension RouteListOut on RouteMixin {
  /// The function lists all the routes and their children, which are solely intended for the developer preview of router information.
  @visibleForTesting
  List<RouteMixin> listAll() {
    final list = <RouteMixin>[];

    list.add(this);
    for (var i in children) {
      list.addAll(i.listAll());
    }
    list.sorted((a, b) => a.path.compareTo(b.path));
    return list;
  }
}
