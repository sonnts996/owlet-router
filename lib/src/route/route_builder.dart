// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 27/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of route_base;

/// Return the route's builder to build a new page widget with a [settings].
/// The [settings] contained the route and arguments.
typedef RouterBuilder<R> = Route<R>? Function(RouteSettings settings);

/// If the route can build a page, it must be an instance of [RouteBuilder].
/// The argument of this route has type is [ARGS]. The [T] is type of the result when pop this route.
class RouteBuilder<ARGS extends Object?, T extends Object?> extends RouteBase {
  /// Route's [builder] return a [Route] for [Navigator] build this page.
  /// If don't want to define it, can override the [builder] function.
  RouteBuilder(
    super.segment, {
    RouterBuilder<T>? builder,
  }) : _builder = builder;

  final RouterBuilder<T>? _builder;

  /// returns the builder to generate the route.
  Route<T>? builder(RouteSettings settings) => _builder?.let((it) => it(settings));

  @override
  bool get canLaunch => true;

  @override
  bool get isCallback => false;
}
