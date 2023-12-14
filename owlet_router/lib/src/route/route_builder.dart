// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 27/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of 'route_base.dart';

///
/// Build the route with the [RouteSettings].
typedef RouteBuilderFunction<R> = Route<R>? Function(RouteSettings settings);

///
/// Construct a route using its path. Each path must be uniquely associated with a single route.
/// The [RouteBuilder] class also defines the parameter type ([A]) and the result type ([T]) of the route.
/// However, in certain scenarios, the parameter verification mechanism may fail to function properly.
/// The builder function can either be defined directly in the constructor or by overriding the ``Route<T>? build(RouteSettings settings)`` method.
class RouteBuilder<A extends Object?, T extends Object?> extends RouteBase with RouteBuilderMixin<A, T> {
  ///
  /// The builder function can either be defined directly in the constructor or by overriding the ``Route<T>? build(RouteSettings settings)`` method.
  RouteBuilder(
    super.segment, {
    RouteBuilderFunction<T>? builder,
  }) : _builder = builder;

  final RouteBuilderFunction<T>? _builder;

  @override
  Route<T>? build(RouteSettings settings) => _builder?.let((it) => it(settings));
}
