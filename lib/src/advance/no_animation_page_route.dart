/*
 Created by Thanh Son on 27/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/material.dart';

/// Create a [Page Route] without effects when pushing.
/// For example, when you push a new detail page.
/// At the same time, if you want to insert a list page below it,
/// let's use [NoAnimationPageRoute] to push the list page in quiet so that only the detail has a new pushing effect.
class NoAnimationPageRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin {
  /// The [NoAnimationPageRoute]'s constructor, required the page's [builder].
  NoAnimationPageRoute(
      {super.allowSnapshotting,
      super.fullscreenDialog,
      super.settings,
      this.maintainState = true,
      required this.builder});

  @override
  final bool maintainState;

  /// The page's builder.
  final WidgetBuilder builder;

  @override
  Widget buildTransitions(
          BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
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
