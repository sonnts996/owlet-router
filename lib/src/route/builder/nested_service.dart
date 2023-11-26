// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 10/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of route_builder;

/// In case using multiple [NavigationService], this route will create a link between the route's [NavigationService] with [NestedService.nestedService].
/// If this route does not exist in Navigator, it will be opened. Else, the route will be passed into [NestedService.nestedService].
/// The duplicate or start with route with [NestedService.path] will be ignored.
class NestedService<R extends RouteBuilder, S extends RouteBase> extends NestedRoute<R> implements ProxyRoute<R> {
  /// The [NestedService]'s constructor
  NestedService({required this.nestedService, required super.route});

  ///  The linked service for a link to this route's service.
  final NavigationService<S> nestedService;

  @override
  Route<Object?>? build(RouteSettings settings) => route.build(RouteGuardSettings(
        name: settings.name,
        arguments: settings.arguments,
        routeGuard: (context, route) async {
          if (!service.history.contains(path)) {
            return null;
          }
          var finalRoute = route.settings.name!.replaceFirst(segment, '');
          if (!finalRoute.startsWith('/')) finalRoute = '/$finalRoute';
          final result = await nestedService.pushNamed(finalRoute, args: route.settings.arguments);
          return CancelledRoute(result);
        },
      ));
}