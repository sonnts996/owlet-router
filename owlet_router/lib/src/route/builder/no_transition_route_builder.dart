// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 03/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of 'builder.dart';

///
/// Construct a route with the [NoTransitionPageRoute].
/// The [RouteBuilder] class also defines the parameter type ([A]) and the result type ([T]) of the route.
/// However, in certain scenarios, the parameter verification mechanism may fail to function properly.
class NoTransitionRouteBuilder<A extends Object?, T extends Object?> extends RouteBuilder<A, T> with PageRouteMixin {
  /// Create the [NoTransitionRouteBuilder] with [PageRoute] options.
  NoTransitionRouteBuilder(
    super.segment, {
    this.pageBuilder,
    this.maintainState = true,
    this.allowSnapshotting = true,
    this.fullscreenDialog = false,
  });

  @override
  final PageBuilder? pageBuilder;

  @override
  final bool maintainState;

  @override
  final bool fullscreenDialog;

  @override
  final bool allowSnapshotting;

  @override
  Route<T>? build(RouteSettings settings) => pageBuilder?.let(
        (it) => NoTransitionPageRoute<T>(
          builder: (context) => it(context, settings),
          allowSnapshotting: allowSnapshotting,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
          settings: settings,
        ),
      );
}
