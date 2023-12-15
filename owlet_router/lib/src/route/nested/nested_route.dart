// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 22/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of 'nested.dart';

///
/// Similar to a nested navigator, nested routes facilitate the division of a route into two components.
/// The actual route gets injected into the navigation service, while the remaining segment serves as an argument for the page widget.
class NestedRoute<R extends RouteBuilderMixin> extends GuardProxyRoute<R>
    with RouteNotifier {
  ///
  /// Create a new [NestedRoute].
  NestedRoute({
    required super.route,
    this.awareExists = true,
  });

  ///
  /// If the [awareExists] flag is set to true and the route already exists in the [Navigator],
  /// [NestedRoute] will abstain from pushing the route and instead notify the value.
  final bool awareExists;

  @override
  RouteGuardFunction? get routeGuard => (context, it, route) {
        updateRouteSettings(route.settings);
        if (awareExists && service.history.containsName(path)) {
          return CancelledRoute();
        }
        return null;
      };
}
