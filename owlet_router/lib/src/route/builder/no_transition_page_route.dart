/*
 Created by Thanh Son on 27/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of 'builder.dart';

///
/// Construct a [PageRoute] without effects when pushing.
class NoTransitionPageRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin {
  ///
  /// The [NoTransitionPageRoute]'s constructor.
  NoTransitionPageRoute({
    required this.builder,
    super.allowSnapshotting,
    super.fullscreenDialog,
    super.settings,
    this.maintainState = true,
  });

  @override
  final bool maintainState;

  ///
  /// Builds the primary contents of the route.
  final WidgetBuilder builder;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      child;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => Duration.zero;

  @override
  Widget buildContent(BuildContext context) => builder(context);
}
