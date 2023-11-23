// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 22/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of route_builder;

///
/// Similar to a nested navigator, nested routes facilitate the division of a route into two components.
/// The actual route gets injected into the navigation service, while the remaining segment serves as an argument for the page widget.
class NestedRoute<R extends RouteBuilder> extends ProxyRoute<R>
    with ChangeNotifier
    implements ValueListenable<RouteSettings?> {
  ///
  /// Create a new [NestedRoute].
  /// If the [awareExists] flag is set to true and the route already exists in the [Navigator],
  /// [NestedRoute] will abstain from pushing the route and instead notify the value.
  NestedRoute({
    required super.route,
    this.awareExists = true,
  });

  ///
  /// If the [awareExists] flag is set to true and the route already exists in the [Navigator],
  /// [NestedRoute] will abstain from pushing the route and instead notify the value.
  final bool awareExists;

  @override
  RouteSettings? get value => _settings;

  RouteSettings? _settings;

  @override
  Route<Object?>? build(RouteSettings settings) => route.build(RouteGuardSettings(
        name: settings.name,
        arguments: settings.arguments,
        routeGuard: (context, route) async {
          var finalRoute = route.settings.name!.replaceFirst(segment, '');
          if (!finalRoute.startsWith('/')) finalRoute = '/$finalRoute';
          _settings = settings;
          notifyListeners();

          if (awareExists && service.history.contains(path)) {
            return CancelledRoute();
          }
          return null;
        },
      ));
}
