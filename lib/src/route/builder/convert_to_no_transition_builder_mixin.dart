// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 03/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of route_builder;

/// Convert a special [RouteBuilder] to [NoTransitionPageRoute]
mixin ConvertToNoTransitionBuilderMixin<ARGS extends Object?, T extends Object?>
on RouteBuilder<ARGS, T>, PageRouteMixin {

  /// Converts a special [RouteBuilder] to [NoTransitionPageRoute].
  NoTransitionPageRoute<T>? noAnimationBuilder([ARGS? args]) =>
      pageBuilder?.let(
            (it) =>
            NoTransitionPageRoute<T>(
              builder: (context) => it(context, RouteSettings(name: path, arguments: args)),
              allowSnapshotting: allowSnapshotting,
              maintainState: maintainState,
              fullscreenDialog: fullscreenDialog,
              settings: RouteSettings(name: path, arguments: args),
            ),
      );
}
