/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of router_service;

/// Create [RouterDelegate] with [RouteBuilder].
/// If the route path is not found, a [NavigationServiceImpl.unknownRoute] will be returned.
/// If the route is located or can not be built, an exception with the thrown.
class OwletDelegate extends RouterDelegate<RouteBuilder> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  /// The [OwletDelegate]'s constructor.
  OwletDelegate({required this.service});

  /// This provides for router owlet information.
  final NavigationService service;

  RouteBuilder? _currentConfiguration;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => service.navigationKey;

  @override
  Widget build(BuildContext context) => RootNavigationServiceProvider(
      service: service,
      child: OwletNavigator(
        key: service.navigationKey,
        initialRoute: service.initialRoute,
        observers: <NavigatorObserver>[service.history, ...service.routeObservers],
        onGenerateRoute: service.onGenerateRoute,
        onPopPage: service.onPopPage,
        onUnknownRoute: service.onUnknownRoute,
      ));

  @override
  RouteBuilder? get currentConfiguration => _currentConfiguration;

  @override
  Future<void> setNewRoutePath(RouteBuilder configuration) async {
    _currentConfiguration = configuration;
    notifyListeners();
  }
}
