/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of router_services;

///
/// Implementing a [RouterDelegate] using [RouteBuilder].
class OwletDelegate<R extends RouteMixin> extends RouterDelegate<RouteBuilder>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  ///
  /// The [OwletDelegate]'s constructor.
  OwletDelegate({required this.service});

  /// The navigation service exposes Owlet Router information.
  final NavigationService<R> service;

  RouteBuilder? _currentConfiguration;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => service.navigationKey;

  @override
  Widget build(BuildContext context) => OwletNavigator(
        service,
        reportsRouteUpdateToEngine: kIsWeb,
      );

  @override
  RouteBuilder? get currentConfiguration => _currentConfiguration;

  @override
  Future<void> setNewRoutePath(RouteBuilder configuration) async {
    _currentConfiguration = configuration;
    notifyListeners();
  }
}
