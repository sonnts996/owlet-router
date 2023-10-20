// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 27/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of route_base;

/// Return the route's builder to build a new page widget with a [settings].
/// The [settings] contained the route and arguments.
typedef RouterBuilder<R> = Route<R>? Function(RouteSettings settings);

/// Return the page widget with a [settings].
/// The [settings] contained the route and arguments.
typedef PageBuilder = Widget Function(BuildContext context, RouteSettings settings);

/// If the route can build a page, it must be an instance of [RouteBuilder].
/// The argument of this route has type is [ARGS]. The [T] is type of the result when pop this route.
class RouteBuilder<ARGS extends Object?, T extends Object?> extends RouteSegment {
  /// Create new [RouteSegment] with [path].
  /// Route's [builder] return a [Route] for [Navigator] build this page.
  /// If don't want to define it, can override the [builder] function.
  RouteBuilder(
    super.segmentPath, {
    RouterBuilder<T>? builder,
  }) : _builder = builder;

  final RouterBuilder<T>? _builder;

  /// returns the builder to generate the route.
  Route<T>? builder(RouteSettings settings) => _builder?.let((it) => it(settings));
}

/// The [RouteBuilder] generates the [MaterialPageRoute].
/// The argument of this route has type is [ARGS]. The [T] is type of the result when pop this route.
class MaterialRouteBuilder<ARGS extends Object?, T extends Object?> extends RouteBuilder<ARGS, T>
    with ToNoAnimationBuilderMixin<ARGS, T> {
  /// Create the  [MaterialRouteBuilder] with [MaterialPageRoute] options.
  MaterialRouteBuilder(
    super.segmentPath, {
    this.pageBuilder,
    this.maintainState = true,
    this.allowSnapshotting = true,
    this.fullscreenDialog = false,
  });

  /// returns a page widget with [RouteSettings]
  @override
  final PageBuilder? pageBuilder;

  /// maps to [PageRoute.maintainState]
  @override
  final bool maintainState;

  /// maps to [PageRoute.fullscreenDialog]
  @override
  final bool fullscreenDialog;

  /// maps to [PageRoute.allowSnapshotting]
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

/// The [RouteBuilder] generates the [CupertinoPageRoute].
/// The argument of this route has type is [ARGS]. The [T] is type of the result when pop this route.
class CupertinoRouteBuilder<ARGS extends Object?, T extends Object?> extends RouteBuilder<ARGS, T>
    with ToNoAnimationBuilderMixin<ARGS, T> {
  /// Create the [CupertinoRouteBuilder] with [CupertinoPageRoute] options.
  CupertinoRouteBuilder(
    super.segmentPath, {
    this.pageBuilder,
    this.maintainState = true,
    this.allowSnapshotting = true,
    this.fullscreenDialog = false,
    this.title,
  });

  /// returns a page widget with [RouteSettings]
  @override
  final PageBuilder? pageBuilder;

  /// maps to [PageRoute.maintainState]
  @override
  final bool maintainState;

  /// maps to [PageRoute.fullscreenDialog]
  @override
  final bool fullscreenDialog;

  /// maps to [PageRoute.allowSnapshotting]
  @override
  final bool allowSnapshotting;

  /// maps to [CupertinoPageRoute.title]
  final String? title;

  @override
  Route<T>? builder(RouteSettings settings) => pageBuilder?.let((it) => CupertinoPageRoute<T>(
        builder: (context) => it(context, settings),
        allowSnapshotting: allowSnapshotting,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
        title: title,
      ));
}

/// The [RouteBuilder] to build a page without animation when the page appearance.
/// The argument of this route has type is [ARGS]. The [T] is type of the result when pop this route.
class NoAnimationRouteBuilder<ARGS extends Object?, T extends Object?> extends RouteBuilder<ARGS, T> {
  /// Create the [NoAnimationRouteBuilder] with [PageRoute] options.
  NoAnimationRouteBuilder(
    super.segmentPath, {
    this.pageBuilder,
    this.maintainState = true,
    this.allowSnapshotting = true,
    this.fullscreenDialog = false,
  });

  /// returns a page widget with [RouteSettings]
  final PageBuilder? pageBuilder;

  /// maps to [PageRoute.maintainState]
  final bool maintainState;

  /// maps to [PageRoute.fullscreenDialog]
  final bool fullscreenDialog;

  /// maps to [PageRoute.allowSnapshotting]
  final bool allowSnapshotting;

  @override
  Route<T>? builder(RouteSettings settings) => pageBuilder?.let((it) => NoAnimationPageRoute<T>(
        builder: (context) => it(context, settings),
        allowSnapshotting: allowSnapshotting,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      ));
}

/// Convert a special [RouteBuilder] to [NoAnimationPageRoute]
mixin ToNoAnimationBuilderMixin<ARGS extends Object?, T extends Object?> on RouteBuilder<ARGS, T> {
  /// returns a page widget with [RouteSettings]
  PageBuilder? get pageBuilder;

  /// maps to [PageRoute.maintainState]
  bool get maintainState;

  /// maps to [PageRoute.fullscreenDialog]
  bool get fullscreenDialog;

  /// maps to [PageRoute.allowSnapshotting]
  bool get allowSnapshotting;

  /// Converts a special [RouteBuilder] to [NoAnimationPageRoute].
  NoAnimationPageRoute<T>? noAnimationBuilder([ARGS? args]) => pageBuilder?.let(
        (it) => NoAnimationPageRoute<T>(
          builder: (context) => it(context, RouteSettings(name: path, arguments: args)),
          allowSnapshotting: allowSnapshotting,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
          settings: RouteSettings(name: path, arguments: args),
        ),
      );
}
