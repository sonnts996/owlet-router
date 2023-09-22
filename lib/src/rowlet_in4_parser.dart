/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of owlet_router;

/// A [RouteInformationParser] to parse between RouteBase and RouteInformation
class ROwletInformationParser extends RouteInformationParser<RouteBase> {
  /// Create a [ROwletInformationParser]. Which requires a NavigationService to find the route match [RouteInformation].
  ROwletInformationParser({required this.service});

  /// Provide the finder to find [RouteBase] from [RouteInformation]
  final ROwletNavigationService service;

  @override
  Future<RouteBase> parseRouteInformation(RouteInformation routeInformation) async =>
      service.findRoute(routeInformation.uri.path);

  @override
  RouteInformation? restoreRouteInformation(RouteBase configuration) =>
      RouteInformation(uri: Uri.parse(configuration.path));
}
