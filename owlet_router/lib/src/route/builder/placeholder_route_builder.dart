// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 12/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of 'builder.dart';

///
/// At times, the [RouteGuard] solely relies on the route within the [RouteGuard.routeGuard] result.
/// For such cases, the [PlaceholderRouteBuilder] provides a way to map this situation when the [RouteBuilder] doesn't need to specify anything else
class PlaceholderRouteBuilder<A extends Object?, T extends Object?>
    extends NoTransitionRouteBuilder<A, T> {
  ///
  /// The [NoTransitionRouteBuilder] without required [pageBuilder]
  PlaceholderRouteBuilder(
    super.segment, {
    PageBuilder? pageBuilder,
    super.maintainState,
    super.allowSnapshotting,
    super.fullscreenDialog,
  }) : super(pageBuilder: pageBuilder ?? owletDefaultPlaceholder);
}
