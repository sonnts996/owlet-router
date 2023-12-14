// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 03/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of 'builder.dart';

///
/// Convert a [RouteBuilder] into a [NoTransitionPageRoute]
mixin ConvertToNoTransitionBuilderMixin<A extends Object?, T extends Object?> on RouteBuilder<A, T>, PageRouteMixin {
  ///
  /// Convert a [RouteBuilder] into a [NoTransitionPageRoute]
  NoTransitionPageRoute<T>? noAnimationBuilder([A? args]) => pageBuilder?.let(
        (it) => NoTransitionPageRoute<T>(
          builder: (context) => it(context, RouteSettings(name: path, arguments: args)),
          allowSnapshotting: allowSnapshotting,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
          settings: RouteSettings(name: path, arguments: args),
        ),
      );
}
