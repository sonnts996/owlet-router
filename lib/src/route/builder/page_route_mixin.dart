/*
 Created by Thanh Son on 03/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of route_builder;

/// Return the page widget with a [settings].
/// The [settings] contained the route and arguments.
typedef PageBuilder = Widget Function(BuildContext context, RouteSettings settings);

/// To implement a [PageRoute] within [RouteBuilder], some fields are required. The [PageRouteMixin] provides the interface for this.
mixin PageRouteMixin {
  /// returns a page widget with [RouteSettings]
  PageBuilder? get pageBuilder;

  /// maps to [PageRoute.maintainState]
  bool get maintainState;

  /// maps to [PageRoute.fullscreenDialog]
  bool get fullscreenDialog;

  /// maps to [PageRoute.allowSnapshotting]
  bool get allowSnapshotting;
}
