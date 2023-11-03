/*
 Created by Thanh Son on 27/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of route_builder;

/// Create a page route without effects when pushing.
class NoTransitionPageRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin {
  /// The [NoTransitionPageRoute]'s constructor, required the page's [builder].
  NoTransitionPageRoute(
      {super.allowSnapshotting,
      super.fullscreenDialog,
      super.settings,
      this.maintainState = true,
      required this.builder});

  @override
  final bool maintainState;

  /// When the route is created, the [builder] will be called to build the widget which is displayed on the screen.
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
