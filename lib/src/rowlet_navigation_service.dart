/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of owlet_router;

/// A navigation service is provided for router owlet information.
class ROwletNavigationService<R extends OriginRoute> extends NavigationServiceBase with NavigationServiceMixin {
  /// Create a service, which is provided for router owlet information.
  ROwletNavigationService({
    GlobalKey<NavigatorState>? navigationKey,
    super.routeObservers = const [],
    super.initialRoute = Navigator.defaultRouteName,
    this.unknownRoute,
    required this.routeBase,
    this.trailingSlash = true,
    HistoryBase? history,
  }) : super(
          history: history ?? ROwletHistory(),
          navigationKey: navigationKey ?? GlobalKey(),
        );

  @override
  final RouteBuilder? unknownRoute;

  @override
  final bool trailingSlash;

  @override
  final R routeBase;

  RouterConfig<RouteSegment>? _routerConfig;

  /// returns RouterConfig<RouteSegment> for this app.
  ///
  /// Example:
  /// ```
  ///  MaterialApp.router(routerConfig: navigationService.routerConfig));
  /// ```
  ///
  RouterConfig<RouteSegment> get routerConfig {
    _routerConfig ??= RouterConfig(
      routerDelegate: ROwletDelegate(service: this),
      routeInformationParser: ROwletInformationParser(service: this),
      routeInformationProvider:
          PlatformRouteInformationProvider(initialRouteInformation: RouteInformation(uri: Uri.tryParse(initialRoute))),
    );
    return _routerConfig!;
  }

  /// For Testing, this method returns a list of accepted routes in this [routeBase]
  @visibleForTesting
  List<RouteSegment> allRoute() => routeBase.routes.toList();
}
