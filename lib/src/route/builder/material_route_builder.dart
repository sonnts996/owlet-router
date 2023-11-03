// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 03/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of route_builder;

/// The [RouteBuilder] generates the [MaterialPageRoute].
/// The argument of this route has type is [ARGS]. The [T] is type of the result when pop this route.
class MaterialRouteBuilder<ARGS extends Object?, T extends Object?> extends RouteBuilder<ARGS, T>
    with PageRouteMixin, ConvertToNoTransitionBuilderMixin<ARGS, T> {
  /// Create the  [MaterialRouteBuilder] with [MaterialPageRoute] options.
  MaterialRouteBuilder(
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
  Route<T>? builder(RouteSettings settings) => pageBuilder?.let(
        (it) => MaterialPageRoute<T>(
          builder: (context) => it(context, settings),
          allowSnapshotting: allowSnapshotting,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
          settings: settings,
        ),
      );
}
